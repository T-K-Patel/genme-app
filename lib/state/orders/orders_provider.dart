import 'package:genme_app/state/orders/orders_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:genme_app/models/order.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderProvider {
  final String _baseUrl =
      'https://genme-app-backend.vercel.app'; // Replace with your actual API

  Future<List<Order>> getAllOrders() async {
    // await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    // final orderData = [
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

    // // Convert dummy data to a list of Order objects
    // List<Order> orders = orderData.map((order) => Order.fromJson(order)).toList();
    // return orders;

    try {
      await Future.delayed(const Duration(seconds: 3));
      final prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('access_token');
      final url = Uri.parse('$_baseUrl/api/order/client/getAllOrders/');
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      });
      // print(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        // print(jsonData);
        final List<Order> orders =
            jsonData.map((orderJson) => Order.fromJson(orderJson)).toList();
            // print('oooooooo  $orders');
        return orders;
      }else if (response.statusCode == 401 || response.statusCode == 403) {
        throw Exception("unauthorized");
      } else {
        throw Exception('Failed to fetch orders. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}