import 'package:equatable/equatable.dart';
import 'package:hdi_mini_test/features/purchase_history/data/models/filter_options_model.dart';

class MonthOption extends Equatable {
  final String name;
  final int value;

  const MonthOption({required this.name, required this.value});

  MonthOptionModel toModel() => MonthOptionModel(name: name, value: value);

  @override
  List<Object?> get props => [name, value];
}

class FilterOptionsEntity extends Equatable {
  final List<String> categories;
  final List<String> statuses;
  final List<MonthOption> months;

  const FilterOptionsEntity({
    required this.categories,
    required this.statuses,
    required this.months,
  });

  FilterOptionsModel toModel() => FilterOptionsModel(
        categories: categories,
        statuses: statuses,
        months: months.map((m) => m.toModel()).toList(),
      );

  @override
  List<Object?> get props => [categories, statuses, months];
}
