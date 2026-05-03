import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hdi_mini_test/core/error/failures.dart';
import 'package:hdi_mini_test/core/usecase/usecase.dart';
import 'package:hdi_mini_test/features/purchase_history/domain/entities/transaction_entity.dart';
import 'package:hdi_mini_test/features/purchase_history/domain/repos/purchase_history_repository.dart';

class GetTransactionsUseCase
    implements UseCase<List<TransactionEntity>, GetTransactionsParams> {
  final PurchaseRepository repository;

  GetTransactionsUseCase(this.repository);

  @override
  Future<Either<Failure, List<TransactionEntity>>> call({
    required GetTransactionsParams params,
  }) async {
    return await repository.getTransactions(
      category: params.category,
      status: params.status,
      month: params.month,
      limit: params.limit,
      page: params.page,
    );
  }
}

class GetTransactionsParams extends Equatable {
  final String category;
  final String status;
  final int month;
  final int? limit;
  final int page;

  const GetTransactionsParams({
    this.category = 'All',
    this.status = 'All',
    this.month = 0,
    this.limit,
    this.page = 1,
  });

  @override
  List<Object?> get props => [category, status, month, limit, page];
}
