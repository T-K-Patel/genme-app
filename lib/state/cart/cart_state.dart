// import 'package:equatable/equatable.dart';

// class CartState extends Equatable {
//   final bool isLoading;
//   final List<Map<String, dynamic>> itemsList;
//   final String? errorMessage;

//   const CartState({
//     required this.isLoading,
//     required this.itemsList,
//     this.errorMessage,
//   });

//   CartState copyWith({
//     bool? isLoading,
//     List<Map<String, dynamic>>? itemsList,
//     String? errorMessage,
//   }) {
//     return CartState(
//       isLoading: isLoading ?? this.isLoading,
//       itemsList: itemsList ?? this.itemsList,
//       errorMessage: errorMessage,
//     );
//   }

//   @override
//   List<Object?> get props => [isLoading, itemsList, errorMessage];
// }


// part of 'cart_bloc.dart';

// @immutable
// sealed class CartState {}

// final class CartInitial extends CartState {}
