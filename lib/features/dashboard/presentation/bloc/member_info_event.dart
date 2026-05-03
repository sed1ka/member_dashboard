import 'package:equatable/equatable.dart';

sealed class MemberInfoEvent extends Equatable {
  const MemberInfoEvent();

  @override
  List<Object?> get props => [];
}

class GetMemberInfo extends MemberInfoEvent {}
