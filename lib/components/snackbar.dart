import 'package:flutter/material.dart';

class CustomSnackBar {
  static void showSnackBar(
      BuildContext context, String message, Color bgColor, Color txtColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: txtColor),
        ),
        backgroundColor: bgColor,
        duration: const Duration(seconds: 5),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Fechar',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
