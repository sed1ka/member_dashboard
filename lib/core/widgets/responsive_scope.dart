import 'package:flutter/material.dart';

class ResponsiveScope extends InheritedWidget {
  final double maxWidth;

  const ResponsiveScope({
    super.key,
    required this.maxWidth,
    required super.child,
  });

  static ResponsiveScope of(BuildContext context) {
    final ResponsiveScope? result =
        context.dependOnInheritedWidgetOfExactType<ResponsiveScope>();
    assert(result != null, 'No ResponsiveScope found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ResponsiveScope oldWidget) =>
      maxWidth != oldWidget.maxWidth;
}
