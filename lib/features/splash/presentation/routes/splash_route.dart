import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hdi_mini_test/features/splash/presentation/pages/splash_page.dart';

part 'splash_route.g.dart';

@TypedGoRoute<SplashRoute>(
  path: '/',
)
class SplashRoute extends GoRouteData with $SplashRoute {
  const SplashRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SplashPage();
}
