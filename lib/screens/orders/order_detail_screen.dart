import 'package:flutter/material.dart';

class OrderDetailScreen extends StatefulWidget {
  final String id;
  const OrderDetailScreen({super.key,required this.id});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        title: const Text('Order Detail'),
      ),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text('Order ID: ${widget.id}'),
          const SizedBox(height: 20),
          const Text('Date: 12-12-2021 on early morning'),
          const SizedBox(height: 20),
          const Text('Total: 200'),
          const SizedBox(height: 20),
          const Text('Status: Delivered'),
        ],
      ),
    );
  }
}
