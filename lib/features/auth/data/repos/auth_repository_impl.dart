import 'package:dartz/dartz.dart';
import 'package:hdi_mini_test/core/error/failures.dart';
import 'package:hdi_mini_test/features/auth/domain/entities/user_entity.dart';
import 'package:hdi_mini_test/features/auth/domain/repos/auth_repository.dart';
import 'package:hdi_mini_test/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:hdi_mini_test/features/auth/data/datasources/auth_local_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, UserEntity>> login(String memberId, String password) async {
    try {
      final userModel = await remoteDataSource.login(memberId, password);
      
      // Save session to local storage
      await localDataSource.saveUser(userModel);
      
      return Right(userModel.toEntity());
    } on Failure catch (e) {
      // Catch Failure thrown from DataSources
      return Left(e);
    } catch (e) {
      // General case fallback
      return Left(AppBugFailure(detailMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getSession() async {
    try {
      final user = await localDataSource.getUser();
      return Right(user.toEntity());
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      // General case fallback
      return Left(AppBugFailure(detailMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDataSource.logout();
      await localDataSource.deleteUser();
      return const Right(null);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      // General case fallback
      return Left(AppBugFailure(detailMessage: e.toString()));
    }
  }
}
