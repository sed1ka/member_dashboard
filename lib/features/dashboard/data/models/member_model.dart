import 'package:hdi_mini_test/features/dashboard/domain/entities/member_entity.dart';

class MemberModel {
  final String? memberId;
  final String? name;
  final String? city;
  final DateTime? joinDate;
  final String? membershipStatus;
  final DateTime? membershipExpiry;

  const MemberModel({
    this.memberId,
    this.name,
    this.city,
    this.joinDate,
    this.membershipStatus,
    this.membershipExpiry,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      memberId: json['member_id'],
      name: json['name'],
      city: json['city'],
      joinDate: json['join_date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['join_date'])
          : null,
      membershipStatus: json['membership_status'],
      membershipExpiry: json['membership_expiry'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['membership_expiry'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'member_id': memberId,
      'name': name,
      'city': city,
      'join_date': joinDate?.millisecondsSinceEpoch,
      'membership_status': membershipStatus,
      'membership_expiry': membershipExpiry?.millisecondsSinceEpoch,
    };
  }

  MemberEntity toEntity() => MemberEntity(
    memberId: memberId,
    name: name,
    city: city ?? '',
    joinDate: joinDate,
    membershipStatus: membershipStatus,
    membershipExpiry: membershipExpiry,
  );
}
