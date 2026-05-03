import 'package:hdi_mini_test/core/di/injection.dart';
import 'package:hdi_mini_test/features/purchase_history/data/datasources/purchase_history_remote_data_source.dart';
import 'package:hdi_mini_test/features/purchase_history/data/repos/purchase_history_repository_impl.dart';
import 'package:hdi_mini_test/features/purchase_history/domain/repos/purchase_history_repository.dart';
import 'package:hdi_mini_test/features/purchase_history/domain/usecases/get_filter_options_use_case.dart';
import 'package:hdi_mini_test/features/purchase_history/domain/usecases/get_transactions_use_case.dart';
import 'package:hdi_mini_test/features/purchase_history/presentation/bloc/purchase_history_bloc.dart';
import 'package:hdi_mini_test/features/purchase_history/presentation/bloc/purchase_filter_bloc.dart';

class PurchaseHistoryInjection {
  static void init() {
    // Data Sources
    di.registerLazySingleton<PurchaseRemoteDataSource>(
      () => PurchaseRemoteDataSourceImpl(),
    );

    // Repository
    di.registerLazySingleton<PurchaseRepository>(
      () => PurchaseRepositoryImpl(remoteDataSource: di<PurchaseRemoteDataSource>()),
    );

    // UseCases
    di.registerLazySingleton<GetTransactionsUseCase>(
      () => GetTransactionsUseCase(di<PurchaseRepository>()),
    );
    di.registerLazySingleton<GetFilterOptionsUseCase>(
      () => GetFilterOptionsUseCase(di<PurchaseRepository>()),
    );

    // BLocs
    di.registerFactory<PurchaseHistoryBloc>(
      () => PurchaseHistoryBloc(
        getTransactionsUseCase: di<GetTransactionsUseCase>(),
      ),
    );
    di.registerFactory<PurchaseFilterBloc>(
      () => PurchaseFilterBloc(
        getFilterOptionsUseCase: di<GetFilterOptionsUseCase>(),
      ),
    );
  }
}
