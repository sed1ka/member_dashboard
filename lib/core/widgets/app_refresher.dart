import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:hdi_mini_test/core/constants/app_colors.dart';
import 'package:hdi_mini_test/core/widgets/custom_bezier_circle_header.dart';

class AppRefresher extends StatelessWidget {
  const AppRefresher({
    super.key,
    required this.controller,
    required this.child,
    this.onRefresh,
    this.onLoad,
    this.noMoreRefresh,
    this.textNoMoreLoad,
    this.useAccentColorAsPrimary = true,
  });

  final EasyRefreshController controller;
  final Widget child;
  final Function()? onRefresh;
  final Function()? onLoad;
  final bool? noMoreRefresh;
  final String? textNoMoreLoad;
  final bool useAccentColorAsPrimary;

  @override
  Widget build(BuildContext context) {
    const double sizeIcon = 26;
    const double paddingIcon = 10;
    const double iconDimension = sizeIcon + paddingIcon;
    const double offset = 72;

    final colorScheme = Theme.of(context).colorScheme;

    return EasyRefresh(
      triggerAxis: Axis.vertical,
      controller: controller,
      onRefresh: (noMoreRefresh ?? false) ? null : onRefresh,
      onLoad: onLoad,
      canRefreshAfterNoMore: noMoreRefresh != null ? !noMoreRefresh! : true,
      canLoadAfterNoMore: false,
      header: CustomBezierCircleHeader(
        releaseLabel: 'Release',
        backgroundColor: useAccentColorAsPrimary
            ? colorScheme.primary
            : colorScheme.surface,
        foregroundColor: useAccentColorAsPrimary
            ? colorScheme.onPrimary
            : colorScheme.primary,
        triggerOffset: 85,
        safeArea: true,
        clamping: true,
        hapticFeedback: true,
        hitOver: false,
      ),
      footer: ClassicFooter(
        triggerOffset: offset,
        infiniteOffset: offset,
        iconDimension: iconDimension,
        position: IndicatorPosition.above,
        showText: true,
        showMessage: false,
        spacing: 0,
        textBuilder: (_, IndicatorState state, _) {
          IndicatorResult result = state.result;
          IndicatorMode mode = state.mode;
          if ((mode == IndicatorMode.processed || mode == IndicatorMode.done) &&
              result == IndicatorResult.fail) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onLoad,
              child: Text.rich(
                TextSpan(
                  text: 'Failed. ',
                  children: [
                    TextSpan(
                      text: 'Reload',
                      style: TextStyle(color: colorScheme.primary),
                    ),
                  ],
                ),
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }
          return const SizedBox();
        },
        pullIconBuilder: (_, IndicatorState state, _) {
          IndicatorResult result = state.result;
          IndicatorMode mode = state.mode;
          if (result == IndicatorResult.noMore) {
            return Padding(
              padding: const EdgeInsets.only(bottom: paddingIcon),
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.lightGrey,
                ),
                child: SizedBox(height: 4, width: 4),
              ),
            );
          }

          if (mode == IndicatorMode.processing) {
            return Padding(
              padding: const EdgeInsets.only(bottom: paddingIcon),
              child: SizedBox(
                height: sizeIcon,
                width: sizeIcon,
                child: CircularProgressIndicator(color: colorScheme.primary),
              ),
            );
          }

          return const SizedBox();
        },
      ),
      child: child,
    );
  }
}
