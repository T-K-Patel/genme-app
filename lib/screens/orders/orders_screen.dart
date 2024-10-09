import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genme_app/screens/orders/widget/order_card.dart';
import 'package:genme_app/state/orders/orders_bloc.dart';
import 'package:genme_app/widget/custom_app_bar.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch orders only once when the screen loads
    context.read<OrdersBloc>().add(OrderEventFetchData());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const CustomAppBar(title: "Orders"),
            const SizedBox(height: 10),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  // Trigger the refresh event to clear cache and refetch orders
                  context.read<OrdersBloc>().add(OrderEventRefresh());
                },
                child: BlocBuilder<OrdersBloc, OrdersState>(
                  builder: (context, state) {
                    if (state is OrdersLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is OrdersLoaded) {
                      return state.orders.isNotEmpty
                          ? CustomScrollView(
                              slivers: [
                                const SliverToBoxAdapter(
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                  ),
                                ),
                                SliverToBoxAdapter(
                                  child: Column(
                                    children: state.orders
                                        .map((order) => OrderCard(
                                              id: order.id,
                                              date: DateFormat('hh:mm a')
                                                  .format(order.createdAt),
                                              total:
                                                  order.itemsCount.toString(),
                                              status: order.status,
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
                            )
                          : const Center(child: Text("No orders available."));
                    } else if (state is OrdersError) {
                      return Center(child: Text(state.message));
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:genme_app/screens/orders/widget/order_card.dart';
// import 'package:genme_app/state/orders/orders_bloc.dart';
// import 'package:genme_app/widget/custom_app_bar.dart';


// final orderData =[ 
//   {
//     'id': '1',
//     'date': '12-12-2021',
//     'total': '200',
//     'status': 'Delivered',
//   },
//   {
//     'id': '2',
//     'date': '12-12-2021',
//     'total': '200',
//     'status': 'Delivered',
//   },
//   {
//     'id': '3',
//     'date': '12-12-2021',
//     'total': '200',
//     'status': 'Delivered',
//   },
//   {
//     'id': '4',
//     'date': '12-12-2021',
//     'total': '200',
//     'status': 'Delivered',
//   },
//   {
//     'id': '5',
//     'date': '12-12-2021',
//     'total': '200',
//     'status': 'Delivered',
//   },
//   {
//     'id': '6',
//     'date': '12-12-2021',
//     'total': '200',
//     'status': 'Delivered',
//   },
//   {
//     'id': '7',
//     'date': '12-12-2021',
//     'total': '200',
//     'status': 'Delivered',
//   },
//   {
//     'id': '8',
//     'date': '12-12-2021',
//     'total': '200',
//     'status': 'Delivered',
//   },
//   {
//     'id': '9',
//     'date': '12-12-2021',
//     'total': '200',
//     'status': 'Delivered',
//   },
//   {
//     'id': '10',
//     'date': '12-12-2021',
//     'total': '200',
//     'status': 'Delivered',
//   },
// ];

// class OrdersScreen extends StatefulWidget {
//   const OrdersScreen({super.key});

//   @override
//   State<OrdersScreen> createState() => _OrdersScreenState();
// }

// class _OrdersScreenState extends State<OrdersScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Fetch orders when the screen loads
//     context.read<OrdersBloc>().add(FetchOrders());
//   }
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Column(
//           children: [
//             const CustomAppBar(
//               title: "Orders",
//             ),
//             const SizedBox(height: 10),
//             Expanded(
//               child: CustomScrollView(
//                 slivers: [
//                   const SliverToBoxAdapter(
//                     child: Padding(
//                       padding: EdgeInsets.only(bottom: 10),
//                     ),
//                   ),
//                   SliverToBoxAdapter(
//                     child: Column(
//                       children: orderData
//                           .map((data) => OrderCard(
//                                 id: data['id']!,
//                                 date: data['date']!,
//                                 total: data['total']!,
//                         status: data['status']!,
//                               ))
//                           .toList(),
//                     ),
//                   ),
//                   const SliverToBoxAdapter(
//                     child: Padding(
//                       padding: EdgeInsets.only(top: 10),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 10),
//           ],
//         ),
//       ),
//     );
//   }
// }
