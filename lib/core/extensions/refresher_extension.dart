import 'package:easy_refresh/easy_refresh.dart';

extension RefresherExtension on EasyRefreshController {
  void stopRefreshAndLoadMore({
    required bool hasReachMax,
    required bool hasError,
  }) {
    finishRefresh();

    finishLoad(
      hasReachMax
          ? IndicatorResult.noMore
          : hasError
          ? IndicatorResult.fail
          : IndicatorResult.none,
      true,
    );
  }

  void stopRefresh() => finishRefresh();

  void stopLoadMore({
    required bool hasReachMax,
    required bool hasError,
  }) => finishLoad(
    hasReachMax
        ? IndicatorResult.noMore
        : hasError
        ? IndicatorResult.fail
        : IndicatorResult.none,
    true,
  );
}
