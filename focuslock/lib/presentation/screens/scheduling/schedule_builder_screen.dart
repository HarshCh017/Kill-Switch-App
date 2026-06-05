import 'package:flutter/material.dart';
import '../../../core/theme/app_spacing.dart';
import '../../widgets/common/app_button.dart';

class ScheduleBuilderScreen extends StatefulWidget {
  const ScheduleBuilderScreen({super.key});

  @override
  State<ScheduleBuilderScreen> createState() => _ScheduleBuilderScreenState();
}

class _ScheduleBuilderScreenState extends State<ScheduleBuilderScreen> {
  final Set<int> _selectedDays = {1, 2, 3, 4, 5}; // Mon-Fri default
  RangeValues _timeRange = const RangeValues(9.0, 17.0); // 9 AM to 5 PM default

  void _toggleDay(int day) {
    setState(() {
      if (_selectedDays.contains(day)) {
        _selectedDays.remove(day);
      } else {
        _selectedDays.add(day);
      }
    });
  }

  String _formatTime(double value) {
    final int hour = value.floor();
    final int minute = ((value - hour) * 60).round();
    final String period = hour >= 12 ? 'PM' : 'AM';
    final int displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$displayHour:${minute.toString().padLeft(2, '0')} $period';
  }

  @override
  Widget build(BuildContext context) {
    const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    return Scaffold(
      appBar: AppBar(title: const Text('Create Schedule')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Active Days', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: AppSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(7, (index) {
                final dayNum = index + 1;
                final isSelected = _selectedDays.contains(dayNum);
                return GestureDetector(
                  onTap: () => _toggleDay(dayNum),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey.withOpacity(0.2),
                    child: Text(
                      days[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: AppSpacing.xxl),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Time Range', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(
                  '${_formatTime(_timeRange.start)} – ${_formatTime(_timeRange.end)}',
                  style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            RangeSlider(
              values: _timeRange,
              min: 0,
              max: 24,
              divisions: 48, // 30 min increments
              labels: RangeLabels(_formatTime(_timeRange.start), _formatTime(_timeRange.end)),
              onChanged: (values) => setState(() => _timeRange = values),
            ),
            const SizedBox(height: AppSpacing.xxl),
            
            const Text('App Restrictions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: AppSpacing.md),
            ListTile(
              tileColor: Theme.of(context).colorScheme.surface,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              leading: const Icon(Icons.apps),
              title: const Text('Select Apps'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {}, // Routes to App Picker
            ),
            
            const SizedBox(height: AppSpacing.xxl),
            AppButton(
              text: 'Save Schedule',
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
