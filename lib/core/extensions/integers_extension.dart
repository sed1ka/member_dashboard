import 'package:intl/intl.dart';

extension IntegersExtension on int {
  ///[toDateFromEpoch] is extension to convert int to Formatted DateTime
  String toDateFromEpoch({String dateTimeFormat = 'dd MMM yyyy | HH:mm'}) {
    int milliseconds = '$this'.length == 10 ? this * 1000 : this;
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    final String dateTimeFormatted =
    DateFormat(dateTimeFormat).format(dateTime);
    return dateTimeFormatted;
  }
}