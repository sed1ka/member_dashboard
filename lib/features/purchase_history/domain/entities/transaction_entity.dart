import 'package:equatable/equatable.dart';
import 'package:hdi_mini_test/features/purchase_history/data/models/transaction_model.dart';

class TransactionEntity extends Equatable {
  final String? id;
  final DateTime? date;
  final String? category;
  final double? amount;
  final String? status;

  const TransactionEntity({
    this.id,
    this.date,
    this.category,
    this.amount,
    this.status,
  });

  TransactionModel toModel() => TransactionModel(
    id: id,
    date: date,
    category: category,
    amount: amount,
    status: status,
  );

  @override
  List<Object?> get props => [id, date, category, amount, status];
}
