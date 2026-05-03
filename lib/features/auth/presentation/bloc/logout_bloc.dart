import 'package:hdi_mini_test/core/bloc/general_state.dart';
import 'package:hdi_mini_test/core/bloc/safe_bloc.dart';
import 'package:hdi_mini_test/core/usecase/usecase.dart';
import 'package:hdi_mini_test/features/auth/domain/usecases/logout_use_case.dart';
import 'package:hdi_mini_test/features/auth/presentation/bloc/logout_event.dart';

class LogoutBloc extends SafeBloc<LogoutEvent, GeneralState<void>> {
  final LogoutUseCase _logoutUseCase;

  LogoutBloc({
    required LogoutUseCase logoutUseCase,
  }) : _logoutUseCase = logoutUseCase,
       super(const Initial()) {
    on<LogoutStarted>(_onLogoutStarted);
  }

  Future<void> _onLogoutStarted(
    LogoutStarted event,
    Emitter<GeneralState<void>> emit,
  ) async {
    emit(const Loading());
    final result = await _logoutUseCase(params: const NoParams());
    result.fold(
      (failure) => emit(Error(failure)),
      (_) => emit(const Success(null)),
    );
  }
}
