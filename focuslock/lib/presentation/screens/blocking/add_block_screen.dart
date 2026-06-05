import 'package:flutter/material.dart';
import '../../../core/theme/app_spacing.dart';
import '../../widgets/common/app_button.dart';

class AddBlockScreen extends StatefulWidget {
  const AddBlockScreen({super.key});

  @override
  State<AddBlockScreen> createState() => _AddBlockScreenState();
}

class _AddBlockScreenState extends State<AddBlockScreen> {
  bool _strictMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configure Block')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Selected Apps', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: AppSpacing.md),
            ListTile(
              tileColor: Theme.of(context).colorScheme.surface,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              leading: const Icon(Icons.apps),
              title: const Text('3 Apps Selected'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Route to AndroidAppPicker or iOS FamilyActivityPicker
              },
            ),
            const SizedBox(height: AppSpacing.xl),
            const Text('Duration', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: AppSpacing.md),
            // Scaffold: Simple duration picker placeholder
            ListTile(
              tileColor: Theme.of(context).colorScheme.surface,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              leading: const Icon(Icons.timer),
              title: const Text('Quick Session: 2 Hours'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            const SizedBox(height: AppSpacing.xl),
            const Text('Security', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: AppSpacing.md),
            SwitchListTile(
              title: const Text('Strict Mode'),
              subtitle: const Text('Requires PIN to cancel or pause block. Enables Emergency Unlock limits.'),
              value: _strictMode,
              onChanged: (val) => setState(() => _strictMode = val),
              tileColor: Theme.of(context).colorScheme.surface,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            const SizedBox(height: AppSpacing.xxl),
            AppButton(
              text: 'Activate Block',
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
