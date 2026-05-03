import 'package:equatable/equatable.dart';

sealed class PurchaseFilterEvent extends Equatable {
  const PurchaseFilterEvent();
  @override
  List<Object?> get props => [];
}

class PurchaseFilterLoadStarted extends PurchaseFilterEvent {}

class PurchaseFilterSelectChanged extends PurchaseFilterEvent {
  final String? category;
  final String? status;
  final int? month;

  const PurchaseFilterSelectChanged({this.category, this.status, this.month});

  @override
  List<Object?> get props => [category, status, month];
}
