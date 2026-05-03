import 'package:hdi_mini_test/features/auth/domain/entities/user_entity.dart';

class UserModel {
  final String? memberId;
  final String? name;
  final String? city;
  final DateTime? joinDate;

  const UserModel({
    this.memberId,
    this.name,
    this.city,
    this.joinDate,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      memberId: json['member_id'],
      name: json['name'],
      city: json['city'],
      joinDate: json['join_date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['join_date'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'member_id': memberId,
      'name': name,
      'city': city,
      'join_date': joinDate?.millisecondsSinceEpoch,
    };
  }

  UserEntity toEntity() => UserEntity(
        memberId: memberId ?? '',
        name: name ?? '',
        city: city ?? '',
        joinDate: joinDate ?? DateTime.fromMillisecondsSinceEpoch(0),
      );
}
