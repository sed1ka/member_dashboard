import 'package:flutter/material.dart';
import 'package:hdi_mini_test/app.dart';
import 'package:hdi_mini_test/core/bloc/general_state.dart';
import 'package:hdi_mini_test/core/constants/app_sizes.dart';
import 'package:hdi_mini_test/core/di/injection.dart';
import 'package:hdi_mini_test/core/widgets/app_loading.dart';
import 'package:hdi_mini_test/core/widgets/app_text_field.dart';
import 'package:hdi_mini_test/core/widgets/obscure_text_field.dart';
import 'package:hdi_mini_test/core/widgets/responsive_layout_builder.dart';
import 'package:hdi_mini_test/features/auth/domain/entities/user_entity.dart';
import 'package:hdi_mini_test/features/auth/presentation/bloc/login_bloc.dart';
import 'package:hdi_mini_test/features/auth/presentation/bloc/login_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hdi_mini_test/features/main_layout/presentation/routes/main_shell_route.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final memberIdController = TextEditingController();
  final passwordController = TextEditingController();

  final loginBloc = di<LoginBloc>();

  @override
  void dispose() {
    memberIdController.dispose();
    passwordController.dispose();
    loginBloc.close();
    super.dispose();
  }

  void onLoginPressed() {
    if (formKey.currentState?.validate() ?? false) {
      loginBloc.add(
        LoginStarted(
          memberId: memberIdController.text.trim(),
          password: passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, GeneralState<UserEntity>>(
      bloc: loginBloc,
      listener: (context, state) {
        if (state is Success<UserEntity>) {
          const DashboardRoute().go(context);
        } else if (state is Error<UserEntity>) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.failure.message,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                  fontWeight: FontWeight.w600,
                ),
              ),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is Loading;

        return AppLoadingScreen(
          isLoading: isLoading,
          child: ResponsiveLayoutBuilder(
            onMobileBuilder: (context, constraints) => _MobileLayout(
              formKey: formKey,
              memberIdController: memberIdController,
              passwordController: passwordController,
              isLoading: isLoading,
              onTapLogin: isLoading ? null : onLoginPressed,
            ),
            onDesktopBuilder: (context, constraints) => _DesktopLayout(
              formKey: formKey,
              constraints: constraints,
              memberIdController: memberIdController,
              passwordController: passwordController,
              isLoading: isLoading,
              onTapLogin: isLoading ? null : onLoginPressed,
            ),
          ),
        );
      },
    );
  }
}

class _MobileLayout extends StatelessWidget {
  final GlobalKey formKey;
  final TextEditingController memberIdController;
  final TextEditingController passwordController;
  final bool isLoading;
  final VoidCallback? onTapLogin;

  const _MobileLayout({
    required this.formKey,
    required this.memberIdController,
    required this.passwordController,
    required this.isLoading,
    required this.onTapLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: const EdgeInsets.symmetric(
          horizontal: LayoutSize.pMedium,
        ),
        actions: [
          IconButton(
            onPressed: () {
              final currentMode = App.themeNotifier.value;
              App.themeNotifier.value = currentMode == ThemeMode.light
                  ? ThemeMode.dark
                  : ThemeMode.light;
            },
            icon: const Icon(Icons.brightness_4),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(LayoutSize.pMedium),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Member Login',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: LayoutSize.pExtraLarge),
                AppTextField(
                  controller: memberIdController,
                  labelText: 'Member ID',
                  hintText: 'Enter your Member ID',
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'This field cannot be empty'
                      : null,
                  enabled: !isLoading,
                ),
                const SizedBox(height: LayoutSize.pMedium),
                ObscureTextField(
                  controller: passwordController,
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'This field cannot be empty'
                      : null,
                  enabled: !isLoading,
                ),
                const SizedBox(height: LayoutSize.pExtraLarge),
                ElevatedButton(
                  onPressed: onTapLogin,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: LayoutSize.pMedium,
                    ),
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.primary,
                    foregroundColor: Theme.of(
                      context,
                    ).colorScheme.onPrimary,
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: TextSize.titleMedium,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  final GlobalKey formKey;
  final BoxConstraints constraints;
  final TextEditingController memberIdController;
  final TextEditingController passwordController;
  final bool isLoading;
  final VoidCallback? onTapLogin;

  const _DesktopLayout({
    required this.formKey,
    required this.constraints,

    required this.memberIdController,
    required this.passwordController,
    required this.isLoading,
    required this.onTapLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: const EdgeInsets.symmetric(
          horizontal: LayoutSize.pMedium,
        ),
        actions: [
          IconButton(
            onPressed: () {
              final currentMode = App.themeNotifier.value;
              App.themeNotifier.value = currentMode == ThemeMode.light
                  ? ThemeMode.dark
                  : ThemeMode.light;
            },
            icon: const Icon(Icons.brightness_4),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: constraints.maxWidth * 0.3,
              vertical: LayoutSize.pLarge,
            ),
            padding: const EdgeInsets.all(LayoutSize.pLarge),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
            ),

            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: LayoutSize.pExtraLarge),
                  Text(
                    'Member Login',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: LayoutSize.pExtraLarge),
                  AppTextField(
                    controller: memberIdController,
                    labelText: 'Member ID',
                    hintText: 'Enter your Member ID',
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'This field cannot be empty'
                        : null,
                    enabled: !isLoading,
                  ),
                  const SizedBox(height: LayoutSize.pMedium),
                  ObscureTextField(
                    controller: passwordController,
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'This field cannot be empty'
                        : null,
                    enabled: !isLoading,
                  ),
                  const SizedBox(height: LayoutSize.pExtraLarge),
                  ElevatedButton(
                    onPressed: onTapLogin,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: LayoutSize.pMedium,
                      ),
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.primary,
                      foregroundColor: Theme.of(
                        context,
                      ).colorScheme.onPrimary,
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: TextSize.titleMedium,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
