import 'package:hdi_mini_test/core/di/injection.dart';
import 'package:hdi_mini_test/core/local_secure_storage/local_secure_storage.dart';
import 'package:hdi_mini_test/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:hdi_mini_test/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:hdi_mini_test/features/auth/data/repos/auth_repository_impl.dart';
import 'package:hdi_mini_test/features/auth/domain/repos/auth_repository.dart';
import 'package:hdi_mini_test/features/auth/domain/usecases/get_session_use_case.dart';
import 'package:hdi_mini_test/features/auth/domain/usecases/login_use_case.dart';
import 'package:hdi_mini_test/features/auth/domain/usecases/logout_use_case.dart';
import 'package:hdi_mini_test/features/auth/presentation/bloc/login_bloc.dart';
import 'package:hdi_mini_test/features/auth/presentation/bloc/logout_bloc.dart';
import 'package:hdi_mini_test/features/auth/presentation/bloc/session_bloc.dart';

class AuthInjection {
  static void init() {
    // Data Sources
    di.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(di<LocalSecureStorage>()),
    );
    di.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(),
    );

    // Repository
    di.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        localDataSource: di<AuthLocalDataSource>(),
        remoteDataSource: di<AuthRemoteDataSource>(),
      ),
    );

    // UseCases
    di.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(di<AuthRepository>()),
    );
    di.registerLazySingleton<LogoutUseCase>(
      () => LogoutUseCase(di<AuthRepository>()),
    );
    di.registerLazySingleton<GetSessionUseCase>(
      () => GetSessionUseCase(di<AuthRepository>()),
    );

    // Blocs
    di.registerFactory<LoginBloc>(
      () => LoginBloc(loginUseCase: di<LoginUseCase>()),
    );
    di.registerSingleton<LogoutBloc>(
      LogoutBloc(logoutUseCase: di<LogoutUseCase>()),
    );
    di.registerFactory<SessionBloc>(
      () => SessionBloc(getSessionUseCase: di<GetSessionUseCase>()),
    );
  }
}
