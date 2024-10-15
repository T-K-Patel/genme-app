import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrderCard extends StatelessWidget {
  final String id;
  final String date;
  final String total;
  final String status;
  const OrderCard({
    super.key,
    required this.id,
    required this.date,
    required this.total,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    // Retrieve screen dimensions
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    // Define responsive padding and margin
    final horizontalMargin = screenWidth * 0.03; // 3% of screen width
    final verticalMargin = screenHeight * 0.005; // 0.5% of screen height
    final padding = screenWidth * 0.025; // 2.5% of screen width

    // Define responsive font sizes
    final orderIdFontSize = screenWidth * 0.04; // 4% of screen width
    final dateFontSize = screenWidth * 0.035; // 3.5% of screen width
    final totalFontSize = screenWidth * 0.04; // 4% of screen width
    final statusFontSize = screenWidth * 0.035; // 3.5% of screen width

    // Define responsive border radius and shadow
    final borderRadius =
        BorderRadius.circular(screenWidth * 0.02); // 2% of screen width
    final blurRadius = screenWidth * 0.012; // 1.2% of screen width
    final shadowOffset = Offset(0, screenWidth * 0.005); // 0.5% of screen width

    return GestureDetector(
      onTap: () {
        GoRouter.of(context).go('/orders/$id');
      },
      child: Container(
        margin: EdgeInsets.only(
          left: horizontalMargin,
          right: horizontalMargin,
          bottom: verticalMargin * 2, // Increased for better spacing
        ),
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: blurRadius,
              offset: shadowOffset,
            ),
          ],
        ),
        child: Column(
          children: [
            // First Row: Order ID and Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    "Order ID: $id",
                    style: TextStyle(
                      fontSize: orderIdFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    date,
                    style: TextStyle(
                      fontSize: dateFontSize,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.01), // 1% of screen height
            // Second Row: Total and Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    "Total: $total",
                    style: TextStyle(
                      fontSize: totalFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: statusFontSize,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
