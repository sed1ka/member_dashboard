import 'package:flutter/material.dart';

class AppDialog {
  const AppDialog._();

  /// Base function to show a non-dismissible dialog
  static Future<T?> show<T>(
    BuildContext context, {
    required Widget title,
    required Widget content,
    List<Widget>? actions,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: title,
          content: content,
          actions: actions,
        ),
      ),
    );
  }
}
