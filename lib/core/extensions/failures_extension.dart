import 'package:hdi_mini_test/core/error/failures.dart';

extension FailuresExtension on Failure {
  /// Checks whether the current [Failure] instance matches
  /// any of the given types.
  ///
  /// This is useful when handling multiple failure cases
  /// without relying on `is` checks repeatedly.
  ///
  /// Note:
  /// Uses both direct [runtimeType] comparison and string-based
  /// comparison to handle edge cases where type equality may fail
  /// (e.g. across different imports or generics).
  ///
  /// Example:
  /// ```
  /// final failure = ServerFailure();
  ///
  /// if (failure.isOneOf([ServerFailure, ConnectionFailure])) {
  ///   // handle network-related errors
  /// }
  /// ```
  ///
  /// Instead of:
  /// ```dart
  /// if (failure is ServerFailure || failure is ConnectionFailure) {
  ///   // handle network-related errors
  /// }
  /// ```
  bool isOneOf(List<Type> types) {
    return types.any((type) =>
    runtimeType == type || runtimeType.toString() == type.toString());
  }
}