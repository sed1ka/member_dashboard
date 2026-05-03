import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hdi_mini_test/core/bloc/general_state.dart';
import 'package:hdi_mini_test/core/constants/app_sizes.dart';
import 'package:hdi_mini_test/core/extensions/colors_extension.dart';
import 'package:hdi_mini_test/core/widgets/app_error_state_widget.dart';
import 'package:hdi_mini_test/core/widgets/responsive_layout_builder.dart';
import 'package:hdi_mini_test/features/purchase_history/domain/usecases/get_transactions_use_case.dart';
import 'package:hdi_mini_test/features/purchase_history/presentation/bloc/purchase_filter_bloc.dart';
import 'package:hdi_mini_test/features/purchase_history/presentation/bloc/purchase_filter_event.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FilterBar extends StatelessWidget {
  final PurchaseFilterBloc filterBloc;
  final Function(GetTransactionsParams params) onChanged;

  const FilterBar({
    super.key,
    required this.filterBloc,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PurchaseFilterBloc, GeneralState<FilterStateData>>(
      bloc: filterBloc,
      builder: (context, state) => switch (state) {
        Initial() || Loading() => Skeletonizer(
          enabled: true,
          child: ResponsiveLayoutBuilder(
            onMobileBuilder: (context, constraints) =>
                _buildMobileFilter(context, null),
            onTabletBuilder: (context, constraints) =>
                _buildTabletFilter(context, null),
          ),
        ),

        Error(:final failure) => AppErrorStateWidget(
          failure: failure,
          onRetry: () => filterBloc.add(PurchaseFilterLoadStarted()),
        ), // atau ErrorWidget kalau mau

        Success<FilterStateData>(:final data) => ResponsiveLayoutBuilder(
          onMobileBuilder: (context, constraints) =>
              _buildMobileFilter(context, data),
          onTabletBuilder: (context, constraints) =>
              _buildTabletFilter(context, data),
        ),
      },
    );
  }

  Widget _buildMobileFilter(BuildContext context, FilterStateData? data) {
    final selected = data?.selected ?? const GetTransactionsParams();
    final options = data?.options;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(
        horizontal: LayoutSize.pMedium,
        vertical: LayoutSize.pSmall,
      ),
      child: Row(
        children: [
          _FilterChip(
            label: 'Category',
            selectedValue: selected.category,
            options: options?.categories ?? ['All'],
            onSelected: (val) {
              filterBloc.add(PurchaseFilterSelectChanged(category: val));
              onChanged(
                GetTransactionsParams(
                  category: val,
                  status: selected.status,
                  month: selected.month,
                ),
              );
            },
          ),
          const SizedBox(width: LayoutSize.pSmall),
          _FilterChip(
            label: 'Status',
            selectedValue: selected.status,
            options: options?.statuses ?? ['All'],
            onSelected: (val) {
              filterBloc.add(PurchaseFilterSelectChanged(status: val));
              onChanged(
                GetTransactionsParams(
                  category: selected.category,
                  status: val,
                  month: selected.month,
                ),
              );
            },
          ),
          const SizedBox(width: LayoutSize.pSmall),
          _FilterChip(
            label: 'Month',
            selectedValue:
                options?.months
                    .where((m) => m.value == selected.month)
                    .firstOrNull
                    ?.name ??
                'All',
            options: options?.months.map((m) => m.name).toList() ?? ['All'],
            onSelected: (val) {
              final monthValue =
                  options?.months
                      .where((m) => m.name == val)
                      .firstOrNull
                      ?.value ??
                  0;
              filterBloc.add(PurchaseFilterSelectChanged(month: monthValue));
              onChanged(
                GetTransactionsParams(
                  category: selected.category,
                  status: selected.status,
                  month: monthValue,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTabletFilter(BuildContext context, FilterStateData? data) {
    final selected = data?.selected ?? const GetTransactionsParams();
    final options = data?.options;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(LayoutSize.pMedium),
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).colorScheme.surfaceContainerHighest.withOpa(0.3),
        border: Border(
          bottom: BorderSide(color: Theme.of(context).dividerColor, width: 0.5),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            const Icon(Icons.filter_alt_outlined),
            const SizedBox(width: LayoutSize.pMedium),
            _DropdownFilter(
              label: 'Category',
              value: selected.category,
              items: options?.categories ?? ['All'],
              onChanged: (val) {
                final newValue = val ?? 'All';
                filterBloc.add(PurchaseFilterSelectChanged(category: newValue));
                onChanged(
                  GetTransactionsParams(
                    category: newValue,
                    status: selected.status,
                    month: selected.month,
                  ),
                );
              },
            ),
            const SizedBox(width: LayoutSize.pMedium),
            _DropdownFilter(
              label: 'Status',
              value: selected.status,
              items: options?.statuses ?? ['All'],
              onChanged: (val) {
                final newValue = val ?? 'All';
                filterBloc.add(PurchaseFilterSelectChanged(status: newValue));
                onChanged(
                  GetTransactionsParams(
                    category: selected.category,
                    status: newValue,
                    month: selected.month,
                  ),
                );
              },
            ),
            const SizedBox(width: LayoutSize.pMedium),
            _DropdownFilter(
              label: 'Month',
              value:
                  options?.months
                      .where((m) => m.value == selected.month)
                      .firstOrNull
                      ?.name ??
                  'All',
              items: options?.months.map((m) => m.name).toList() ?? ['All'],
              onChanged: (val) {
                final monthValue =
                    options?.months
                        .where((m) => m.name == val)
                        .firstOrNull
                        ?.value ??
                    0;
                filterBloc.add(PurchaseFilterSelectChanged(month: monthValue));
                onChanged(
                  GetTransactionsParams(
                    category: selected.category,
                    status: selected.status,
                    month: monthValue,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final String selectedValue;
  final List<String> options;
  final Function(String) onSelected;

  const _FilterChip({
    required this.label,
    required this.selectedValue,
    required this.options,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: const Icon(Icons.keyboard_arrow_down, size: 16),
      label: Text('$label: $selectedValue'),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => Column(
            children: [
              const SizedBox(height: LayoutSize.pSmall),
              Padding(
                padding: const EdgeInsets.all(
                  LayoutSize.pMedium,
                ),
                child: Text('Select $label'),
              ),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: options
                      .map(
                        (opt) => ListTile(
                          title: Text(opt),
                          selected: opt == selectedValue,
                          onTap: () {
                            onSelected(opt);
                            Navigator.pop(context);
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DropdownFilter extends StatelessWidget {
  final String label;
  final String value;
  final List<String> items;
  final Function(String?) onChanged;

  const _DropdownFilter({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelSmall),
        DropdownButton<String>(
          value: value,
          isDense: true,
          underline: const SizedBox(),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: const TextStyle(fontSize: 14)),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
