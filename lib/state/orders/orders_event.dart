part of 'orders_bloc.dart';

sealed class OrdersEvent {}

final class OrderEventFetchData extends OrdersEvent {}

final class OrderEventRefresh extends OrdersEvent {}

// part of 'orders_bloc.dart';

// @immutable
// sealed class OrdersEvent {}
