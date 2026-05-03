import 'package:flutter/material.dart';
import 'package:hdi_mini_test/core/constants/app_colors.dart';

final class AppTheme {
  AppTheme._();

  static final _border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: AppColors.grey),
  );

  static final _focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: AppColors.primary, width: 2),
  );

  static final _errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: AppColors.error),
  );

  static InputDecorationTheme get _inputDecorationTheme => InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    border: _border,
    enabledBorder: _border,
    focusedBorder: _focusedBorder,
    errorBorder: _errorBorder,
    focusedErrorBorder: _errorBorder,
    floatingLabelBehavior: FloatingLabelBehavior.auto,
  );

  static DrawerThemeData get _drawerThemeData => DrawerThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.zero,
    ),
  );

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.surfaceLight,
      error: AppColors.error,
      onPrimary: Colors.white,
      onSurface: AppColors.textPrimaryLight,
    ),
    inputDecorationTheme: _inputDecorationTheme,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    drawerTheme: _drawerThemeData,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
  );

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.surfaceDark,
      error: AppColors.error,
      onPrimary: Colors.white,
      onSurface: AppColors.textPrimaryDark,
    ),
    inputDecorationTheme: _inputDecorationTheme,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    drawerTheme: _drawerThemeData,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.surfaceDark,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
  );
}
