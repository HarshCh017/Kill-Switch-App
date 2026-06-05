import 'package:flutter/material.dart';
import '../../../core/theme/app_spacing.dart';
import '../../widgets/common/app_card.dart';

class ScheduleListScreen extends StatelessWidget {
  const ScheduleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Schedules')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: const [
          _ScheduleListTile(
            title: 'Deep Work',
            recurrence: 'Mon–Fri • 9:00 AM – 5:00 PM',
            apps: 'Social Media, Games',
            isActive: true,
          ),
          SizedBox(height: AppSpacing.sm),
          _ScheduleListTile(
            title: 'Wind Down',
            recurrence: 'Everyday • 10:00 PM – 7:00 AM',
            apps: 'All Entertainment',
            isActive: false,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Route to ScheduleBuilderScreen
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ScheduleListTile extends StatelessWidget {
  final String title;
  final String recurrence;
  final String apps;
  final bool isActive;

  const _ScheduleListTile({
    required this.title,
    required this.recurrence,
    required this.apps,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.xs),
            Row(
              children: [
                const Icon(Icons.repeat, size: 16, color: Colors.grey),
                const SizedBox(width: AppSpacing.xs),
                Text(recurrence, style: const TextStyle(color: Colors.grey, fontSize: 13)),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Row(
              children: [
                const Icon(Icons.apps, size: 16, color: Colors.grey),
                const SizedBox(width: AppSpacing.xs),
                Text(apps, style: const TextStyle(color: Colors.grey, fontSize: 13)),
              ],
            ),
          ],
        ),
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(child: Text(isActive ? 'Pause' : 'Resume')),
            const PopupMenuItem(child: Text('Edit')),
            const PopupMenuItem(
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }
}
