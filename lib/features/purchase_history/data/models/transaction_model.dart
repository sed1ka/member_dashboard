import 'package:hdi_mini_test/features/purchase_history/domain/entities/transaction_entity.dart';

class TransactionModel {
  final String? id;
  final DateTime? date;
  final String? category;
  final double? amount;
  final String? status;

  const TransactionModel({
    this.id,
    this.date,
    this.category,
    this.amount,
    this.status,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      date: json['date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['date'])
          : null,
      category: json['category'],
      amount: (json['amount'] as num?)?.toDouble(),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date?.millisecondsSinceEpoch,
      'category': category,
      'amount': amount,
      'status': status,
    };
  }

  TransactionEntity toEntity() => TransactionEntity(
        id: id ?? '',
        date: date ?? DateTime.fromMillisecondsSinceEpoch(0),
        category: category ?? '',
        amount: amount ?? 0.0,
        status: status ?? '',
      );
}
