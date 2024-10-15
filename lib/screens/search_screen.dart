import 'dart:convert';
import 'package:genme_app/services/notification_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:genme_app/widget/custom_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Medicine {
  final String name;
  final String id;
  final String type;

  Medicine({required this.name, required this.id, required this.type});

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(name: json['name'], type: json['type'], id: json['id']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'type': type,
    };
  }
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var tappedMedicine = "Enter the Name...";
  var id = "";
  var type = "";
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController medicineController = TextEditingController();
  final FocusNode medicineFocusNode = FocusNode();
  final FocusNode quantityFocusNode = FocusNode();

  // Function to store medicine and quantity in shared preferences
  Future<void> _addToCart(Medicine medicine, String quantity) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get the current cart (if exists)
    List<String> cart = prefs.getStringList('cart') ?? [];

    // Create a map to represent the medicine and quantity
    Map<String, dynamic> cartItem = {
      'medicine': medicine.toJson(),
      'quantity': quantity,
      'id': id,
      'type': type,
    };

    // Check if the item is already in the cart
    bool itemExists = cart.any((item) {
      Map<String, dynamic> decodedItem = json.decode(item);
      return decodedItem['medicine']?['id'] == medicine.id;
    });

    if (itemExists) {
      // Show a snackbar if the item is already in the cart
      NotificationService.showSnackBar(
        'Item already in cart',
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.orange,
        textStyle: const TextStyle(color: Colors.white),
      );
    } else {
      medicineController.text = "";
      _quantityController.text = "";
      // Add the new cart item to the existing cart
      cart.add(json.encode(cartItem));

      // Save the updated cart
      await prefs.setStringList('cart', cart).then((success) {
        if (success) {
          NotificationService.showSnackBar(
            'Item added to cart',
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.green,
            textStyle: const TextStyle(color: Colors.white),
          );
        } else {
          NotificationService.showSnackBar(
            'Failed to add item to cart',
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.red,
            textStyle: const TextStyle(color: Colors.white),
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _quantityController.dispose();
    medicineController.dispose();
    medicineFocusNode.dispose();
    quantityFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // Remove focus when tapping outside the TextField
          FocusScope.of(context).unfocus();
        },
        child: Container(
          // Using MediaQuery to take the entire height
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 18, 21, 114),
            shape: BoxShape.rectangle,
          ),
          child: SingleChildScrollView(
            clipBehavior: Clip.none,
            child: Column(
              children: [
                const CustomAppBar(),
                Padding(
                  padding: EdgeInsets.all(deviceWidth * 0.04),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Medicine Name Label
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Name of the Medicine',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: deviceHeight * 0.015),
                      // Medicine Name Input Field
                      TypeAheadField<Medicine>(
                        focusNode: medicineFocusNode,
                        controller: medicineController,
                        debounceDuration: const Duration(milliseconds: 300),
                        suggestionsCallback: (search) async {
                          if (search.length < 3) return null;
                          search = search.toLowerCase();
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          String? accessToken = prefs.getString('access_token');
                          final response = await http.get(
                              Uri.parse(
                                  'https://genme-app-backend.vercel.app/api/inventory/search/?phrase=$search'),
                              headers: {
                                'Authorization': 'Bearer $accessToken',
                              });
                          if (response.statusCode == 200) {
                            // Parse the response as a list of SearchResult objects
                            final List<dynamic> jsonList =
                                json.decode(response.body);
                            final List<Medicine> suggestions = jsonList
                                .map((jsonItem) => Medicine.fromJson(jsonItem))
                                .toList();
                            return suggestions;
                          } else if (response.statusCode == 401 ||
                              response.statusCode == 403) {
                            // prefs.remove("access_token");
                            return [];
                          }
                          return [];
                        },
                        builder: (context, medicineController, focusNode) {
                          return TextField(
                            controller: medicineController,
                            focusNode: focusNode,
                            autofocus: true,
                            decoration: InputDecoration(
                              hintText: "Enter a name...",
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                              ),
                              filled: true,
                              contentPadding: const EdgeInsets.all(16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                              fillColor:
                                  const Color.fromARGB(255, 240, 240, 240),
                            ),
                            keyboardType: TextInputType.text,
                          );
                        },
                        itemBuilder: (context, medicine) {
                          return ListTile(
                            onTap: () {
                              medicineController.text = medicine.name;

                              tappedMedicine = medicine.name;
                              id = medicine.id;
                              type = medicine.type;
                              medicineFocusNode.unfocus();
                              quantityFocusNode.requestFocus();
                            },
                            title: Text(medicine.name),
                          );
                        },
                        onSelected: (medicine) {},
                      ),

                      SizedBox(height: deviceHeight * 0.04),

                      // Quantity Label
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Quantity',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: deviceHeight * 0.015),
                      // Quantity Input Field
                      TextField(
                        focusNode: quantityFocusNode,
                        controller: _quantityController,
                        decoration: InputDecoration(
                          hintText: "Enter quantity...",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                          filled: true,
                          contentPadding: const EdgeInsets.all(16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: const Color.fromARGB(255, 240, 240, 240),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: deviceHeight * 0.05),

                      // Add to Cart Button
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (tappedMedicine != "Enter the Name..." &&
                                _quantityController.text.isNotEmpty) {
                              FocusScope.of(context).unfocus();
                              Medicine selectedMedicine = Medicine(
                                  name: tappedMedicine, id: id, type: type);
                              // Add selected medicine and quantity to the cart

                              _addToCart(
                                  selectedMedicine, _quantityController.text);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              vertical: deviceHeight * 0.012,
                              horizontal: deviceWidth * 0.18,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            'ADD TO CART',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: deviceHeight * 0.02),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
