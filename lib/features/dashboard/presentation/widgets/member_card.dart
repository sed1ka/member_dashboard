import 'package:flutter/material.dart';
import 'package:hdi_mini_test/core/constants/app_sizes.dart';
import 'package:hdi_mini_test/core/extensions/integers_extension.dart';
import 'package:hdi_mini_test/features/dashboard/domain/entities/member_entity.dart';

class MemberCard extends StatelessWidget {
  final MemberEntity? member;

  const MemberCard({super.key, this.member});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(LayoutSize.pLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              member?.name ?? 'Loading Name...',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            Text('ID: ${member?.memberId ?? 'XXXXX'}'),
            const SizedBox(height: LayoutSize.pSmall),
            const Divider(),
            const SizedBox(height: LayoutSize.pSmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _InfoItem(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    label: 'City',
                    value: member?.city ?? 'Unknown',
                  ),
                ),
                Expanded(
                  child: _InfoItem(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    label: 'Join Date',
                    value: member != null
                        ? member!.joinDate?.millisecondsSinceEpoch
                              .toDateFromEpoch(
                                dateTimeFormat: 'dd MMM yyyy',
                              ) ?? '-'
                        : 'Unknown',
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

class _InfoItem extends StatelessWidget {
  final String label;
  final String value;
  final CrossAxisAlignment crossAxisAlignment;

  const _InfoItem({
    required this.label,
    required this.value,
    required this.crossAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelSmall),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
