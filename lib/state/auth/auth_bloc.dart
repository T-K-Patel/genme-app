import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genme_app/models/user_profile.dart';
// import 'package:genme_app/services/notification_service.dart';
import 'package:genme_app/state/auth/auth_provider.dart';
// import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

const String baseUrl = "https://genme-app-backend.vercel.app";

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider authProvider) : super(const AuthStateUninitialized()) {
    on<AuthEventCheck>((event, emit) async {
      // TODO: implement event handler
      print("AUTH LISTENED\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
      // emit(const AuthStateUninitialized());
      try {
        final prefs = await SharedPreferences.getInstance();
        String? accessToken = prefs.getString('access_token');
        // String? refreshToken = prefs.getString('refresh_token');
        print('AUTH_TOKEN FROM AUTH BLOCK\n\n\n\n\n\n\n\n $accessToken');
        if (accessToken != null && accessToken.isNotEmpty) {
          print("ENTERED IF BLOCK IN AUTHBLOC");
          final url = Uri.parse('$baseUrl/api/users/client/profile/');

          final response = await http.get(url, headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          });
          print('AUTH RESPONSE\n.\n,\\n/\n ${response.statusCode}');
          print('AUTH RESPONSE\n.\n,\nk\n/\n ${response.body}iuygiugiu');
          // print('AUTH again${response.body}iuygiugiu');
          if (response.statusCode == 200) {
            emit(AuthStateLoggedIn(
                user: UserProfile.fromJson(jsonDecode(response.body))));
          } else if (response.statusCode == 401) {
            await prefs.remove('access_token');
            // await prefs.remove('refresh_token');
            emit(const AuthStateLoggedOut());
          } else if (response.statusCode == 403) {
            await prefs.remove('access_token');
            // await prefs.remove('refresh_token');
            emit(const AuthStateLoggedOut());
          }
          print("qwertyyyyyy");
        } else {
          print('AUTH TOKEN REMOVED DUE TO SOME ERROR');
          await prefs.remove('access_token');
          // await prefs.remove('refresh_token');
          emit(const AuthStateInitial());
        }
      } on Exception catch (e) {
        print("AUTH ERROR FRO TRY BLOCK\n,\n.\nm\n,\n.\n.$e");
        emit(AuthStateError(exception: e));
      } catch (e) {
        print('UNKNOWN ERROR OCCURED');
        emit(const AuthStateInitial());
      }
    });

    on<AuthEventLogin>((state, emit) async {
      emit(const AuthStateLoading());
      try {
        final url = Uri.parse(
            'https://genme-app-backend.vercel.app/api/users/client/login/');
        final response = await http.post(url, body: {
          'username': state.username, // Username from the event
          'password': state.password, // Password from the event
        });

        // print(response.statusCode);
        // print(response.body.toString());
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          // print('data $data');
          final access = data['access'];
          // print(access);
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('access_token', access);
          final profileUrl = Uri.parse('$baseUrl/api/users/client/profile/');
          final profileResp = await http.get(profileUrl, headers: {
            'Content-Type': "application/json",
            "Authorization": "Bearer $access"
          });

          //  Save access token to shared prefs
          if (profileResp.statusCode == 200) {
            emit(AuthStateLoggedIn(
                user: UserProfile.fromJson(jsonDecode(profileResp.body))));
          } else {
            emit(AuthStateError(exception: Exception("Login Failed")));
          }
        } else {
          // print('dff ${response.toString()}');
          emit(AuthStateError(exception: Exception("Login Error")));
        }
// print('df ${response.toString()}');
      } on Exception catch (e) {
        emit(AuthStateError(exception: e));
      }
    });
    on<AuthEventLogout>((state, emit) async {
      print("autheventlogouttttttttttt");
      final prefs = await SharedPreferences.getInstance();
      prefs.remove('access_token');
      emit(const AuthStateLoggedOut());
    });
  }
  //  Future<void> _refreshToken(
  //     SharedPreferences prefs, Emitter<AuthState> emit, String refreshToken) async {
  //   final refreshUrl = Uri.parse('$baseUrl/api/user/token/refresh/');
  //   try {
  //     final response = await http.post(
  //       refreshUrl,
  //       headers: {
  //         'Content-Type': 'application/json',
  //       },
  //       body: jsonEncode({'refresh': refreshToken}),
  //     );

  //     if (response.statusCode == 200) {
  //       final responseData = jsonDecode(response.body);
  //       String newAccessToken = responseData['access'];
  //       // Save new access token to SharedPreferences
  //       await prefs.setString('access_token', newAccessToken);

  //       // Re-attempt profile fetch with new access token
  //       add(const AuthEventCheck()); // Re-dispatch event to check again
  //     } else {
  //       // Refresh token is also invalid, log out
  //       await _handleLogout(prefs, emit);
  //     }
  //   } catch (e) {
  //     emit(AuthStateError(exception: Exception('Failed to refresh token')));
  //   }
  // }

  // // Method to log out user by clearing tokens and emitting logged out state
  // Future<void> _handleLogout(SharedPreferences prefs, Emitter<AuthState> emit) async {
  //   await prefs.remove('access_token');
  //   await prefs.remove('refresh_token');
  //   emit(const AuthStateLoggedOut());
  // }
}
