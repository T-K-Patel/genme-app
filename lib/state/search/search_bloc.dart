// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http/http.dart' as http;
// import 'dart:async';
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';

// // Model for Search Result
// class SearchResult {
//   final String id;
//   final String name;
//   final String type;

//   SearchResult({required this.id, required this.name, required this.type});

//   // A factory constructor to convert JSON to SearchResult object
//   factory SearchResult.fromJson(Map<String, dynamic> json) {
//     return SearchResult(
//       id: json['id'],
//       name: json['name'],
//       type: json['type'],
//     );
//   }
// }

// // EVENTS
// abstract class SearchEvent {}

// class TextChanged extends SearchEvent {
//   final String query;
//   TextChanged(this.query);
// }

// class SuggestionSelected extends SearchEvent {
//   final String suggestion;
//   SuggestionSelected(this.suggestion);
// }

// // STATES
// abstract class SearchState {}

// class SearchInitial extends SearchState {}

// class SearchLoading extends SearchState {}

// class SearchSuccess extends SearchState {
//   final List<SearchResult> suggestions;
//   SearchSuccess(this.suggestions);
// }

// class SearchError extends SearchState {
//   final String error;
//   SearchError(this.error);
// }

// // BLOC
// class SearchBloc extends Bloc<SearchEvent, SearchState> {
//   final http.Client httpClient;
//   Timer? _debounceTimer;

//   SearchBloc({required this.httpClient}) : super(SearchInitial()) {
//     // Listening to TextChanged events
//     on<TextChanged>(_onTextChanged);
//     // Handling the suggestion selection
//     on<SuggestionSelected>((event, emit) {
//       emit(SearchInitial()); // Reset state on suggestion selection
//     });
//   }

//   // Event handler for TextChanged
//   Future<void> _onTextChanged(TextChanged event, Emitter<SearchState> emit) async {
//     if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

//     _debounceTimer = Timer(const Duration(milliseconds: 300), () async {
//       if (event.query.isEmpty) {
//         emit(SearchInitial());
//       } else {
//         emit(SearchLoading());
//         try {
//           // Fetch access_token from SharedPreferences
//           SharedPreferences prefs = await SharedPreferences.getInstance();
//           String? accessToken = prefs.getString('access_token');

//           // Make the HTTP request with the token in the headers
//           final response = await httpClient.get(
//             Uri.parse('https://genme-app-backend.vercel.app/api/inventory/search/?phrase=${event.query}'),
//             headers: {
//               'Authorization': 'Bearer $accessToken',
//             },
//           );

//           if (response.statusCode == 200) {
//             // Parse the response as a list of SearchResult objects
//             final List<dynamic> jsonList = json.decode(response.body);
//             final List<SearchResult> suggestions = jsonList
//                 .map((jsonItem) => SearchResult.fromJson(jsonItem))
//                 .toList();
//             emit(SearchSuccess(suggestions));
//           } else {
//             emit(SearchError('Failed to fetch suggestions'));
//           }
//         } catch (error) {
//           emit(SearchError(error.toString()));
//         }
//       }
//     });
//   }

//   @override
//   Future<void> close() {
//     _debounceTimer?.cancel();
//     return super.close();
//   }
// }


// // search_bloc.dart
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:genme_app/models/medicine.dart';
// // import 'package:genme_app/screens/search_screen.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'search_event.dart';
// import 'search_state.dart';
// // import 'medicine.dart';

// class SearchBloc extends Bloc<SearchEvent, SearchState> {
//   SearchBloc() : super(SearchInitial()){
//     on<SearchQueryChanged>((state,emit)async{
      

//     });
//   }

// }
