import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:hdi_mini_test/core/error/failures.dart';
import 'package:hdi_mini_test/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String memberId, String password);

  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserModel> login(String memberId, String password) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 200));

      // Validate credentials based on task requirements
      if (memberId == 'MB001' && password == 'password123') {
        final String response = await rootBundle.loadString(
          'assets/json/user_mock.json',
        );
        final data = await json.decode(response);
        final userModel = UserModel.fromJson(data);
        if (userModel.memberId == null) throw InvalidResponseFailure();
        return userModel;
      } else {
        // Throw UnauthFailure for invalid credentials (API 401 context)
        throw UnauthFailure(message: 'Invalid Member ID or Password');
      }
    } on Failure {
      rethrow;
    } catch (e) {
      // Throw AppBugFailure if JSON file is missing or format is invalid
      throw AppBugFailure(detailMessage: e.toString());
    }
  }

  @override
  Future<void> logout() async {
    await Future.delayed(Duration(milliseconds: 100));
  }
}
