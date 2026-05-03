import 'package:equatable/equatable.dart';
import 'package:hdi_mini_test/features/purchase_history/domain/usecases/get_transactions_use_case.dart';

sealed class PurchaseHistoryEvent extends Equatable {
  const PurchaseHistoryEvent();
  @override
  List<Object?> get props => [];
}

class PurchaseHistoryFetch extends PurchaseHistoryEvent {
  final GetTransactionsParams? params;
  const PurchaseHistoryFetch({this.params});

  @override
  List<Object?> get props => [params];
}

class PurchaseHistoryRefresh extends PurchaseHistoryEvent {}
