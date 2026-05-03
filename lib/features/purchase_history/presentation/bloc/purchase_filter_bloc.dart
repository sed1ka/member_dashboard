import 'package:hdi_mini_test/core/bloc/general_state.dart';
import 'package:hdi_mini_test/core/bloc/safe_bloc.dart';
import 'package:hdi_mini_test/core/usecase/usecase.dart';
import 'package:hdi_mini_test/features/purchase_history/domain/entities/filter_options_entity.dart';
import 'package:hdi_mini_test/features/purchase_history/domain/usecases/get_filter_options_use_case.dart';
import 'package:hdi_mini_test/features/purchase_history/domain/usecases/get_transactions_use_case.dart';
import 'package:hdi_mini_test/features/purchase_history/presentation/bloc/purchase_filter_event.dart';

class FilterStateData {
  final FilterOptionsEntity options;
  final GetTransactionsParams selected;

  FilterStateData({required this.options, required this.selected});
}

class PurchaseFilterBloc
    extends SafeBloc<PurchaseFilterEvent, GeneralState<FilterStateData>> {
  final GetFilterOptionsUseCase _getFilterOptionsUseCase;

  late FilterOptionsEntity _options;
  String _currentCategory = 'All';
  String _currentStatus = 'All';
  int _currentMonth = 0;

  PurchaseFilterBloc({
    required GetFilterOptionsUseCase getFilterOptionsUseCase,
  }) : _getFilterOptionsUseCase = getFilterOptionsUseCase,
       super(const Initial()) {
    on<PurchaseFilterLoadStarted>(_onLoadStarted);
    on<PurchaseFilterSelectChanged>(_onSelectChanged);
  }

  Future<void> _onLoadStarted(
    PurchaseFilterLoadStarted event,
    Emitter<GeneralState<FilterStateData>> emit,
  ) async {
    emit(const Loading());
    final result = await _getFilterOptionsUseCase(params: const NoParams());
    result.fold(
      (failure) => emit(Error(failure)),
      (options) {
        _options = options;
        _emitSuccess(emit);
      },
    );
  }

  void _onSelectChanged(
    PurchaseFilterSelectChanged event,
    Emitter<GeneralState<FilterStateData>> emit,
  ) {
    _currentCategory = event.category ?? _currentCategory;
    _currentStatus = event.status ?? _currentStatus;
    _currentMonth = event.month ?? _currentMonth;
    _emitSuccess(emit);
  }

  void _emitSuccess(Emitter<GeneralState<FilterStateData>> emit) {
    emit(
      Success(
        FilterStateData(
          options: _options,
          selected: GetTransactionsParams(
            category: _currentCategory,
            status: _currentStatus,
            month: _currentMonth,
          ),
        ),
      ),
    );
  }
}
