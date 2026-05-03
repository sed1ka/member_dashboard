import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hdi_mini_test/features/auth/presentation/pages/login_page.dart';

part 'login_route.g.dart';

@TypedGoRoute<LoginRoute>(
  path: '/login',
)
class LoginRoute extends GoRouteData with $LoginRoute {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const LoginPage();
}
