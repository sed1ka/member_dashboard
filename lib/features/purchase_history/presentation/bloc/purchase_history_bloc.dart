import 'package:hdi_mini_test/core/bloc/general_state.dart';
import 'package:hdi_mini_test/core/bloc/safe_bloc.dart';
import 'package:hdi_mini_test/features/purchase_history/domain/entities/transaction_entity.dart';
import 'package:hdi_mini_test/features/purchase_history/domain/usecases/get_transactions_use_case.dart';
import 'package:hdi_mini_test/features/purchase_history/presentation/bloc/purchase_history_event.dart';

class PurchaseHistoryBloc
    extends
        SafeBloc<PurchaseHistoryEvent, GeneralState<List<TransactionEntity>>> {
  final GetTransactionsUseCase _getTransactionsUseCase;

  PurchaseHistoryBloc({
    required GetTransactionsUseCase getTransactionsUseCase,
  }) : _getTransactionsUseCase = getTransactionsUseCase,
       super(const Initial()) {
    on<PurchaseHistoryFetch>(_onFetch);
  }

  GetTransactionsParams _selectedFilter = const GetTransactionsParams();

  Future<void> _onFetch(
    PurchaseHistoryFetch event,
    Emitter<GeneralState<List<TransactionEntity>>> emit,
  ) async {
    if (state is Loading) return;
    emit(const Loading());
    _selectedFilter = event.params ?? _selectedFilter;
    final result = await _getTransactionsUseCase(
      params: _selectedFilter,
    );
    result.fold(
      (failure) => emit(Error(failure)),
      (transactions) => emit(Success(transactions)),
    );
  }
}
