import 'package:flutter/material.dart';
import '../../../core/theme/app_spacing.dart';
import '../../widgets/common/app_card.dart';

class BlockedAppsScreen extends StatelessWidget {
  const BlockedAppsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Active Blocks')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: const [
          _BlockListTile(
            title: 'Social Media',
            subtitle: 'Instagram, TikTok, Twitter',
            status: 'Active • Ends in 2h',
            isActive: true,
          ),
          SizedBox(height: AppSpacing.sm),
          _BlockListTile(
            title: 'Games',
            subtitle: 'Apple Screen Time Group',
            status: 'Paused',
            isActive: false,
          ),
        ],
      ),
    );
  }
}

class _BlockListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String status;
  final bool isActive;

  const _BlockListTile({
    required this.title,
    required this.subtitle,
    required this.status,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          backgroundColor: isActive ? Colors.red.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
          child: Icon(
            Icons.block,
            color: isActive ? Colors.red : Colors.grey,
          ),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 4),
            Text(
              status,
              style: TextStyle(
                color: isActive ? Colors.green : Colors.orange,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ],
        ),
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(child: Text(isActive ? 'Pause' : 'Resume')),
            const PopupMenuItem(child: Text('Edit Schedule')),
            const PopupMenuItem(
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }
}
