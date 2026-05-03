import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:hdi_mini_test/core/error/failures.dart';
import 'package:hdi_mini_test/core/usecase/usecase.dart';
import 'package:hdi_mini_test/features/dashboard/domain/entities/member_entity.dart';
import 'package:hdi_mini_test/features/dashboard/domain/repos/dashboard_repository.dart';

class GetMemberInfoUseCase implements UseCase<MemberEntity, NoParams> {
  final DashboardRepository repository;

  GetMemberInfoUseCase(this.repository);

  @override
  Future<Either<Failure, MemberEntity>> call({required NoParams params}) async {
    return await repository.getMemberInfo();
  }
}
