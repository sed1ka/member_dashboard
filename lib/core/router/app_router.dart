import 'package:go_router/go_router.dart';
import 'package:hdi_mini_test/features/auth/presentation/routes/login_route.dart' as login;
import 'package:hdi_mini_test/features/main_layout/presentation/routes/main_shell_route.dart' as main;
import 'package:hdi_mini_test/features/splash/presentation/routes/splash_route.dart' as splash;

final router = GoRouter(
  initialLocation: '/',
  routes: [
    ...splash.$appRoutes,
    ...login.$appRoutes,
    ...main.$appRoutes,
  ],
);
