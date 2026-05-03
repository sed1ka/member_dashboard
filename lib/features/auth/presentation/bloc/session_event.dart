import 'package:equatable/equatable.dart';

sealed class SessionEvent extends Equatable {
  const SessionEvent();

  @override
  List<Object?> get props => [];
}

class SessionGetStarted extends SessionEvent {}
