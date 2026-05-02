import 'package:equatable/equatable.dart';
import 'package:hdi_mini_test/core/error/failures.dart';


sealed class GeneralState<T> extends Equatable {
  const GeneralState();

  @override
  List<Object?> get props => [];
}

final class Initial<T> extends GeneralState<T> {
  const Initial();
}

final class Loading<T> extends GeneralState<T> {
  final double progress;

  const Loading({this.progress = 0});

  @override
  List<Object?> get props => [progress];
}

final class Success<T> extends GeneralState<T> {
  final T data;

  const Success(this.data);

  @override
  List<Object?> get props => [data];
}

final class Error<T> extends GeneralState<T> {
  final Failure failure;

  const Error(this.failure);

  @override
  List<Object?> get props => [
    failure,
    failure.message,
    failure.detailMessage,
  ];
}