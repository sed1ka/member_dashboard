import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class LocalSecureStorageOptions {
  static const AndroidOptions android = AndroidOptions();

  static const IOSOptions ios = IOSOptions(
    accessibility: KeychainAccessibility.first_unlock,
  );
}
