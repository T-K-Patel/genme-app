import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:genme_app/models/order.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderProvider {
  final String _baseUrl = 'https://genme-app-backend.vercel.app';

  Future<List<Order>> getAllOrders() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('access_token');

      final url = Uri.parse('$_baseUrl/api/order/client/getAllOrders/');
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);

        final List<Order> orders =
            jsonData.map((orderJson) => Order.fromJson(orderJson)).toList();

        return orders;
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove("access_token");
        throw Exception("unauthorized");
      } else {
        throw Exception(
            'Failed to fetch orders.');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
