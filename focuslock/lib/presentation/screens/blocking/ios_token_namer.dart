import 'package:flutter/material.dart';
import '../../../core/theme/app_spacing.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/app_text_field.dart';

class IOSTokenNamer extends StatefulWidget {
  final int tokenCount;

  const IOSTokenNamer({super.key, required this.tokenCount});

  @override
  State<IOSTokenNamer> createState() => _IOSTokenNamerState();
}

class _IOSTokenNamerState extends State<IOSTokenNamer> {
  final _labelController = TextEditingController();

  @override
  void dispose() {
    _labelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Name Your Selection')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.apple, size: 64),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Apple Privacy',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Apple hides the names of the ${widget.tokenCount} apps you just selected to protect your privacy. Please give this group a custom name so you can recognize it later.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: AppSpacing.xl),
            AppTextField(
              label: 'Group Label',
              hint: 'e.g. Social Media, Games, Distractions',
              controller: _labelController,
            ),
            const Spacer(),
            AppButton(
              text: 'Save Selection',
              onPressed: () {
                if (_labelController.text.isNotEmpty) {
                  Navigator.pop(context, _labelController.text);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
