import 'package:flutter/material.dart';

enum SnackbarType { info, success, error }

extension SnackbarUtils on BuildContext {
  void showSnackbar(
    String message, {
    SnackbarType type = SnackbarType.info,
  }) {
    Color backgroundColor;
    switch (type) {
      case SnackbarType.success:
        backgroundColor = Colors.green;
      case SnackbarType.error:
        backgroundColor = Colors.red;
      case SnackbarType.info:
        backgroundColor = Colors.deepPurple;
    }

    ScaffoldMessenger.of(this).removeCurrentSnackBar();

    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      ),
    );
  }
}
