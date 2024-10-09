import 'package:flutter_bloc/flutter_bloc.dart';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
import 'order_detail_event.dart';
import 'order_detail_state.dart';
import 'order_detail_provider.dart';
import 'package:genme_app/models/order_detail_model.dart';

class OrderDetailBloc extends Bloc<OrderDetailEvent, OrderDetailState> {
  final OrderDetailProvider provider;
  // final Map<String, OrderDetailModel> _cache = {};

  OrderDetailBloc(this.provider) : super(OrderDetailInitial()) {
    on<FetchOrderDetail>((event, emit) async {
      final String id = event.id;

      // Check if data is in cache
      // if (_cache.containsKey(id)) {
      //   emit(OrderDetailLoaded(_cache[id]!));
      // } else {
      emit(OrderDetailLoading());
      try {
        final OrderDetailModel orderDetail =
            await provider.fetchOrderDetail(id);
        // print("tryorderdetailssssss");
        emit(OrderDetailLoaded(orderDetail));
        // Cache the fetched data
        // _cache[id] = orderDetail;
        // emit(OrderDetailLoaded(orderDetail));
      } catch (e) {
        // print("orderdetailsbiggggerrororrsss$e");
        if (e.toString() == "Exception: unauthorized") {
          // print("tokennotvalidorderdetaisl");
          emit(const OrderDetailStateAuthError());
        } else {
          emit(const OrderDetailError('Failed to fetch order details.'));
        }
      }
    });

   
  }
}


// // lib/state/orderdetail/order_detail_bloc.dart

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'order_detail_event.dart';
// import 'order_detail_state.dart';
// import 'order_detail_provider.dart';

// class OrderDetailBloc extends Bloc<OrderDetailEvent, OrderDetailState> {
//   final OrderDetailProvider provider;

//   OrderDetailBloc(this.provider) : super(OrderDetailInitial()) {
//     on<FetchOrderDetail>((event, emit) async {
//       if (provider.hasOrderDetail(event.id)) {
//         final cachedOrderDetail = provider.getOrderDetail(event.id)!;
//         emit(OrderDetailLoaded(cachedOrderDetail));
//       } else {
//         emit(OrderDetailLoading());
//         try {
//           final orderDetail = await provider.fetchOrderDetail(event.id);
//           emit(OrderDetailLoaded(orderDetail));
//         } catch (e) {
//           emit(const OrderDetailError('Failed to fetch order details'));
//         }
//       }
//     });
//   }
// }



// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'order_detail_event.dart';
// import 'order_detail_state.dart';
// import 'order_detail_provider.dart';

// class OrderDetailBloc extends Bloc<OrderDetailEvent, OrderDetailState> {
//   final OrderDetailProvider provider;

//   OrderDetailBloc(this.provider) : super(OrderDetailInitial()) {
//     on<FetchOrderDetail>((event, emit) async {
//       emit(OrderDetailLoading());
//       try {
//         final orderDetail = await provider.fetchOrderDetail(event.id);
//         emit(OrderDetailLoaded(orderDetail));
//       } catch (e) {
//         emit(const OrderDetailError('Failed to fetch order details'));
//       }
//     });
//   }
// }
