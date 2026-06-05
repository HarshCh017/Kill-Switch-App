import 'package:flutter/material.dart';
import '../../../core/theme/app_spacing.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/app_text_field.dart';

class SessionCreationScreen extends StatefulWidget {
  const SessionCreationScreen({super.key});

  @override
  State<SessionCreationScreen> createState() => _SessionCreationScreenState();
}

class _SessionCreationScreenState extends State<SessionCreationScreen> {
  double _durationMinutes = 25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Start Focus Session')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Focus Intent', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: AppSpacing.md),
            const AppTextField(
              label: 'What do you want to accomplish?',
              hint: 'e.g., Read chapter 4, Finish presentation',
            ),
            const SizedBox(height: AppSpacing.xl),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Duration', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text('${_durationMinutes.toInt()} Minutes', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Slider(
              value: _durationMinutes,
              min: 5,
              max: 120,
              divisions: 23,
              label: '${_durationMinutes.toInt()}m',
              onChanged: (val) => setState(() => _durationMinutes = val),
            ),
            const SizedBox(height: AppSpacing.xl),
            
            const Text('App Restrictions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: AppSpacing.md),
            ListTile(
              tileColor: Theme.of(context).colorScheme.surface,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              leading: const Icon(Icons.apps),
              title: const Text('Social Media Group'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            
            const SizedBox(height: AppSpacing.xxl),
            AppButton(
              text: 'Start Session',
              onPressed: () {
                // Route to ActiveSessionScreen
              },
            )
          ],
        ),
      ),
    );
  }
}
