import 'package:equatable/equatable.dart';
import 'package:hdi_mini_test/features/auth/data/models/user_model.dart';

class UserEntity extends Equatable {
  final String memberId;
  final String name;
  final String city;
  final DateTime joinDate;

  const UserEntity({
    required this.memberId,
    required this.name,
    required this.city,
    required this.joinDate,
  });

  UserModel toModel() => UserModel(
    memberId: memberId,
    name: name,
    city: city,
    joinDate: joinDate,
  );

  @override
  List<Object?> get props => [memberId, name, city, joinDate];
}
