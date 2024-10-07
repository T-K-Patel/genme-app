// // search_state.dart
// import 'package:equatable/equatable.dart';
// import 'package:genme_app/models/medicine.dart';
// // import 'package:genme_app/screens/search_screen.dart';
// // import 'medicine.dart';

// abstract class SearchState extends Equatable {
//   const SearchState();

//   @override
//   List<Object> get props => [];
// }

// class SearchInitial extends SearchState {}

// class SearchLoading extends SearchState {}

// class SearchSuccess extends SearchState {
//   final List<Medicine> medicines;

//   const SearchSuccess(this.medicines);

//   @override
//   List<Object> get props => [medicines];
// }

// class SearchFailure extends SearchState {
//   final String error;

//   const SearchFailure(this.error);

//   @override
//   List<Object> get props => [error];
// }

// final class SearchStateAuthError extends SearchState{
//   const SearchStateAuthError();
// }