import 'package:flutter/material.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/app_card.dart';
import '../../../core/theme/app_spacing.dart';

class DesignSystemDemo extends StatelessWidget {
  const DesignSystemDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Design System Demo')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Text('Typography', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: AppSpacing.md),
          const Text('H1 Header', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          const Text('Body Text - This is standard reading text.'),
          const Divider(height: AppSpacing.xxl),

          Text('Buttons', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.md,
            children: [
              AppButton(text: 'Primary', onPressed: () {}),
              AppButton(text: 'Secondary', variant: AppButtonVariant.secondary, onPressed: () {}),
              AppButton(text: 'Outline', variant: AppButtonVariant.outline, onPressed: () {}),
              AppButton(text: 'Text', variant: AppButtonVariant.text, onPressed: () {}),
              AppButton(text: 'Loading', isLoading: true, onPressed: () {}),
            ],
          ),
          const Divider(height: AppSpacing.xxl),

          Text('Cards', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: AppSpacing.md),
          AppCard(
            onTap: () {},
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Interactive Card', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: AppSpacing.sm),
                Text('Cards adhere strictly to Material 3 elevation and radius tokens.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
