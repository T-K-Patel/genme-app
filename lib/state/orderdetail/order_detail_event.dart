// lib/state/orderdetail/order_detail_event.dart

import 'package:equatable/equatable.dart';

abstract class OrderDetailEvent extends Equatable {
  const OrderDetailEvent();
}

class FetchOrderDetail extends OrderDetailEvent {
  final String id;

  const FetchOrderDetail(this.id);

  @override
  List<Object> get props => [id];
}



// import 'package:equatable/equatable.dart';

// abstract class OrderDetailEvent extends Equatable {
//   const OrderDetailEvent();
// }

// class FetchOrderDetail extends OrderDetailEvent {
//   final String id;

//   const FetchOrderDetail(this.id);

//   @override
//   List<Object> get props => [id];
// }
