import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:hdi_mini_test/core/error/failures.dart';
import 'package:hdi_mini_test/core/usecase/usecase.dart';
import 'package:hdi_mini_test/features/purchase_history/domain/entities/filter_options_entity.dart';
import 'package:hdi_mini_test/features/purchase_history/domain/repos/purchase_history_repository.dart';

class GetFilterOptionsUseCase implements UseCase<FilterOptionsEntity, NoParams> {
  final PurchaseRepository repository;

  GetFilterOptionsUseCase(this.repository);

  @override
  Future<Either<Failure, FilterOptionsEntity>> call({required NoParams params}) async {
    return await repository.getFilterOptions();
  }
}
