import 'package:flutter/material.dart';
import 'package:hdi_mini_test/core/constants/app_sizes.dart';
import 'package:hdi_mini_test/core/extensions/integers_extension.dart';
import 'package:hdi_mini_test/core/extensions/nums_extension.dart';
import 'package:hdi_mini_test/features/purchase_history/domain/entities/transaction_entity.dart';

class TransactionTable extends StatelessWidget {
  final List<TransactionEntity> transactions;
  final bool shrinkWrap;

  const TransactionTable({
    super.key,
    required this.transactions,
    this.shrinkWrap = false,
  });

  @override
  Widget build(BuildContext context) {
    final list = ListView.builder(
      itemCount: transactions.length,
      shrinkWrap: shrinkWrap,
      physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
      itemBuilder: (context, index) =>
          _TableRow(transaction: transactions[index]),
    );

    return Column(
      mainAxisSize: shrinkWrap ? MainAxisSize.min : MainAxisSize.max,
      children: [
        const _TableHeader(),
        if (shrinkWrap) list else Flexible(child: list),
      ],
    );
  }
}

class _TableHeader extends StatelessWidget {
  const _TableHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(LayoutSize.pMedium),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
      ),
      child: Row(
        children: [
          headerText('TRX ID'),
          const SizedBox(width: 6),
          headerText('Date', flex: 3),
          const SizedBox(width: 6),
          headerText('Category'),
          const SizedBox(width: 6),
          headerText('Amount'),
          const SizedBox(width: 6),
          headerText('Status', flex: 1),
        ],
      ),
    );
  }

  Widget headerText(String label, {int flex = 2}) {
    return Expanded(
      flex: flex,
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}

class _TableRow extends StatelessWidget {
  final TransactionEntity transaction;

  const _TableRow({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: LayoutSize.pMedium,
        vertical: LayoutSize.pLarge,
      ),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.2)),
      ),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(transaction.id  ?? '-')),
          const SizedBox(width: 6),
          Expanded(
            flex: 3,
            child: Text(
              transaction.date?.millisecondsSinceEpoch.toDateFromEpoch()  ?? '-',
            ),
          ),
          const SizedBox(width: 6),
          Expanded(flex: 2, child: Text(transaction.category  ?? '-')),
          const SizedBox(width: 6),
          Expanded(
            flex: 2,
            child: Text(
              transaction.amount?.toRupiah()  ?? 'Rp -',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(flex: 1, child: _StatusLabel(status: transaction.status ?? '-')),
        ],
      ),
    );
  }
}

class _StatusLabel extends StatelessWidget {
  final String status;

  const _StatusLabel({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color = Colors.grey;
    if (status == 'Paid') color = Colors.green;
    if (status == 'Pending') color = Colors.orange;
    if (status == 'Canceled') color = Colors.red;

    return Text(
      status,
      style: TextStyle(color: color, fontWeight: FontWeight.bold),
    );
  }
}
