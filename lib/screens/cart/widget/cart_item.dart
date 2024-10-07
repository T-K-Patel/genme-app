import 'dart:convert';
import 'package:flutter/material.dart';

class CartItem extends StatefulWidget {
  final String name;
  final String quantity;
  final String id;
  final Function(int) onQuantityChanged; // Callback to update quantity

  const CartItem({
    Key? key,
    required this.name,
    required this.quantity,
    required this.id,
    required this.onQuantityChanged, // Add callback parameter
  }) : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int quantity = 0;

  @override
  void initState() {
    super.initState();
    quantity = int.parse(widget.quantity);
  }

  void _updateQuantity(int delta) {
    setState(() {
      quantity += delta;
      if (quantity < 0) quantity = 0;

      // Call the parent callback to update SharedPreferences
      widget.onQuantityChanged(quantity);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    // final double deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: deviceWidth * 0.04, vertical: deviceWidth * 0.02),
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(
                    fontSize: deviceWidth * 0.044,
                    fontWeight: FontWeight.bold,
                  ),
                  softWrap: true,
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  _updateQuantity(-1);
                },
                icon: const Icon(Icons.remove),
                disabledColor: Colors.grey,
                tooltip: 'Remove',
              ),
              Text(
                quantity.toString(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  _updateQuantity(1);
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
