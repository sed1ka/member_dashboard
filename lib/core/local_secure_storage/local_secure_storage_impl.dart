import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hdi_mini_test/core/constants/local_secure_storage_options.dart';
import 'package:hdi_mini_test/core/local_secure_storage/local_secure_storage.dart';

class LocalSecureStorageImpl implements LocalSecureStorage {
  final FlutterSecureStorage _storage;

  LocalSecureStorageImpl([FlutterSecureStorage? storage])
      : _storage = storage ??
            const FlutterSecureStorage(
              aOptions: LocalSecureStorageOptions.android,
              iOptions: LocalSecureStorageOptions.ios,
            );

  @override
  Future<void> write({required String key, required String value}) async {
    await _storage.write(key: key, value: value);
  }

  @override
  Future<String?> read({required String key}) async {
    return await _storage.read(key: key);
  }

  @override
  Future<void> delete({required String key}) async {
    await _storage.delete(key: key);
  }

  @override
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }

  @override
  Future<bool> containsKey({required String key}) async {
    return await _storage.containsKey(key: key);
  }
}
