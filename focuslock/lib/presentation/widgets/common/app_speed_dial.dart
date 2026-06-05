import 'package:flutter/material.dart';
import '../../../core/theme/app_spacing.dart';

class AppSpeedDial extends StatefulWidget {
  final List<SpeedDialAction> actions;

  const AppSpeedDial({super.key, required this.actions});

  @override
  State<AppSpeedDial> createState() => _AppSpeedDialState();
}

class _AppSpeedDialState extends State<AppSpeedDial> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _expandAnimation;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 250));
    _expandAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isOpen = !_isOpen;
      if (_isOpen) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (_isOpen)
          ...widget.actions.map((action) {
            return FadeTransition(
              opacity: _expandAnimation,
              child: SizeTransition(
                sizeFactor: _expandAnimation,
                axisAlignment: 1.0,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                        ),
                        child: Text(action.label, style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      FloatingActionButton.small(
                        heroTag: action.label,
                        onPressed: () {
                          _toggle();
                          action.onPressed();
                        },
                        child: Icon(action.icon),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        FloatingActionButton(
          heroTag: 'main_fab',
          onPressed: _toggle,
          child: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: _expandAnimation,
          ),
        ),
      ],
    );
  }
}

class SpeedDialAction {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  SpeedDialAction({required this.icon, required this.label, required this.onPressed});
}
