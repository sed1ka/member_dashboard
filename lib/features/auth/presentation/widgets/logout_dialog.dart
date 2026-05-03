import 'package:flutter/material.dart';
import 'package:hdi_mini_test/core/di/injection.dart';
import 'package:hdi_mini_test/core/widgets/app_dialog.dart';
import 'package:hdi_mini_test/features/auth/presentation/bloc/logout_bloc.dart';
import 'package:hdi_mini_test/features/auth/presentation/bloc/logout_event.dart';

class LogoutDialog {
  static void show(BuildContext context) {
    AppDialog.show(
      context,
      title: const Text('Logout'),
      content: const Text('Are you sure you want to logout?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            di<LogoutBloc>().add(LogoutStarted());
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.error,
            foregroundColor: Theme.of(context).colorScheme.onError,
          ),
          child: const Text('Logout'),
        ),
      ],
    );
  }
}
