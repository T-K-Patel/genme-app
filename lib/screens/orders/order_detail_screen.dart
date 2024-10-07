import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genme_app/state/orderdetail/order_detail_bloc.dart';
import 'package:genme_app/state/orderdetail/order_detail_event.dart';
import 'package:genme_app/state/orderdetail/order_detail_state.dart';
import 'package:genme_app/models/order_detail_model.dart';
import 'package:genme_app/state/auth/auth_bloc.dart'; // Import AuthBloc
import 'package:genme_app/models/user_profile.dart'; // Import UserProfile
import 'package:intl/intl.dart';

class OrderDetailScreen extends StatelessWidget {
  final String id;

  const OrderDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    // Trigger the FetchOrderDetail event when the screen is built
    // Since caching is handled in the BLoC, this will fetch from cache if available
    context.read<OrderDetailBloc>().add(FetchOrderDetail(id));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Order Detail',
          style: TextStyle(color: Colors.white), // White text
        ),
        backgroundColor: const Color(0xFF0C1172), // Deep blue color for AppBar
        elevation: 0, // To remove shadow under the AppBar
        centerTitle: true, // Center the title
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ), // Rounded bottom corners
      ),
      body: BlocBuilder<OrderDetailBloc, OrderDetailState>(
        builder: (context, orderState) {
          if (orderState is OrderDetailInitial) {
            return const Center(child: Text('Initializing...'));
          } else if (orderState is OrderDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (orderState is OrderDetailLoaded) {
            final OrderDetailModel order = orderState.orderDetail;
            // print(order.invoice.id);

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.02),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFF0C1172), // Thin blue border
                          width: 2.0, // You can adjust the width as needed
                        ),
                        borderRadius:
                            BorderRadius.circular(8), // Rounded corners
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.03),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Image.asset(
                              'assets/genmetext.png',
                              height: screenHeight * 0.08,
                              // Set appropriate height
                            ),

                            // BlocBuilder for User Profile
                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, authState) {
                                if (authState is AuthStateLoggedIn) {
                                  final UserProfile user = authState.user;
                                  final List<OrderItem> items = order.items;
                                  double subtotal = items[0].price == null
                                      ? 0
                                      : items.fold(
                                          0,
                                          (sum, item) =>
                                              sum +
                                              (item.quantity *
                                                  (item.price == null
                                                      ? 0
                                                      : item.price!)),
                                        );
                                  double tax = subtotal * 0.18;
                                  double total = subtotal + tax;

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Billed to',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[700],
                                            fontSize: screenWidth * 0.03),
                                      ),
                                      SizedBox(height: screenHeight * 0.004),
                                      Text(
                                        user.legalName,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: screenWidth * 0.035),
                                      ),
                                      SizedBox(height: screenHeight * 0.004),
                                      Text(
                                        user.address ?? "",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: screenWidth * 0.03),
                                      ),
                                      const Divider(),
                                      Row(
                                        children: [
                                          // Left side content
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Name:",
                                                      style: TextStyle(
                                                          fontSize:
                                                              screenWidth *
                                                                  0.03,
                                                          color:
                                                              Colors.black45),
                                                    ),
                                                    Text(
                                                      user.legalName,
                                                      style: TextStyle(
                                                          fontSize:
                                                              screenWidth *
                                                                  0.033,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                    height:
                                                        screenHeight * 0.003),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "DLN:",
                                                      style: TextStyle(
                                                          fontSize:
                                                              screenWidth *
                                                                  0.03,
                                                          color:
                                                              Colors.black45),
                                                    ),
                                                    Text(
                                                      user.dlNo ?? "",
                                                      style: TextStyle(
                                                          fontSize:
                                                              screenWidth *
                                                                  0.033,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),

                                          VerticalDivider(
                                            color: Colors.black,
                                            thickness: screenWidth * 0.005,
                                            width: screenWidth * 0.035,
                                          ),

                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "GST:",
                                                      style: TextStyle(
                                                          fontSize:
                                                              screenWidth *
                                                                  0.03,
                                                          color:
                                                              Colors.black45),
                                                    ),
                                                    Text(
                                                      user.gstin ?? "",
                                                      style: TextStyle(
                                                          fontSize:
                                                              screenWidth *
                                                                  0.033,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                    height:
                                                        screenHeight * 0.003),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "PAN:",
                                                      style: TextStyle(
                                                          fontSize:
                                                              screenWidth *
                                                                  0.03,
                                                          color:
                                                              Colors.black45),
                                                    ),
                                                    Text(
                                                      user.panNumber ?? "",
                                                      style: TextStyle(
                                                          fontSize:
                                                              screenWidth *
                                                                  0.033,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Divider(),
                                      _buildInvoiceHeader(screenWidth, order),
                                      SizedBox(height: screenHeight * 0.02),
                                      _buildTableHeaders(screenWidth),
                                      const Divider(),
                                      ListView.builder(
                                        itemCount: items.length,
                                        shrinkWrap:
                                            true, // Makes the list expand based on the items
                                        physics:
                                            const NeverScrollableScrollPhysics(), // Disables scrolling
                                        itemBuilder: (context, index) {
                                          final item = items[index];
                                          final amount = item.price == null
                                              ? 0.0
                                              : item.quantity *
                                                  (item.price ?? 5.0);
                                          return _buildTableRow(
                                              item.product,
                                              item.quantity,
                                              item.price ?? 0,
                                              amount,
                                              item.supplied ?? true,
                                              screenWidth);
                                        },
                                      ),
                                      _buildSummarySection(
                                          subtotal, tax, total, screenWidth),
                                      const Divider(),
                                      Center(
                                          child: Text(
                                        "Thank You For the Business !",
                                        style: TextStyle(
                                            color: Colors.black38,
                                            fontSize: screenWidth * 0.04),
                                      ))
                                    ],
                                  );
                                } else if (authState is AuthStateLoading) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (authState is AuthStateLoggedOut) {
                                  return const Center(
                                      child: Text('User is not logged in.'));
                                } else if (authState is AuthStateError) {
                                  return Center(
                                      child: Text(
                                          'Error: ${authState.exception.toString()}'));
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: screenWidth * 0.01),
                    order.invoice != null
                        ? Center(
                            child: TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    vertical: screenWidth * 0.02,
                                    horizontal: screenWidth * 0.04),
                                backgroundColor: const Color(
                                    0xFF1A237E), // Dark blue background color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      12), // Rounded corners
                                ),
                              ),
                              onPressed: () {
                                // Add your download functionality here
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Download the invoice',
                                    style: TextStyle(
                                      color: Colors.white, // White text color
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: screenWidth * 0.01),
                                  const Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : const Text(
                            'Invoice not generated yet',
                            style: TextStyle(
                              color: Colors.black, // White text color
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    SizedBox(height: screenWidth * 0.01),
                  ],
                ),
              ),
            );
          } else if (orderState is OrderDetailError) {
            return Center(child: Text(orderState.message));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildInvoiceHeader(double screenWidth, OrderDetailModel order) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _invoiceColumn('Invoice date',
            DateFormat('d MMMM y').format(order.createdAt), screenWidth),
        _invoiceColumn('Invoice number', '----', screenWidth),
        _invoiceColumn('Reference', '----', screenWidth),
      ],
    );
  }

  Widget _invoiceColumn(String label, String value, double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey, fontSize: screenWidth * 0.03),
        ),
        Text(
          value,
          style: TextStyle(fontSize: screenWidth * 0.035),
        ),
      ],
    );
  }

  Widget _buildTableHeaders(screenWidth) {
    return Row(
      children: [
        Expanded(
            flex: 4,
            child: Text(
              'Item description',
              style: TextStyle(
                  color: Colors.black54, fontSize: screenWidth * 0.035),
            )),
        Expanded(
            flex: 1,
            child: Text(
              'Qty',
              style: TextStyle(
                  color: Colors.black54, fontSize: screenWidth * 0.035),
            )),
        Expanded(
            flex: 2,
            child: Text(
              'Rate',
              style: TextStyle(
                  color: Colors.black54, fontSize: screenWidth * 0.035),
            )),
        Expanded(
            flex: 2,
            child: Text(
              'Amount',
              style: TextStyle(
                  color: Colors.black54, fontSize: screenWidth * 0.035),
            )),
      ],
    );
  }

  Widget _buildTableRow(String itemName, int qty, double rate, double amount,
      bool isSupplied, double screenWidth) {
    return Column(
      children: [
        Container(
          color: isSupplied == false ? Colors.red[100] : null,
          child: Row(
            children: [
              Expanded(
                  flex: 4,
                  child: Text(
                    itemName,
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Text(
                    qty.toString(),
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                    ),
                  )),
              Expanded(
                  flex: 2,
                  child: Text(
                    rate == 0 ? "--" : rate.toStringAsFixed(2),
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                    ),
                  )),
              Expanded(
                  flex: 2,
                  child: Text(
                    amount == 0 ? "--" : amount.toStringAsFixed(2),
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                    ),
                  )),
            ],
          ),
        ),
        const Divider()
      ],
    );
  }

  Widget _buildSummarySection(
      double subtotal, double tax, double total, double screenWidth) {
    return Padding(
      padding:
          EdgeInsets.fromLTRB(screenWidth * 0.35, 0, screenWidth * 0.06, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Subtotal', style: TextStyle(color: Colors.grey)),
              Text(subtotal == 0 ? "--" : subtotal.toStringAsFixed(2)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Tax (18%)', style: TextStyle(color: Colors.grey)),
              Text(tax == 0 ? "--" : tax.toStringAsFixed(2)),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(total == 0 ? "--" : total.toStringAsFixed(2)),
            ],
          ),
          const SizedBox(height: 16.0),
          Container(
            color: Colors.blue.shade900,
            padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total due',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  total == 0 ? "--" : total.toStringAsFixed(2),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(height: screenWidth * 0.04),
          Text(
            'IND Rupee Four Thousand Nine Hundred Fifty Only.',
            style: TextStyle(
              color: Colors.black,
              fontSize: screenWidth * 0.035,
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:genme_app/state/orderdetail/order_detail_bloc.dart';
// import 'package:genme_app/state/orderdetail/order_detail_event.dart';
// import 'package:genme_app/state/orderdetail/order_detail_state.dart';
// import 'package:genme_app/models/order_detail_model.dart';

// class OrderDetailScreen extends StatelessWidget {
//   final String id;

//   const OrderDetailScreen({super.key, required this.id});

//   @override
//   Widget build(BuildContext context) {
//     // Trigger the FetchOrderDetail event when the screen is built
//     // Since caching is handled in the BLoC, this will fetch from cache if available
//     context.read<OrderDetailBloc>().add(FetchOrderDetail(id));

//     return Scaffold(
//       appBar:  AppBar(
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//             onPressed: () {
//               Navigator.pop(context);
//               // Action for back button
//             },
//           ),
//           title: const Text(
//             'Order Detail',
//             style: TextStyle(color: Colors.white), // White text
//           ),
//           backgroundColor: const Color(0xFF0C1172), // Deep blue color for AppBar
//           elevation: 0, // To remove shadow under the AppBar
//           centerTitle: true, // Center the title
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(
//               bottom: Radius.circular(20),
//             ),
//           ), // Rounded bottom corners
//         ),
//       body: BlocBuilder<OrderDetailBloc, OrderDetailState>(
//         builder: (context, state) {
//           if (state is OrderDetailInitial) {
//             return const Center(child: Text('Initializing...'));
//           } else if (state is OrderDetailLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is OrderDetailLoaded) {
//             final OrderDetailModel order = state.orderDetail;
//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Text('Order ID: ${order.id}', style: const TextStyle(fontSize: 18)),
//                   const SizedBox(height: 8),
//                   Text('Date: ${order.date}', style: const TextStyle(fontSize: 16)),
//                   const SizedBox(height: 8),
//                   Text('Total: \$${order.total}', style: const TextStyle(fontSize: 16)),
//                   const SizedBox(height: 8),
//                   Text('Status: ${order.status}', style: const TextStyle(fontSize: 16)),
//                   // Add more details as needed
//                 ],
//               ),
//             );
//           } else if (state is OrderDetailError) {
//             return Center(child: Text(state.message));
//           } else {
//             return const SizedBox.shrink();
//           }
//         },
//       ),
//     );
//   }
// }

// below commented to check ui

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:genme_app/state/orderdetail/order_detail_bloc.dart';
// import 'package:genme_app/state/orderdetail/order_detail_event.dart';
// import 'package:genme_app/state/orderdetail/order_detail_state.dart';

// class OrderDetailScreen extends StatelessWidget {
//   final String id;

//   const OrderDetailScreen({super.key, required this.id});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // Optional: Add AppBar or other UI components as needed
//       appBar: AppBar(
//         title: const Text('Order Details'),
//       ),
//       body: BlocBuilder<OrderDetailBloc, OrderDetailState>(
//         builder: (context, state) {
//           if (state is OrderDetailInitial) {
//             return const Center(child: Text('Initializing...'));
//           } else if (state is OrderDetailLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is OrderDetailLoaded) {
//             final order = state.orderDetail;
//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Text('Order ID: ${order.id}', style: const TextStyle(fontSize: 18)),
//                   const SizedBox(height: 8),
//                   Text('Date: ${order.date}', style: const TextStyle(fontSize: 16)),
//                   const SizedBox(height: 8),
//                   Text('Total: \$${order.total}', style: const TextStyle(fontSize: 16)),
//                   const SizedBox(height: 8),
//                   Text('Status: ${order.status}', style: const TextStyle(fontSize: 16)),
//                   // Add more details as needed
//                 ],
//               ),
//             );
//           } else if (state is OrderDetailError) {
//             return Center(child: Text(state.message));
//           } else {
//             return const SizedBox.shrink();
//           }
//         },
//       ),
//     );
//   }
// }

// Above commented to check ui

// import 'package:flutter/material.dart';

// class OrderDetailScreen extends StatefulWidget {
//   final String id;
//   const OrderDetailScreen({super.key,required this.id});

//   @override
//   State<OrderDetailScreen> createState() => _OrderDetailScreenState();
// }

// class _OrderDetailScreenState extends State<OrderDetailScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leadingWidth: 30,
//         title: const Text('Order Detail'),
//       ),
//       body:Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 20),
//           Text('Order ID: ${widget.id}'),
//           const SizedBox(height: 20),
//           const Text('Date: 12-12-2021 on early morning'),
//           const SizedBox(height: 20),
//           const Text('Total: 200'),
//           const SizedBox(height: 20),
//           const Text('Status: Delivered'),
//         ],
//       ),
//     );
//   }
// }
