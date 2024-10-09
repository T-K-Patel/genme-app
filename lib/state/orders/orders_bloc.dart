import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genme_app/models/order.dart';
import 'package:genme_app/state/auth/auth_bloc.dart';
import 'package:genme_app/state/orders/orders_provider.dart';
import 'package:go_router/go_router.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrderProvider _orderProvider;

  // Store fetched orders to avoid re-fetching
  List<Order>? _cachedOrders;

  OrdersBloc(this._orderProvider) : super(OrdersInitial()) {
    on<OrderEventFetchData>(_onFetchOrders);
     on<OrderEventRefresh>(_onRefreshOrders); 
    
  }

   // Method to clear the cache
  void clearCache() {
    _cachedOrders = null;
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
      print('ooorrrrderss  $orders');
      // Cache the orders after fetching
      _cachedOrders = orders;

      emit(OrdersLoaded(orders));
    } catch (e) {
      if (e.toString() == "Exception: auth_error") {
        emit(OrdersError(e.toString()));
      } else if (e.toString() == "Exception: Exception: unauthorized") {
        print("object222222");
        // GoRouter.of(context).go("/splash");
        emit(OrderStateAuthError());
      } else {
        emit(OrdersError(e.toString()));
      }

      // Handle general errors
    }
  }
    Future<void> _onRefreshOrders(
      OrderEventRefresh event, Emitter<OrdersState> emit) async {
    clearCache(); // Clear cache when refreshing
    add(OrderEventFetchData()); // Re-fetch orders
  }
}
