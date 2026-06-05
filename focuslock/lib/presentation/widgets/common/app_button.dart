import 'package:flutter/material.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

enum AppButtonVariant { primary, secondary, outline, text }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool isLoading;
  final IconData? icon;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      button: true,
      label: text,
      enabled: onPressed != null && !isLoading,
      child: _buildButton(theme),
    );
  }

  Widget _buildButton(ThemeData theme) {
    final child = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading)
          const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        else if (icon != null)
          Icon(icon, size: 20),
        
        if (isLoading || icon != null) const SizedBox(width: AppSpacing.sm),
        
        Text(text, style: AppTypography.label),
      ],
    );

    switch (variant) {
      case AppButtonVariant.primary:
        return FilledButton(onPressed: isLoading ? null : onPressed, child: child);
      case AppButtonVariant.secondary:
        return FilledButton.tonal(onPressed: isLoading ? null : onPressed, child: child);
      case AppButtonVariant.outline:
        return OutlinedButton(onPressed: isLoading ? null : onPressed, child: child);
      case AppButtonVariant.text:
        return TextButton(onPressed: isLoading ? null : onPressed, child: child);
    }
  }
}
