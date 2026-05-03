import 'package:flutter/material.dart';
import 'package:hdi_mini_test/core/constants/app_sizes.dart';
import 'package:hdi_mini_test/core/error/failures.dart';

class AppErrorStateWidget extends StatelessWidget {
  final Failure failure;
  final VoidCallback? onRetry;
  final EdgeInsets? padding;

  const AppErrorStateWidget({
    super.key,
    required this.failure,
    this.onRetry,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: padding ?? const EdgeInsets.all(LayoutSize.pMedium),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Main message
            Text(
              failure.message,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),

            /// Detail message (optional)
            if (failure.detailMessage?.isNotEmpty ?? false) ...[
              const SizedBox(height: 8),
              Text(
                failure.detailMessage!,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],

            /// Retry button (optional)
            if (failure is! ExpectedEmptyData && onRetry != null) ...[
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                ),
                child: const Text('Coba Lagi'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
