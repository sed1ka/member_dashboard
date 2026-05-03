import 'package:dartz/dartz.dart';
import 'package:hdi_mini_test/core/error/failures.dart';
import 'package:hdi_mini_test/features/dashboard/domain/entities/member_entity.dart';

abstract class DashboardRepository {
  Future<Either<Failure, MemberEntity>> getMemberInfo();
}
