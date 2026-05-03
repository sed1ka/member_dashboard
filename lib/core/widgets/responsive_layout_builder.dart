import 'package:flutter/material.dart';
import 'package:hdi_mini_test/core/constants/app_sizes.dart';
import 'package:hdi_mini_test/core/widgets/responsive_scope.dart';

typedef ResponsiveWidgetBuilder =
    Widget Function(BuildContext context, BoxConstraints constraints);

class ResponsiveLayoutBuilder extends StatelessWidget {
  final ResponsiveWidgetBuilder onMobileBuilder;
  final ResponsiveWidgetBuilder? onTabletBuilder;
  final ResponsiveWidgetBuilder? onDesktopBuilder;

  // Modern breakpoints based on Material Design 3 guidelines
  static const double mobileThreshold = Breakpoints.mobile;
  static const double tabletThreshold = Breakpoints.tablet;

  const ResponsiveLayoutBuilder({
    super.key,
    required this.onMobileBuilder,
    this.onTabletBuilder,
    this.onDesktopBuilder,
  });

  @override
  Widget build(BuildContext context) {
    // Single source of truth: read global width from ResponsiveScope
    final maxWidth = ResponsiveScope.of(context).maxWidth;

    // Maintain BoxConstraints compatibility
    final constraints = BoxConstraints(maxWidth: maxWidth);

    final isDesktop = maxWidth >= tabletThreshold;
    final isTablet = maxWidth >= mobileThreshold;

    // Desktop
    if (isDesktop) {
      return onDesktopBuilder?.call(context, constraints) ??
          onTabletBuilder?.call(context, constraints) ??
          onMobileBuilder(context, constraints);
    }

    // Tablet
    if (isTablet) {
      return onTabletBuilder?.call(context, constraints) ??
          onMobileBuilder(context, constraints);
    }

    // Mobile
    return onMobileBuilder(context, constraints);
  }
}
