import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hdi_mini_test/app.dart';
import 'package:hdi_mini_test/core/constants/app_sizes.dart';
import 'package:hdi_mini_test/core/utils/theme_utils.dart';
import 'package:hdi_mini_test/core/widgets/app_loading.dart';
import 'package:hdi_mini_test/core/widgets/responsive_layout_builder.dart';
import 'package:hdi_mini_test/core/bloc/general_state.dart';
import 'package:hdi_mini_test/core/di/injection.dart';
import 'package:hdi_mini_test/features/auth/presentation/bloc/logout_bloc.dart';
import 'package:hdi_mini_test/features/auth/presentation/routes/login_route.dart';
import 'package:hdi_mini_test/features/auth/presentation/widgets/logout_dialog.dart';

class MainScaffold extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainScaffold({super.key, required this.navigationShell});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  final logoutBloc = di<LogoutBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogoutBloc, GeneralState<void>>(
      bloc: logoutBloc,
      listener: (context, state) {
        // Regardless of the state (except Initial), navigate to the login page
        if (state is! Initial) const LoginRoute().go(context);
      },
      builder: (context, state) => AppLoadingScreen(
        isLoading: state is Loading,
        child: ResponsiveLayoutBuilder(
          onMobileBuilder: (context, constraints) => _MobileScaffold(
            navigationShell: widget.navigationShell,
          ),
          onTabletBuilder: (context, constraints) => _TabletScaffold(
            navigationShell: widget.navigationShell,
          ),
        ),
      ),
    );
  }
}

class _MobileScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const _MobileScaffold({required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _MainAppBar(
        title: navigationShell.currentIndex == 0
            ? 'Dashboard'
            : 'Purchase History',
        height: LayoutSize.appBarSmallHeight,
        actions: [
          IconButton(
            tooltip: 'Theme Mode',
            onPressed: () {
              final currentMode = App.themeNotifier.value;
              App.themeNotifier.value = currentMode == ThemeMode.light
                  ? ThemeMode.dark
                  : ThemeMode.light;
            },
            icon: ValueListenableBuilder(
              valueListenable: App.themeNotifier,
              builder: (_, mode, _) => Icon(
                mode == ThemeMode.light ? Icons.light_mode : Icons.dark_mode,
              ),
            ),
          ),
          const SizedBox(width: 6),
          IconButton(
            tooltip: 'Logout',
            onPressed: () => LogoutDialog.show(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        ],
      ),
    );
  }
}

class _TabletScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const _TabletScaffold({required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _MainAppBar(
        title: navigationShell.currentIndex == 0
            ? 'Member Dashboard'
            : 'Purchase History',
        height: LayoutSize.appBarHeight,
        centerTitle: true,
      ),
      body: Row(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 250, minWidth: 100),
            child: SizedBox(
              width: MediaQuery.widthOf(context) * 0.3,
              child: NavigationDrawer(
                selectedIndex: navigationShell.currentIndex,
                onDestinationSelected: (index) =>
                    navigationShell.goBranch(index),
                tilePadding: EdgeInsets.symmetric(
                  horizontal: LayoutSize.pMedium,
                  vertical: LayoutSize.pSmall,
                ),
                footer: ColoredBox(
                  color: Theme.of(context).colorScheme.surface,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Divider(),
                      const SizedBox(height: LayoutSize.pSmall),

                      /// THEME SWITCH
                      ValueListenableBuilder<ThemeMode>(
                        valueListenable: App.themeNotifier,
                        builder: (context, mode, _) {
                          final isDark = isDarkMode(context, mode);

                          return SwitchListTile(
                            title: Text(
                              '${isDark ? 'Dark' : 'Light'} Mode',
                            ),
                            secondary: Icon(
                              isDark ? Icons.dark_mode : Icons.light_mode,
                            ),
                            value: isDark,
                            onChanged: (_) {
                              App.themeNotifier.value = isDark
                                  ? ThemeMode.light
                                  : ThemeMode.dark;
                            },
                          );
                        },
                      ),

                      const SizedBox(height: LayoutSize.pSmall),

                      /// LOGOUT
                      ColoredBox(
                        color: Colors.red,
                        child: ListTile(
                          textColor: Colors.white,
                          leading: const Icon(
                            Icons.logout,
                            color: Colors.white,
                          ),
                          title: const Text('Logout'),
                          onTap: () => LogoutDialog.show(context),
                        ),
                      ),

                      const SizedBox(height: LayoutSize.pExtraLarge),
                    ],
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(LayoutSize.pMedium),
                    child: Text(
                      'Menu',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  NavigationDrawerDestination(
                    icon: const Icon(Icons.home_outlined),
                    selectedIcon: const Icon(Icons.home),
                    label: Text(
                      'Home',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  NavigationDrawerDestination(
                    icon: const Icon(Icons.history_outlined),
                    selectedIcon: const Icon(Icons.history),
                    label: Text(
                      'History',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const VerticalDivider(width: 1),
          Expanded(child: navigationShell),
        ],
      ),
    );
  }
}

class _MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;
  final bool centerTitle;
  final List<Widget>? actions;

  const _MainAppBar({
    required this.title,
    required this.height,
    this.centerTitle = false,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: centerTitle,
      actionsPadding: const EdgeInsets.symmetric(
        horizontal: LayoutSize.pMedium,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
