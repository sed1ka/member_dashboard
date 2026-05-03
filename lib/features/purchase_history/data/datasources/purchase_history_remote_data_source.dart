import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:hdi_mini_test/core/error/failures.dart';
import 'package:hdi_mini_test/features/purchase_history/data/models/filter_options_model.dart';
import 'package:hdi_mini_test/features/purchase_history/data/models/transaction_model.dart';

abstract class PurchaseRemoteDataSource {
  Future<List<TransactionModel>> getTransactions({
    String category = 'All',
    String status = 'All',
    int month = 0,
    int? limit,
    int page = 1,
  });

  Future<FilterOptionsModel> getFilterOptions();
}

class PurchaseRemoteDataSourceImpl implements PurchaseRemoteDataSource {
  @override
  Future<List<TransactionModel>> getTransactions({
    String category = 'All',
    String status = 'All',
    int month = 0,
    int? limit,
    int page = 1,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 250));

    try {
      final String response = await rootBundle.loadString(
        'assets/json/transactions.json',
      );
      final List data = await json.decode(response);

      // 1. Map to models
      var transactions = data
          .map((json) => TransactionModel.fromJson(json))
          .toList();

      if (transactions.isEmpty) {
        throw ExpectedEmptyData(message: 'No transaction found.');
      }

      // 2. Apply filtering
      transactions = transactions.where((trx) {
        final categoryMatch = category == 'All' || trx.category == category;
        final statusMatch = status == 'All' || trx.status == status;
        final monthMatch = month == 0 || trx.date?.month == month;
        return categoryMatch && statusMatch && monthMatch;
      }).toList();

      // 3. Sort by date descending (Newest first)
      transactions.sort((a, b) {
        final dateA = a.date ?? DateTime.fromMillisecondsSinceEpoch(0);
        final dateB = b.date ?? DateTime.fromMillisecondsSinceEpoch(0);
        return dateB.compareTo(dateA);
      });

      // 4. Apply pagination/limiting
      if (limit != null) {
        // Simple limiting for Dashboard
        return transactions.take(limit).toList();
      } else {
        // Simple pagination logic (e.g., 10 items per page)
        const itemsPerPage = 20;
        final startIndex = (page - 1) * itemsPerPage;
        if (startIndex >= transactions.length) return [];
        return transactions.skip(startIndex).take(itemsPerPage).toList();
      }
    } on Failure {
      rethrow;
    } catch (e) {
      throw AppBugFailure(detailMessage: e.toString());
    }
  }

  @override
  Future<FilterOptionsModel> getFilterOptions() async {
    await Future.delayed(const Duration(milliseconds: 250));
    try {
      final String response = await rootBundle.loadString(
        'assets/json/filter_options.json',
      );

      final data = await json.decode(response);
      return FilterOptionsModel.fromJson(data);
    } catch (e) {
      throw AppBugFailure(detailMessage: e.toString());
    }
  }
}
