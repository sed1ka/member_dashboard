import 'package:flutter/material.dart';
import 'package:hdi_mini_test/core/extensions/colors_extension.dart';

class AppLoading extends StatelessWidget {
  final Color? color;
  final double size;

  const AppLoading({
    super.key,
    this.color,
    this.size = 35,
  });

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Center(
        child: SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            color: color ?? Theme.of(context).colorScheme.primary,
            strokeWidth: 3,
          ),
        ),
      ),
    );
  }

  /// Loading with a white/dark surface background (Card-like)
  static Widget withBackground({double size = 35}) {
    return _AppLoadingWithBackground(size: size);
  }

}

class _AppLoadingWithBackground extends StatelessWidget {
  final double size;
  const _AppLoadingWithBackground({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpa(0.1),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: AppLoading(size: size),
    );
  }
}

/// A wrapper widget to show loading state over its child
class AppLoadingScreen extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const AppLoadingScreen({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpa(0.5),
            child: Center(
              child: AppLoading.withBackground(),
            ),
          ),
      ],
    );
  }
}
