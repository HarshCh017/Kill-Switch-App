import 'package:flutter/material.dart';
import '../../../core/theme/app_spacing.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/app_text_field.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pwdController = TextEditingController();

  @override
  void dispose() {
    _pwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Account')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppTextField(
                label: 'Name',
                validator: (val) => val?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator: (val) => val?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                label: 'Password',
                isPassword: true,
                controller: _pwdController,
                validator: (val) => (val?.length ?? 0) < 8 ? 'Must be at least 8 characters' : null,
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                label: 'Confirm Password',
                isPassword: true,
                validator: (val) => val != _pwdController.text ? 'Passwords do not match' : null,
              ),
              const SizedBox(height: AppSpacing.xl),
              AppButton(
                text: 'Register',
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Trigger registration
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
