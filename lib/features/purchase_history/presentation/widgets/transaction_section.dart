import 'package:flutter/material.dart';
import 'package:hdi_mini_test/core/bloc/general_state.dart';
import 'package:hdi_mini_test/core/constants/app_sizes.dart';
import 'package:hdi_mini_test/core/widgets/app_error_state_widget.dart';
import 'package:hdi_mini_test/core/widgets/responsive_layout_builder.dart';
import 'package:hdi_mini_test/features/purchase_history/domain/entities/transaction_entity.dart';
import 'package:hdi_mini_test/features/purchase_history/presentation/widgets/transaction_card.dart';
import 'package:hdi_mini_test/features/purchase_history/presentation/widgets/transaction_table.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TransactionSection extends StatelessWidget {
  final GeneralState<List<TransactionEntity>> state;
  final VoidCallback onRetry;
  final bool shrinkWrap;

  const TransactionSection({
    super.key,
    required this.state,
    required this.onRetry,
    this.shrinkWrap = false,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      onMobileBuilder: (_, _) => _MobileLayout(
        state: state,
        onRetry: onRetry,
        shrinkWrap: shrinkWrap,
      ),
      onTabletBuilder: (_, _) => _TabletLayout(
        state: state,
        onRetry: onRetry,
        shrinkWrap: shrinkWrap,
      ),
    );
  }
}

class _MobileLayout extends StatelessWidget {
  final GeneralState<List<TransactionEntity>> state;
  final VoidCallback onRetry;
  final bool shrinkWrap;

  const _MobileLayout({
    required this.state,
    required this.onRetry,
    this.shrinkWrap = false,
  });

  @override
  Widget build(BuildContext context) {
    return switch (state) {
      Initial() || Loading() => Skeletonizer(
        enabled: true,
        child: Column(
          children: List.generate(
            4,
            (_) => const TransactionCardPlaceholder(),
          ),
        ),
      ),

      Error(:final failure) => AppErrorStateWidget(
        padding: const EdgeInsets.symmetric(
          horizontal: LayoutSize.pMedium,
          vertical: LayoutSize.pExtraLarge,
        ),
        failure: failure,
        onRetry: onRetry,
      ),

      Success<List<TransactionEntity>>(:final data) =>
        shrinkWrap
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: data
                    .map((trx) => TransactionCard(transaction: trx))
                    .toList(),
              )
            : ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) => TransactionCard(
                  transaction: data[index],
                ),
              ),
    };
  }
}

class _TabletLayout extends StatelessWidget {
  final GeneralState<List<TransactionEntity>> state;
  final VoidCallback onRetry;
  final bool shrinkWrap;

  const _TabletLayout({
    required this.state,
    required this.onRetry,
    this.shrinkWrap = false,
  });

  @override
  Widget build(BuildContext context) {
    return switch (state) {
      Initial() || Loading() => Skeletonizer(
        enabled: true,
        child: const TransactionTable(
          transactions: [
            TransactionEntity(
              id: '',
              category: 'category',
              amount: 0000,
              status: 'status',
            ),
            TransactionEntity(
              id: '',
              category: 'category',
              amount: 0000,
              status: 'status',
            ),
            TransactionEntity(
              id: '',
              category: 'category',
              amount: 0000,
              status: 'status',
            ),
          ],
          shrinkWrap: true,
        ),
      ),

      Error(:final failure) => AppErrorStateWidget(
        padding: const EdgeInsets.symmetric(
          horizontal: LayoutSize.pExtraLarge * 4,
          vertical: LayoutSize.pExtraLarge,
        ),
        failure: failure,
        onRetry: onRetry,
      ),

      Success<List<TransactionEntity>>(:final data) => TransactionTable(
        transactions: data,
        shrinkWrap: shrinkWrap,
      ),
    };
  }
}
