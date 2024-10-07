import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genme_app/models/order.dart';
import 'package:genme_app/state/auth/auth_bloc.dart';
import 'package:genme_app/state/orders/orders_provider.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrderProvider _orderProvider;

  // Store fetched orders to avoid re-fetching
  List<Order>? _cachedOrders;

  OrdersBloc(this._orderProvider) : super(OrdersInitial()) {
    on<OrderEventFetchData>(_onFetchOrders);
  }

  Future<void> _onFetchOrders(
      OrderEventFetchData event, Emitter<OrdersState> emit) async {
    // If orders are cached, return them directly
    // print("object");
    if (_cachedOrders != null) {
      emit(OrdersLoaded(_cachedOrders!));
      return;
    }

    emit(OrdersLoading());

    try {
      // Fetch orders using OrderProvider
      final orders = await _orderProvider.getAllOrders();

      // Cache the orders after fetching
      _cachedOrders = orders;

      emit(OrdersLoaded(orders));
    } catch (e) {
      if (e.toString() == "Exception: auth_error") {
        emit(OrdersError(e.toString()));
      } else if (e.toString() == "Exception: Exception: unauthorized") {
        print("object222222");
        emit(OrderStateAuthError());
      } else {
        emit(OrdersError(e.toString()));
      }

      // Handle general errors
    }
  }
}
