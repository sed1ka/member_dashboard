import 'package:hdi_mini_test/features/purchase_history/domain/entities/filter_options_entity.dart';

class MonthOptionModel {
  final String? name;
  final int? value;

  const MonthOptionModel({this.name, this.value});

  factory MonthOptionModel.fromJson(Map<String, dynamic> json) {
    return MonthOptionModel(
      name: json['name'],
      value: json['value'],
    );
  }

  MonthOption toEntity() => MonthOption(
        name: name ?? '',
        value: value ?? 0,
      );
}

class FilterOptionsModel {
  final List<String>? categories;
  final List<String>? statuses;
  final List<MonthOptionModel>? months;

  const FilterOptionsModel({
    this.categories,
    this.statuses,
    this.months,
  });

  factory FilterOptionsModel.fromJson(Map<String, dynamic> json) {
    return FilterOptionsModel(
      categories: json['categories'] != null ? List<String>.from(json['categories']) : null,
      statuses: json['statuses'] != null ? List<String>.from(json['statuses']) : null,
      months: (json['months'] as List?)
          ?.map((m) => MonthOptionModel.fromJson(m))
          .toList(),
    );
  }

  FilterOptionsEntity toEntity() => FilterOptionsEntity(
        categories: categories ?? [],
        statuses: statuses ?? [],
        months: months?.map((m) => m.toEntity()).toList() ?? [],
      );
}
