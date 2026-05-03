import 'package:equatable/equatable.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginStarted extends LoginEvent {
  final String memberId;
  final String password;

  const LoginStarted({required this.memberId, required this.password});

  @override
  List<Object?> get props => [memberId, password];
}
