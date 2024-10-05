import 'package:flutter/material.dart';

class CartItem extends StatefulWidget {
  final String name;
  final String quantity;
  final String id;

  const CartItem({
    super.key,
    required this.name,
    required this.quantity,
    required this.id,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Row(
        children: [
          // Use Expanded to allow the text to wrap
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name, // Use the name passed to the widget
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  softWrap: true, // Allow text to wrap
                ),
              ],
            ),
          ),
          // Keep the buttons right-aligned
          Row(
            children: [
              IconButton(
                onPressed: () {
                  // Handle reduce quantity
                },
                icon: const Icon(Icons.remove),
                disabledColor: Colors.grey,
                tooltip: 'Remove',
              ),
              Text(
                widget.quantity, // Use the quantity passed to the widget
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  // Handle increase quantity
                },
                icon: const Icon(Icons.add),
                color: Colors.green,
                tooltip: 'Add',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
