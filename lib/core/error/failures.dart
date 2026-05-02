import 'package:hdi_mini_test/core/constants/app_strings.dart';

abstract class Failure {
  final String message;
  final String? detailMessage;

  const Failure({required this.message, this.detailMessage});

  /// Default: semua dianggap bukan bug yang perlu di-report
  bool get shouldReport => false;
}

class ExpectedEmptyData extends Failure {
  ExpectedEmptyData() : super(message: 'Data empty');
}

/// == RESPONSE ERROR == ///
abstract class ResponseFailure extends Failure {
  ResponseFailure({required super.message}) : super();

  @override
  bool get shouldReport => true;
}

/// JSON Data received is invalid
class InvalidResponseFailure extends ResponseFailure {
  InvalidResponseFailure() : super(message: AppStrings.generalError);
}

/// Response is null should be not null
class EmptyDataFailure extends ResponseFailure {
  EmptyDataFailure() : super(message: AppStrings.generalError);
}

/// == APP BUG ERROR == ///
class AppBugFailure extends Failure {
  AppBugFailure() : super(message: AppStrings.generalError);

  @override
  bool get shouldReport => true;
}

/// == THIRD PARTY ERROR == ///
class PluginFailure extends Failure {
  PluginFailure() : super(message: AppStrings.generalError);

  @override
  bool get shouldReport => true;
}

/// == LOCAL STORAGE ERROR == ///
class StorageFailure extends Failure {
  StorageFailure({String? message, super.detailMessage})
    : super(message: message ?? AppStrings.generalError);

  @override
  bool get shouldReport => true;
}

class WriteStorageFailure extends StorageFailure {
  WriteStorageFailure({super.message});
}

class ReadStorageFailure extends StorageFailure {
  ReadStorageFailure({super.message});
}

class DeleteStorageFailure extends StorageFailure {
  DeleteStorageFailure({super.message});
}
