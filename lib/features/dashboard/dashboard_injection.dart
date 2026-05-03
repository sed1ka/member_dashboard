import 'package:hdi_mini_test/core/di/injection.dart';
import 'package:hdi_mini_test/features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import 'package:hdi_mini_test/features/dashboard/data/repos/dashboard_repository_impl.dart';
import 'package:hdi_mini_test/features/dashboard/domain/repos/dashboard_repository.dart';
import 'package:hdi_mini_test/features/dashboard/domain/usecases/get_member_info_use_case.dart';
import 'package:hdi_mini_test/features/dashboard/presentation/bloc/member_info_bloc.dart';

class DashboardInjection {
  static void init() {
    // Data Sources
    di.registerLazySingleton<DashboardRemoteDataSource>(
      () => DashboardRemoteDataSourceImpl(),
    );

    // Repository
    di.registerLazySingleton<DashboardRepository>(
      () => DashboardRepositoryImpl(remoteDataSource: di<DashboardRemoteDataSource>()),
    );

    // UseCases
    di.registerLazySingleton<GetMemberInfoUseCase>(
      () => GetMemberInfoUseCase(di<DashboardRepository>()),
    );

    // BLoC
    di.registerFactory<MemberInfoBloc>(
      () => MemberInfoBloc(
        getMemberInfoUseCase: di<GetMemberInfoUseCase>(),
      ),
    );
  }
}
