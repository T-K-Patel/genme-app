part of 'orders_bloc.dart';

sealed class OrdersState {}

final class OrdersInitial extends OrdersState {}

final class OrdersLoading extends OrdersState {}

final class OrdersLoaded extends OrdersState {
  final List<Order> orders;

  OrdersLoaded(this.orders);
}

final class OrdersError extends OrdersState {
  final String message;

  OrdersError(this.message);
}

final class OrderStateAuthError extends OrdersState {
  OrderStateAuthError();
}
