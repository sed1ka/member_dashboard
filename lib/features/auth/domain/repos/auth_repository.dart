import 'package:dartz/dartz.dart';
import 'package:hdi_mini_test/core/error/failures.dart';
import 'package:hdi_mini_test/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(String memberId, String password);

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, UserEntity>> getSession();
}
