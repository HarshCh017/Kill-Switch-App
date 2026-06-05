import 'package:flutter/material.dart';
import '../../../core/theme/app_spacing.dart';
import '../../widgets/common/app_button.dart';

class SessionCompleteScreen extends StatelessWidget {
  const SessionCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              const Icon(Icons.emoji_events, size: 100, color: Colors.orange),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Session Complete!',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xl),
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  children: [
                    Text('Focus Time', style: TextStyle(color: Colors.grey)),
                    SizedBox(height: AppSpacing.xs),
                    Text('45 Minutes', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    Divider(height: AppSpacing.xl),
                    Text('Distractions Prevented', style: TextStyle(color: Colors.grey)),
                    SizedBox(height: AppSpacing.xs),
                    Text('4 Attempts', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const Spacer(),
              AppButton(
                text: 'Share Summary',
                icon: Icons.share,
                onPressed: () {
                  // Trigger image export
                },
              ),
              const SizedBox(height: AppSpacing.md),
              AppButton(
                text: 'Done',
                variant: AppButtonVariant.text,
                onPressed: () {
                  // Return to Dashboard
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
