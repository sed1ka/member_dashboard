import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hdi_mini_test/core/constants/local_secure_storage_options.dart';
import 'package:hdi_mini_test/core/local_secure_storage/local_secure_storage.dart';
import 'package:hdi_mini_test/core/local_secure_storage/local_secure_storage_impl.dart';
import 'package:hdi_mini_test/features/auth/auth_injection.dart';
import 'package:hdi_mini_test/features/dashboard/dashboard_injection.dart';
import 'package:hdi_mini_test/features/purchase_history/purchase_history_injection.dart';

final di = GetIt.instance;

abstract class Injection {
  static Future<void> init() async {
    // == External ==
    di.registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage(
        aOptions: LocalSecureStorageOptions.android,
        iOptions: LocalSecureStorageOptions.ios,
      ),
    );

    // == Core ==
    di.registerLazySingleton<LocalSecureStorage>(
      () => LocalSecureStorageImpl(di<FlutterSecureStorage>()),
    );

    // == Features ==
    AuthInjection.init();
    DashboardInjection.init();
    PurchaseHistoryInjection.init();
  }
}
