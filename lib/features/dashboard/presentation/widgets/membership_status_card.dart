import 'package:flutter/material.dart';

class MembershipStatusCard extends StatelessWidget {
  final String? status;

  const MembershipStatusCard({super.key, this.status});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(
          Icons.stars,
          color: Theme.of(context).colorScheme.secondary,
        ),
        title: const Text('Membership Status'),
        subtitle: Text(
          status ?? 'Loading...',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
