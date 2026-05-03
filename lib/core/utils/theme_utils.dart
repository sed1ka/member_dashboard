import 'package:flutter/material.dart';

bool isDarkMode(BuildContext context, ThemeMode mode) {
  if (mode == ThemeMode.dark) return true;
  if (mode == ThemeMode.light) return false;

  return MediaQuery.platformBrightnessOf(context) == Brightness.dark;
}
