import 'package:flutter/material.dart';

class Utility {
  static customSnackBar(GlobalKey<NavigatorState> key, String msg,
      {double height = 30, Color backgroundColor = Colors.black}) {
    if (key.currentState == null) {
      return;
    }
    ScaffoldMessenger.of(key.currentContext!).hideCurrentSnackBar();
    final snackBar = SnackBar(
      backgroundColor: backgroundColor,
      content: Text(
        msg,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
    ScaffoldMessenger.of(key.currentContext!).showSnackBar(snackBar);
  }
}

