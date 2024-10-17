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
                                              date: DateFormat("dd MMM yyyy")
                                                  .format(order.createdAt),
                                              time: DateFormat('hh:mm a')
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
                          : SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height -
                                    400, // Adjust height as needed
                                child: const Center(
                                  child: Text("No orders available."),
                                ),
                              ),
                            );
                      // : const Center(child: Text("No orders available."));
                    } else if (state is OrdersError) {
                      return SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height -
                              400, // Adjust height as needed
                          child: const Center(
                            child: Text(
                              "Failed to fetch orders.",
                              // state.message,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
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
