extension KreduitStringManipulations on String {
  /// Converts the string by capitalizing the first character.
  ///
  /// By default, preserves the original casing of the remaining characters.
  /// If [forceFrontOnly] is true, the rest of the string will be lowercased.
  ///
  /// Examples:
  /// 'hello world'.toCapitalized() -> 'Hello world'
  /// 'HELLO WORLD'.toCapitalized() -> 'HELLO WORLD'
  /// 'HELLO WORLD'.toCapitalized(forceFrontOnly: true) -> 'Hello world'
  String toCapitalized({bool forceFrontOnly = false}) {
    if (isEmpty) return '';
    return '${this[0].toUpperCase()}${!forceFrontOnly
        ? substring(1)
        : substring(1).toLowerCase()}';
  }

  /// Converts the string to title case (capitalizes each word).
  ///
  /// Multiple spaces will be normalized into a single space.
  ///
  /// Example:
  /// 'hello world' -> 'Hello World'
  /// 'HELLO   WORLD' -> 'Hello World'
  String toTitleCase() {
    if (isEmpty) return '';

    return replaceAll(RegExp(' +'), ' ')
        .split(' ')
        .map((word) => word.toCapitalized(forceFrontOnly: true))
        .join(' ');
  }
}
