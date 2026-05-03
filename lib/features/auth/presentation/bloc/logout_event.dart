import 'package:equatable/equatable.dart';

sealed class LogoutEvent extends Equatable {
  const LogoutEvent();

  @override
  List<Object?> get props => [];
}

class LogoutStarted extends LogoutEvent {}
