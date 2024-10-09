// lib/state/orderdetail/order_detail_state.dart

import 'package:equatable/equatable.dart';
import 'package:genme_app/models/order_detail_model.dart';

abstract class OrderDetailState extends Equatable {
  const OrderDetailState();
}

class OrderDetailInitial extends OrderDetailState {
  @override
  List<Object> get props => [];
}

class OrderDetailLoading extends OrderDetailState {
  @override
  List<Object> get props => [];
}

class OrderDetailLoaded extends OrderDetailState {
  final OrderDetailModel orderDetail;

  const OrderDetailLoaded(this.orderDetail);

  @override
  List<Object> get props => [orderDetail];
}

class OrderDetailError extends OrderDetailState {
  final String message;

  const OrderDetailError(this.message);

  @override
  List<Object> get props => [message];
}

final class OrderDetailStateAuthError extends OrderDetailState {
  const OrderDetailStateAuthError();

  @override
  List<Object?> get props => [];
}





// import 'package:equatable/equatable.dart';
// import 'package:genme_app/models/order_detail_model.dart';

// abstract class OrderDetailState extends Equatable {
//   const OrderDetailState();
// }

// class OrderDetailInitial extends OrderDetailState {
//   @override
//   List<Object> get props => [];
// }

// class OrderDetailLoading extends OrderDetailState {
//   @override
//   List<Object> get props => [];
// }

// class OrderDetailLoaded extends OrderDetailState {
//   final OrderDetailModel orderDetail;

//   const OrderDetailLoaded(this.orderDetail);

//   @override
//   List<Object> get props => [orderDetail];
// }

// class OrderDetailError extends OrderDetailState {
//   final String message;

//   const OrderDetailError(this.message);

//   @override
//   List<Object> get props => [message];
// }
