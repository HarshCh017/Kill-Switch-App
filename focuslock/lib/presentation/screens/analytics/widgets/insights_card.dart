import 'package:flutter/material.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../widgets/common/app_card.dart';

class InsightsCard extends StatelessWidget {
  final String title;
  final String insight;

  const InsightsCard({
    super.key,
    required this.title,
    required this.insight,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Insight: $title. $insight',
      child: AppCard(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.lightbulb, color: Colors.orange.shade400, size: 32),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: AppSpacing.xs),
                  Text(insight, style: TextStyle(color: Colors.grey.shade700, fontSize: 14)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
