import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hdi_mini_test/core/error/failures.dart';

abstract class UseCase<ResponseType, RequestParams> {
  FutureOr<Either<Failure, ResponseType>> call({required RequestParams params});
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}