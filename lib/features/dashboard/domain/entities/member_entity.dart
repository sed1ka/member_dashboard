import 'package:equatable/equatable.dart';
import 'package:hdi_mini_test/features/dashboard/data/models/member_model.dart';

class MemberEntity extends Equatable {
  final String? memberId;
  final String? name;
  final String? city;
  final DateTime? joinDate;
  final String? membershipStatus;
  final DateTime? membershipExpiry;

  const MemberEntity({
    this.memberId,
    this.name,
    this.city,
    this.joinDate,
    this.membershipStatus,
    this.membershipExpiry,
  });

  MemberModel toModel() => MemberModel(
    memberId: memberId,
    name: name,
    city: city,
    joinDate: joinDate,
    membershipStatus: membershipStatus,
    membershipExpiry: membershipExpiry,
  );

  @override
  List<Object?> get props => [
    memberId,
    name,
    city,
    joinDate,
    membershipStatus,
    membershipExpiry,
  ];
}
