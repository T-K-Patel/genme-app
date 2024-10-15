import 'package:flutter/material.dart';

final _messengerKey = GlobalKey<ScaffoldMessengerState>();

class NotificationService {
  // Define a global key for the ScaffoldMessenger
  static GlobalKey<ScaffoldMessengerState> messengerKey = _messengerKey;

  // Method to show a Snackbar
  static void showSnackBar(String message,
      {Duration duration = const Duration(seconds: 3),
      Color backgroundColor = Colors.black87,
      TextStyle textStyle = const TextStyle(color: Colors.white)}) {
    messengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: textStyle,
        ),
        duration: duration,
        backgroundColor: backgroundColor,
      ),
    );
  }

  // Optional: Method to show a simple Toast-like message
  static void showSimpleSnackBar(String message) {
    showSnackBar(message);
  }
}
