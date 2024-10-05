import 'package:flutter/material.dart';
import 'package:genme_app/screens/cart/widget/cart_item.dart';
import 'package:genme_app/screens/cart/widget/no_items_in_cart.dart';
import 'package:genme_app/widget/custom_app_bar.dart';

final List<Map<String, Object>> itemsList = [
  {
    "name": "Item 1 with too long name that may overflow the container",
    "price": 100,
    "quantity": 1,
  },
  {
    "name": "Item 2",
    "price": 200,
    "quantity": 2,
  },
  {
    "name": "Item 3",
    "price": 300,
    "quantity": 3,
  },
  {
    "name": "Item 3",
    "price": 300,
    "quantity": 3,
  },
  {
    "name": "Item 3",
    "price": 300,
    "quantity": 3,
  },
  {
    "name": "Item 3",
    "price": 300,
    "quantity": 3,
  },
  {
    "name": "Item 3",
    "price": 300,
    "quantity": 3,
  },
  {
    "name": "Item 3",
    "price": 300,
    "quantity": 3,
  },
  {
    "name": "Item 3",
    "price": 300,
    "quantity": 3,
  },
  {
    "name": "Item 3",
    "price": 300,
    "quantity": 3,
  },
  {
    "name": "Item 3",
    "price": 300,
    "quantity": 3,
  },
];

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(
            title: "See your Added items",
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: itemsList
                        .map(
                          (item) => CartItem(
                            name: item['name'].toString(),
                            quantity: item['quantity'].toString(),
                            id: "",
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          // const Expanded(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       NoItemsInCart(),
          //     ],
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 18, 21, 114),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
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
                  const Icon(Icons.arrow_forward, size: 25, color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
