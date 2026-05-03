import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hdi_mini_test/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:hdi_mini_test/features/purchase_history/presentation/pages/purchase_history_page.dart';
import 'package:hdi_mini_test/features/main_layout/presentation/pages/main_scaffold.dart';

part 'main_shell_route.g.dart';
part '../../../dashboard/presentation/routes/dashboard_route.dart';
part '../../../purchase_history/presentation/routes/purchase_history_route.dart';

@TypedStatefulShellRoute<MainShellRoute>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<HomeBranch>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<DashboardRoute>(path: '/dashboard'),
      ],
    ),
    TypedStatefulShellBranch<PurchaseHistoryBranch>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<PurchaseHistoryRoute>(path: '/purchase'),
      ],
    ),
  ],
)
class MainShellRoute extends StatefulShellRouteData {
  const MainShellRoute();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return MainScaffold(navigationShell: navigationShell);
  }
}

class HomeBranch extends StatefulShellBranchData {
  const HomeBranch();
}

class PurchaseHistoryBranch extends StatefulShellBranchData {
  const PurchaseHistoryBranch();
}
