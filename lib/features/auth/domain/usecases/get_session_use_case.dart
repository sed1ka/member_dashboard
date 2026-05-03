import 'package:dartz/dartz.dart';
import 'package:hdi_mini_test/core/error/failures.dart';
import 'package:hdi_mini_test/core/usecase/usecase.dart';
import 'package:hdi_mini_test/features/auth/domain/entities/user_entity.dart';
import 'package:hdi_mini_test/features/auth/domain/repos/auth_repository.dart';

class GetSessionUseCase implements UseCase<UserEntity?, NoParams> {
  final AuthRepository repository;

  GetSessionUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call({required NoParams params}) async {
    return await repository.getSession();
  }
}
