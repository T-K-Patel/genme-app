import 'dart:convert';

import 'package:genme_app/models/order_detail_model.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OrderDetailProvider {
  Future<OrderDetailModel> fetchOrderDetail(String id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('access_token');
      // print(accessToken);
      final response = await http.get(
          Uri.parse(
              'https://genme-app-backend.vercel.app/api/order/details/$id/'),
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          });
      // print('responsefromorderdetailprovider${response.statusCode}');
      // print('fjvdsvhjfvjhdvfjdsvf${response.body}');
      if (response.statusCode == 200) {
        final data = OrderDetailModel.fromJson(jsonDecode(response.body));

        return data;
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        throw Exception("unauthorized");
      } else {
        throw Exception('Failed to fetch order details.');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
