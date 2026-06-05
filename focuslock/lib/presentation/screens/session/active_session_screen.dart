import 'package:flutter/material.dart';
import '../../../core/theme/app_spacing.dart';
import '../../widgets/common/app_button.dart';

class ActiveSessionScreen extends StatefulWidget {
  const ActiveSessionScreen({super.key});

  @override
  State<ActiveSessionScreen> createState() => _ActiveSessionScreenState();
}

class _ActiveSessionScreenState extends State<ActiveSessionScreen> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _triggerStrictEndFlow() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Strict Mode Active'),
        content: const Text('Ending this session early requires your PIN. Are you sure you want to break your focus?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context);
              // Route to PIN pad
            }, 
            child: const Text('Enter PIN'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Finish presentation',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xxl),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 250,
                    height: 250,
                    child: CircularProgressIndicator(
                      value: 0.65,
                      strokeWidth: 12,
                      backgroundColor: Colors.grey.withOpacity(0.2),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  FadeTransition(
                    opacity: _pulseController,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      ),
                    ),
                  ),
                  const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '18:42',
                        style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                      ),
                      Text('remaining', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      text: 'Take 5m Break',
                      variant: AppButtonVariant.secondary,
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: AppButton(
                      text: 'End Early',
                      variant: AppButtonVariant.outline,
                      onPressed: _triggerStrictEndFlow,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
