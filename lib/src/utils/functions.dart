import 'package:flutter/material.dart';

abstract class Functions {
  static void showSnackBar(
    BuildContext context,
    String text, {
    Color? foregroundColor,
    Color? backgroundColor,
  }) {
    if (text.isEmpty) {
      return;
    }

    ScaffoldMessenger.of(context).clearSnackBars();
    final snackBar = SnackBar(
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      content: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: foregroundColor,
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
