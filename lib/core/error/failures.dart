import 'package:hdi_mini_test/core/constants/app_strings.dart';

abstract class Failure {
  final String message;
  final String? detailMessage;

  const Failure({required this.message, this.detailMessage});

  /// Default: semua dianggap bukan bug yang perlu di-report
  bool get shouldReport => false;
}

class ExpectedEmptyData extends Failure {
  ExpectedEmptyData({String? message})
    : super(message: message ?? 'Data empty');
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
  AppBugFailure({String? message, super.detailMessage})
    : super(message: message ?? AppStrings.generalError);

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

/// == CLIENT ERROR == ///
class ClientFailure extends Failure {
  ClientFailure({String? message, super.detailMessage})
    : super(message: message ?? AppStrings.generalError);
}

/// Status Code: 400
class BadRequestFailure extends ClientFailure {
  BadRequestFailure({String? message})
    : super(message: message ?? AppStrings.generalError);
}

/// Status Code: 401
class UnauthFailure extends ClientFailure {
  UnauthFailure({String? message})
    : super(message: message ?? AppStrings.invalidLogin);
}

/// Status Code 403
class ForbiddenFailure extends ClientFailure {
  ForbiddenFailure({String? message})
    : super(message: message ?? AppStrings.generalError);
}

/// Status Code 404
class NotFoundFailure extends ClientFailure {
  NotFoundFailure({String? message})
    : super(message: message ?? AppStrings.generalError);
}

/// Status Code 405
class MethodNotAllowedFailure extends ClientFailure {
  MethodNotAllowedFailure() : super(message: AppStrings.generalError);
}

/// Status Code: 408
class RequestTimeoutFailure extends ClientFailure {
  RequestTimeoutFailure() : super(message: AppStrings.generalError);
}

/// Status Code: 409
class ConflictFailure extends ClientFailure {
  ConflictFailure() : super(message: AppStrings.generalError);
}

/// Status Code 412
class PreConditionFailedFailure extends ClientFailure {
  PreConditionFailedFailure({String? message})
    : super(message: message ?? AppStrings.generalError);
}

/// Status Code: 422
class UnprocessableEntityFailure extends ClientFailure {
  UnprocessableEntityFailure({String? message})
    : super(message: message ?? AppStrings.generalError);
}

/// Status Code: 423
class LockedFailure extends ClientFailure {
  LockedFailure({String? message})
    : super(message: message ?? AppStrings.generalError);
}

/// Status Code: 428
class PreConditionRequiredFailure extends ClientFailure {
  PreConditionRequiredFailure({String? message})
    : super(message: message ?? AppStrings.generalError);
}

/// Status Code: 429
class ToManyRequestFailure extends ClientFailure {
  ToManyRequestFailure({String? message})
    : super(message: message ?? AppStrings.generalError);
}
