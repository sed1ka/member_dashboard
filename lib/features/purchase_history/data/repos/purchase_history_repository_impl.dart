import 'package:dartz/dartz.dart';
import 'package:hdi_mini_test/core/error/failures.dart';
import 'package:hdi_mini_test/features/purchase_history/data/datasources/purchase_history_remote_data_source.dart';
import 'package:hdi_mini_test/features/purchase_history/domain/entities/filter_options_entity.dart';
import 'package:hdi_mini_test/features/purchase_history/domain/entities/transaction_entity.dart';
import 'package:hdi_mini_test/features/purchase_history/domain/repos/purchase_history_repository.dart';

class PurchaseRepositoryImpl implements PurchaseRepository {
  final PurchaseRemoteDataSource remoteDataSource;

  PurchaseRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<TransactionEntity>>> getTransactions({
    String category = 'All',
    String status = 'All',
    int month = 0,
    int? limit,
    int page = 1,
  }) async {
    try {
      final result = await remoteDataSource.getTransactions(
        category: category,
        status: status,
        month: month,
        limit: limit,
        page: page,
      );
      return Right(result.map((model) => model.toEntity()).toList());
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(AppBugFailure(detailMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, FilterOptionsEntity>> getFilterOptions() async {
    try {
      final result = await remoteDataSource.getFilterOptions();
      return Right(result.toEntity());
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(AppBugFailure(detailMessage: e.toString()));
    }
  }
}
