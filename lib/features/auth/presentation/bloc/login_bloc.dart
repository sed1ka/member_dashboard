import 'package:hdi_mini_test/core/bloc/general_state.dart';
import 'package:hdi_mini_test/core/bloc/safe_bloc.dart';
import 'package:hdi_mini_test/features/auth/domain/entities/user_entity.dart';
import 'package:hdi_mini_test/features/auth/domain/usecases/login_use_case.dart';
import 'package:hdi_mini_test/features/auth/presentation/bloc/login_event.dart';

class LoginBloc extends SafeBloc<LoginEvent, GeneralState<UserEntity>> {
  final LoginUseCase _loginUseCase;

  LoginBloc({
    required LoginUseCase loginUseCase,
  }) : _loginUseCase = loginUseCase,
       super(const Initial()) {
    on<LoginStarted>(_onLoginStarted);
  }

  Future<void> _onLoginStarted(
    LoginStarted event,
    Emitter<GeneralState<UserEntity>> emit,
  ) async {
    emit(const Loading());
    final result = await _loginUseCase(
      params: LoginParams(
        memberId: event.memberId,
        password: event.password,
      ),
    );

    result.fold(
      (failure) => emit(Error(failure)),
      (user) => emit(Success(user)),
    );
  }
}
