import 'package:flutter/material.dart';
import '../../../core/theme/app_spacing.dart';
import '../../widgets/common/app_card.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Learn')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: const [
          _LearnTopicCard(
            title: 'Why FocusLock exists',
            description: 'Learn about our philosophy of reducing distractions without manipulating attention or using dark patterns.',
            icon: Icons.self_improvement,
          ),
          SizedBox(height: AppSpacing.sm),
          _LearnTopicCard(
            title: 'How App Blocking Works',
            description: 'Understand how the background engine shields you from distracting apps efficiently.',
            icon: Icons.shield,
          ),
          SizedBox(height: AppSpacing.sm),
          _LearnTopicCard(
            title: 'Understanding Permissions',
            description: 'Why we need Usage Access, Overlay, and why Battery Optimization must be disabled for Android reliability.',
            icon: Icons.security,
          ),
        ],
      ),
    );
  }
}

class _LearnTopicCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const _LearnTopicCard({
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: () {
        // Expand or route to detailed article
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: AppSpacing.xs),
                Text(description, style: TextStyle(color: Colors.grey.shade600)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
