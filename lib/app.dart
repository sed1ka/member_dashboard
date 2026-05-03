import 'package:flutter/material.dart';
import 'package:hdi_mini_test/core/router/app_router.dart';
import 'package:hdi_mini_test/core/theme/app_theme.dart';
import 'package:hdi_mini_test/core/widgets/responsive_scope.dart';

class App extends StatelessWidget {
  const App({super.key});

  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.system);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, _) {
        return MaterialApp(
          title: 'HDI Member App',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: currentMode,
          builder: (context, child) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return ResponsiveScope(
                  maxWidth: constraints.maxWidth,
                  child: child!,
                );
              },
            );
          },
        );
      },
    );
  }
}
