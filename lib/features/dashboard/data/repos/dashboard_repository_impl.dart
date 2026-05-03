import 'package:dartz/dartz.dart';
import 'package:hdi_mini_test/core/error/failures.dart';
import 'package:hdi_mini_test/features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import 'package:hdi_mini_test/features/dashboard/domain/entities/member_entity.dart';
import 'package:hdi_mini_test/features/dashboard/domain/repos/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;

  DashboardRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, MemberEntity>> getMemberInfo() async {
    try {
      final result = await remoteDataSource.getMemberInfo();
      return Right(result.toEntity());
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(AppBugFailure(detailMessage: e.toString()));
    }
  }
}
