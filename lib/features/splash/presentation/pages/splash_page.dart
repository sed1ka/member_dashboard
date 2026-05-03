import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hdi_mini_test/core/bloc/general_state.dart';
import 'package:hdi_mini_test/core/di/injection.dart';
import 'package:hdi_mini_test/core/widgets/app_loading.dart';
import 'package:hdi_mini_test/features/auth/presentation/bloc/session_bloc.dart';
import 'package:hdi_mini_test/features/auth/presentation/bloc/session_event.dart';
import 'package:hdi_mini_test/features/auth/presentation/routes/login_route.dart';
import 'package:hdi_mini_test/features/main_layout/presentation/routes/main_shell_route.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final sessionBloc = di<SessionBloc>();

  @override
  void initState() {
    super.initState();
    sessionBloc.add(SessionGetStarted());
  }

  @override
  void dispose() {
    sessionBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SessionBloc, GeneralState>(
      bloc: sessionBloc,
      listener: (context, state) {
        if (state is Success) {
          if (state.data != null) {
            const DashboardRoute().go(context);
          } else {
            const LoginRoute().go(context);
          }
        } else if (state is Error) {
          const LoginRoute().go(context);
        }
      },
      child: const Scaffold(
        body: Center(
          child: AppLoading(size: 50),
        ),
      ),
    );
  }
}
