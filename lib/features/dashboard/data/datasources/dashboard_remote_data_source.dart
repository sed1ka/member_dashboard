import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:hdi_mini_test/core/error/failures.dart';
import 'package:hdi_mini_test/features/dashboard/data/models/member_model.dart';

abstract class DashboardRemoteDataSource {
  Future<MemberModel> getMemberInfo();
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  @override
  Future<MemberModel> getMemberInfo() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    try {
      final String response =
          await rootBundle.loadString('assets/json/member_info.json');
      final data = await json.decode(response);
      return MemberModel.fromJson(data);
    } catch (e) {
      throw AppBugFailure(detailMessage: e.toString());
    }
  }
}
