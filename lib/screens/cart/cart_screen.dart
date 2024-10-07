import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:genme_app/screens/cart/widget/cart_item.dart';
import 'package:genme_app/screens/cart/widget/no_items_in_cart.dart';
import 'package:genme_app/services/notification_service.dart';
import 'package:genme_app/widget/custom_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  CartScreenState createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  List<Map<String, dynamic>> itemsList = [];
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  Future<void> _loadCartItems() async {
    setState(() {
      isLoading = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cart = prefs.getStringList('cart');

    if (cart != null) {
      itemsList = cart
          .map((item) => json.decode(item))
          .toList()
          .cast<Map<String, dynamic>>();
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _updateCartItemQuantity(int index, int newQuantity) async {
    // Update the quantity of the item in the list
    itemsList[index]['quantity'] = newQuantity.toString();

    if (newQuantity == 0) {
      itemsList.removeWhere((item) => item['quantity'] == "0");
      List<Map<String, dynamic>> updatedCart = [...itemsList];
      updatedCart.removeWhere((item) => item['quantity'] == 0);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> newCart =
          updatedCart.map((item) => json.encode(item)).toList();
      await prefs.setStringList('cart', newCart);
      setState(() {});
      return;
    }

    // Save updated itemsList back to SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> updatedCart =
        itemsList.map((item) => json.encode(item)).toList();

    await prefs.setStringList('cart', updatedCart);
  }

  Future<void> _placeOrder() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('access_token');

      if (token == null) {
        throw Exception("No access token found");
      }

      List<Map<String, dynamic>> orderItems = itemsList.map((item) {
        return {
          "product_id": item['medicine']['id'],
          "quantity": int.parse(item['quantity']),
        };
      }).toList();

      var response = await http.post(
        Uri.parse(
            'https://genme-app-backend.vercel.app/api/order/client/create/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({"items": orderItems}),
      );
      // print(response.statusCode);
      if (response.statusCode == 201) {
        await prefs.remove('cart');
        setState(() {
          itemsList.clear();
        });

        NotificationService.showSnackBar(
          'Order placed successfully!',
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.green,
          textStyle: const TextStyle(color: Colors.white),
        );
      } else {
        throw Exception("Failed to place order. Error: ${response.body}");
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          errorMessage = error.toString();
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(
            title: "See your Added items",
          ),
          SizedBox(
            height: deviceHeight * 0.02,
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : itemsList.isNotEmpty
                    ? CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: Column(
                              children: itemsList.asMap().entries.map(
                                (entry) {
                                  int index = entry.key;
                                  Map<String, dynamic> item = entry.value;
                                  return CartItem(
                                    name: item['medicine']['name'].toString(),
                                    quantity: item['quantity'].toString(),
                                    id: item['medicine']['id'].toString(),
                                    onQuantityChanged: (newQuantity) {
                                      _updateCartItemQuantity(
                                          index, newQuantity);
                                    },
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                        ],
                      )
                    : const NoItemsInCart(),
          ),
          if (errorMessage != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: deviceWidth * 0.1, vertical: deviceHeight * 0.01),
            child: ElevatedButton(
              onPressed: isLoading || itemsList.isEmpty ? null : _placeOrder,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 18, 21, 114),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Place your Order (${itemsList.length})",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Icon(Icons.arrow_forward,
                      size: 25, color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
