import 'package:flutter/material.dart';

class NoItemsInCart extends StatefulWidget {
  const NoItemsInCart({super.key});

  @override
  State<NoItemsInCart> createState() => _NoItemsInCartState();
}

class _NoItemsInCartState extends State<NoItemsInCart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Column(
        children: [
          SizedBox(height: 20),
          Text(
            'No items in cart',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Add items to your cart to see them here',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
