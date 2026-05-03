import 'package:dartz/dartz.dart';
import 'package:hdi_mini_test/core/error/failures.dart';
import 'package:hdi_mini_test/features/purchase_history/domain/entities/filter_options_entity.dart';
import 'package:hdi_mini_test/features/purchase_history/domain/entities/transaction_entity.dart';

abstract class PurchaseRepository {
  Future<Either<Failure, List<TransactionEntity>>> getTransactions({
    String category = 'All',
    String status = 'All',
    int month = 0,
    int? limit,
    int page = 1,
  });

  Future<Either<Failure, FilterOptionsEntity>> getFilterOptions();
}
