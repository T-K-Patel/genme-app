import 'package:flutter/material.dart';
import 'package:genme_app/screens/orders/widget/order_card.dart';
import 'package:genme_app/widget/custom_app_bar.dart';


final orderData =[
  {
    'id': '1',
    'date': '12-12-2021',
    'total': '200',
    'status': 'Delivered',
  },
  {
    'id': '2',
    'date': '12-12-2021',
    'total': '200',
    'status': 'Delivered',
  },
  {
    'id': '3',
    'date': '12-12-2021',
    'total': '200',
    'status': 'Delivered',
  },
  {
    'id': '4',
    'date': '12-12-2021',
    'total': '200',
    'status': 'Delivered',
  },
  {
    'id': '5',
    'date': '12-12-2021',
    'total': '200',
    'status': 'Delivered',
  },
  {
    'id': '6',
    'date': '12-12-2021',
    'total': '200',
    'status': 'Delivered',
  },
  {
    'id': '7',
    'date': '12-12-2021',
    'total': '200',
    'status': 'Delivered',
  },
  {
    'id': '8',
    'date': '12-12-2021',
    'total': '200',
    'status': 'Delivered',
  },
  {
    'id': '9',
    'date': '12-12-2021',
    'total': '200',
    'status': 'Delivered',
  },
  {
    'id': '10',
    'date': '12-12-2021',
    'total': '200',
    'status': 'Delivered',
  },
];

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const CustomAppBar(
              title: "Orders",
            ),
            const SizedBox(height: 10),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: orderData
                          .map((data) => OrderCard(
                                id: data['id']!,
                                date: data['date']!,
                                total: data['total']!,
                        status: data['status']!,
                              ))
                          .toList(),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
