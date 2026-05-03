import 'package:flutter/material.dart';
import 'package:hdi_mini_test/core/constants/app_sizes.dart';
import 'package:hdi_mini_test/core/extensions/colors_extension.dart';
import 'package:hdi_mini_test/core/extensions/integers_extension.dart';
import 'package:hdi_mini_test/core/extensions/nums_extension.dart';
import 'package:hdi_mini_test/features/purchase_history/domain/entities/transaction_entity.dart';

class TransactionCard extends StatelessWidget {
  final TransactionEntity transaction;

  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: LayoutSize.pMedium),
      child: Padding(
        padding: const EdgeInsets.all(LayoutSize.pMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  transaction.id ?? '-',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                _StatusBadge(status: transaction.status ?? '-'),
              ],
            ),
            const SizedBox(height: LayoutSize.pSmall),
            Text(
              transaction.category ?? '-',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: LayoutSize.pSmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  transaction.date?.millisecondsSinceEpoch.toDateFromEpoch() ??
                      '-',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  transaction.amount?.toRupiah() ?? 'Rp -',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (status) {
      case 'Paid':
        color = Colors.green;
        break;
      case 'Pending':
        color = Colors.orange;
        break;
      case 'Canceled':
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpa(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class TransactionCardPlaceholder extends StatelessWidget {
  const TransactionCardPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: LayoutSize.pMedium),
      child: Padding(
        padding: const EdgeInsets.all(LayoutSize.pMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'xxxxxx',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                _StatusBadge(status: 'xxxxx'),
              ],
            ),
            const SizedBox(height: LayoutSize.pSmall),
            Text(
              'xxxxxx',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: LayoutSize.pSmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'xx xxx xxxx',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  'Rp xx.xxx',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
