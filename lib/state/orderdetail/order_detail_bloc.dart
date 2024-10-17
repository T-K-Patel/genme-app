import 'package:flutter_bloc/flutter_bloc.dart';
import 'order_detail_event.dart';
import 'order_detail_state.dart';
import 'order_detail_provider.dart';
import 'package:genme_app/models/order_detail_model.dart';

Map<String, OrderDetailModel> cachedOrderDetailsData = {};

class OrderDetailBloc extends Bloc<OrderDetailEvent, OrderDetailState> {
  final OrderDetailProvider provider;

  OrderDetailBloc(this.provider) : super(OrderDetailInitial()) {
    on<FetchOrderDetail>((event, emit) async {
      final String id = event.id;

      emit(OrderDetailLoading());
      try {
        if (cachedOrderDetailsData.containsKey(id)) {
          final OrderDetailModel orderDetail = cachedOrderDetailsData[id]!;
          emit(OrderDetailLoaded(orderDetail));
        } else {
          final OrderDetailModel orderDetail =
              await provider.fetchOrderDetail(id);
          cachedOrderDetailsData[id] = orderDetail;
          emit(OrderDetailLoaded(orderDetail));
        }
      } catch (e) {
        if (e.toString() == "Exception: Exception: unauthorized") {
          emit(const OrderDetailStateAuthError());
        } else {
          emit(const OrderDetailError('Failed to fetch order details.'));
        }
      }
    });
  }
}



// List<Map<String, OrderDetailModel>> cachedOrderDetailsData = [];

// class OrderDetailBloc extends Bloc<OrderDetailEvent, OrderDetailState> {
//   final OrderDetailProvider provider;

//   OrderDetailBloc(this.provider) : super(OrderDetailInitial()) {
//     on<FetchOrderDetail>((event, emit) async {
//       final String id = event.id;

//       emit(OrderDetailLoading());
//       try {
//         bool containsId =
//             cachedOrderDetailsData.any((map) => map.containsKey(id));

//         if (containsId) {
//           final OrderDetailModel orderDetail = cachedOrderDetailsData
//               .firstWhere((map) => map.containsKey(id))
//               .values
//               .toList()[0];
//           emit(OrderDetailLoaded(orderDetail));
//         } else {
//           final OrderDetailModel orderDetail =
//               await provider.fetchOrderDetail(id);
//           cachedOrderDetailsData.add({id: orderDetail});
//           emit(OrderDetailLoaded(orderDetail));
//         }
//       } catch (e) {
//         if (e.toString() == "Exception: Exception: unauthorized") {
//           emit(const OrderDetailStateAuthError());
//         } else {
//           emit(const OrderDetailError('Failed to fetch order details.'));
//         }
//       }
//     });
//   }
// }
