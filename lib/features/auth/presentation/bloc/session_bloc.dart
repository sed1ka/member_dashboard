import 'package:hdi_mini_test/core/bloc/general_state.dart';
import 'package:hdi_mini_test/core/bloc/safe_bloc.dart';
import 'package:hdi_mini_test/core/usecase/usecase.dart';
import 'package:hdi_mini_test/features/auth/domain/entities/user_entity.dart';
import 'package:hdi_mini_test/features/auth/domain/usecases/get_session_use_case.dart';
import 'package:hdi_mini_test/features/auth/presentation/bloc/session_event.dart';

class SessionBloc extends SafeBloc<SessionEvent, GeneralState<UserEntity?>> {
  final GetSessionUseCase _getSessionUseCase;

  SessionBloc({
    required GetSessionUseCase getSessionUseCase,
  }) : _getSessionUseCase = getSessionUseCase,
       super(const Initial()) {
    on<SessionGetStarted>(_onGetSessionStarted);
  }

  Future<void> _onGetSessionStarted(
    SessionGetStarted event,
    Emitter<GeneralState<UserEntity?>> emit,
  ) async {
    emit(const Loading());
    final result = await _getSessionUseCase(params: const NoParams());
    result.fold(
      (failure) => emit(Error(failure)),
      (user) => emit(Success(user)),
    );
  }
}
