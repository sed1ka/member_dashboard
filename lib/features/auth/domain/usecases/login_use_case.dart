import 'package:dartz/dartz.dart';
import 'package:hdi_mini_test/core/error/failures.dart';
import 'package:hdi_mini_test/core/usecase/usecase.dart';
import 'package:hdi_mini_test/features/auth/domain/entities/user_entity.dart';
import 'package:hdi_mini_test/features/auth/domain/repos/auth_repository.dart';

class LoginUseCase implements UseCase<UserEntity, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call({required LoginParams params}) async {
    return await repository.login(params.memberId, params.password);
  }
}

class LoginParams {
  final String memberId;
  final String password;

  LoginParams({required this.memberId, required this.password});
}
