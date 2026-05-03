import 'dart:convert';
import 'package:hdi_mini_test/core/error/failures.dart';
import 'package:hdi_mini_test/core/local_secure_storage/local_secure_storage.dart';
import 'package:hdi_mini_test/features/auth/data/models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> saveUser(UserModel user);

  Future<UserModel> getUser();

  Future<void> deleteUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final LocalSecureStorage _storage;

  AuthLocalDataSourceImpl(this._storage);

  static const _userKey = 'cached_user';

  @override
  Future<void> saveUser(UserModel user) async {
    final String encodeResult;

    try {
      encodeResult = json.encode(user.toJson());
    } catch (e) {
      // If encoding fails, it's a bug in our model or data structure
      throw AppBugFailure(detailMessage: e.toString());
    }

    try {
      await _storage.write(
        key: _userKey,
        value: encodeResult,
      );
    } catch (e) {
      // If storage writing fails, it's a technical storage issue
      throw StorageFailure(detailMessage: e.toString());
    }
  }

  @override
  Future<UserModel> getUser() async {
    final String? jsonString;

    try {
      jsonString = await _storage.read(key: _userKey);
    } catch (e) {
      throw StorageFailure(detailMessage: e.toString());
    }

    if (jsonString == null) throw ExpectedEmptyData();

    try {
      return UserModel.fromJson(json.decode(jsonString));
    } catch (e) {
      // If data is corrupted or format changed
      throw InvalidResponseFailure();
    }
  }

  @override
  Future<void> deleteUser() async {
    try {
      await _storage.delete(key: _userKey);
    } catch (e) {
      throw StorageFailure(detailMessage: e.toString());
    }
  }
}
