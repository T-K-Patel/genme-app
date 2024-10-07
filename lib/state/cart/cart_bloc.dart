// import 'dart:convert';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'cart_event.dart';
// import 'cart_state.dart';

// class CartBloc extends Bloc<CartEvent, CartState> {
//   CartBloc() : super(const CartState(isLoading: false, itemsList: [])) {
//     on<LoadCartItems>(_onLoadCartItems);
//     on<UpdateCartItemQuantity>(_onUpdateCartItemQuantity);
//     on<PlaceOrder>(_onPlaceOrder);
//   }

//   Future<void> _onLoadCartItems(
//       LoadCartItems event, Emitter<CartState> emit) async {
//     emit(state.copyWith(isLoading: true));

//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String>? cart = prefs.getStringList('cart');

//     List<Map<String, dynamic>> itemsList = [];
//     if (cart != null) {
//       itemsList = cart
//           .map((item) => json.decode(item))
//           .toList()
//           .cast<Map<String, dynamic>>();
//     }

//     emit(state.copyWith(isLoading: false, itemsList: itemsList));
//   }

//   Future<void> _onUpdateCartItemQuantity(
//       UpdateCartItemQuantity event, Emitter<CartState> emit) async {
//     List<Map<String, dynamic>> updatedItemsList = List.from(state.itemsList);
//     updatedItemsList[event.index]['quantity'] = event.newQuantity.toString();

//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String> updatedCart =
//         updatedItemsList.map((item) => json.encode(item)).toList();
//     await prefs.setStringList('cart', updatedCart);

//     emit(state.copyWith(itemsList: updatedItemsList));
//   }

//   Future<void> _onPlaceOrder(PlaceOrder event, Emitter<CartState> emit) async {
//     emit(state.copyWith(isLoading: true, errorMessage: null));

//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? token = prefs.getString('access_token');

//       if (token == null) {
//         throw Exception("No access token found");
//       }

//       List<Map<String, dynamic>> orderItems = state.itemsList.map((item) {
//         return {
//           "product_id": item['medicine']['id'],
//           "quantity": int.parse(item['quantity']),
//         };
//       }).toList();

//       var response = await http.post(
//         Uri.parse(
//             'https://genme-app-backend.vercel.app/api/order/client/create/'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//         body: jsonEncode({"items": orderItems}),
//       );

//       if (response.statusCode == 200) {
//         await prefs.remove('cart');
//         emit(state.copyWith(itemsList: []));
//       } else {
//         throw Exception("Failed to place order. Error: ${response.body}");
//       }
//     } catch (error) {
//       emit(state.copyWith(errorMessage: error.toString()));
//     } finally {
//       emit(state.copyWith(isLoading: false));
//     }
//   }
// }

// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';

// part 'cart_event.dart';
// part 'cart_state.dart';

// class CartBloc extends Bloc<CartEvent, CartState> {
//   CartBloc() : super(CartInitial()) {
//     on<CartEvent>((event, emit) {
//       // TODO: implement event handler
//     });
//   }
// }
