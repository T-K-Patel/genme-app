// lib/state/orderdetail/order_detail_provider.dart

import 'dart:convert';

import 'package:genme_app/models/order_detail_model.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OrderDetailProvider {
  Future<OrderDetailModel> fetchOrderDetail(String id) async {
    // Simulate network delay
    // await Future.delayed(const Duration(seconds: 2));

    // // Return dummy data
    // final dummyData = OrderDetailModel(
    //   id: id,
    //   date: '2024-04-27',
    //   total: '99.99',
    //   status: 'Delivered',
    // );

    // return dummyData;

    // Uncomment the following code to use the real API once it's available.
    try {
         final prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('access_token');
      // print(accessToken);
      final response = await http.get(Uri.parse(
          'https://genme-app-backend.vercel.app/api/order/details/$id/'), headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      });
          print(response.statusCode);
          // print(response.body);
      if (response.statusCode == 200) {
        final data = OrderDetailModel.fromJson(jsonDecode(response.body));
        // print("objectdbfkdbf ${data.invoice.id}");
        return data;

      } else if (response.statusCode == 401 || response.statusCode == 403) {
        throw Exception("unauthorized");
      } else {
        throw Exception(
            'Failed to fetch orders. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // print(e);
      throw Exception('auth_error');
    }
  }

  
}


