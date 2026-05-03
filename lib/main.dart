import 'package:flutter/material.dart';
import 'package:hdi_mini_test/app.dart';
import 'package:hdi_mini_test/core/di/injection.dart';

void main() async {
  // Ensure flutter binding ready before async
  WidgetsFlutterBinding.ensureInitialized();

  await Injection.init();

  runApp(const App());
}
