import 'dart:ui';

extension ColorsExtension on Color {
  /// Higher compatibility version of withOpacity
  Color withOpa(double alphaValue) => withOpacity(alphaValue);
}
