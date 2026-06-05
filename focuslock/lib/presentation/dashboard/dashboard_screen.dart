import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/theme/app_spacing.dart';
import '../../widgets/common/app_card.dart';
import '../../widgets/common/app_speed_dial.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _protectionActive = true;

  void _toggleProtection() {
    HapticFeedback.mediumImpact();
    setState(() => _protectionActive = !_protectionActive);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildActiveProtectionCard(),
            const SizedBox(height: AppSpacing.lg),
            _buildFocusSummary(),
            const SizedBox(height: AppSpacing.lg),
            _buildWeeklyChart(),
            const SizedBox(height: AppSpacing.lg),
            _buildActiveSessionWidget(),
            const SizedBox(height: AppSpacing.lg),
            _buildUpcomingScheduleWidget(),
            const SizedBox(height: 80), // FAB padding
          ],
        ),
      ),
      floatingActionButton: AppSpeedDial(
        actions: [
          SpeedDialAction(icon: Icons.timer, label: 'Start Session', onPressed: () {}),
          SpeedDialAction(icon: Icons.block, label: 'Add Block', onPressed: () {}),
          SpeedDialAction(icon: Icons.shield, label: 'Strict Mode', onPressed: () {}),
          SpeedDialAction(icon: Icons.bar_chart, label: 'View Analytics', onPressed: () {}),
        ],
      ),
    );
  }

  Widget _buildActiveProtectionCard() {
    final color = _protectionActive ? Colors.green.shade600 : Colors.red.shade600;
    final text = _protectionActive ? 'Protection ON' : 'Protection OFF';
    final icon = _protectionActive ? Icons.shield : Icons.shield_outlined;

    return Semantics(
      button: true,
      label: 'Toggle Protection',
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        child: AppCard(
          onTap: _toggleProtection,
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Row(
            children: [
              Icon(icon, color: color, size: 40),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color),
                ),
              ),
              Switch(
                value: _protectionActive,
                onChanged: (val) => _toggleProtection(),
                activeColor: Colors.green,
                inactiveThumbColor: Colors.red,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFocusSummary() {
    return Row(
      children: [
        Expanded(child: _buildMetric('Focus Time', '4h 12m')),
        const SizedBox(width: AppSpacing.md),
        Expanded(child: _buildMetric('Blocks', '24')),
        const SizedBox(width: AppSpacing.md),
        Expanded(child: _buildMetric('Streak', '5 days')),
      ],
    );
  }

  Widget _buildMetric(String label, String value) {
    return AppCard(
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: AppSpacing.xs),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildWeeklyChart() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Weekly Focus', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            height: 200,
            child: Semantics(
              label: 'Bar chart showing focus hours for the last 7 days.',
              child: BarChart(
                BarChartData(
                  borderData: FlBorderData(show: false),
                  gridData: const FlGridData(show: false),
                  titlesData: FlTitlesData(
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (val, meta) {
                          const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                          return Text(days[val.toInt() % 7], style: const TextStyle(color: Colors.grey, fontSize: 12));
                        },
                      ),
                    ),
                  ),
                  barGroups: [
                    BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 2, color: Theme.of(context).colorScheme.primary)]),
                    BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 4, color: Theme.of(context).colorScheme.primary)]),
                    BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 3, color: Theme.of(context).colorScheme.primary)]),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveSessionWidget() {
    return AppCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Deep Work Session', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Ends in 45:00', style: TextStyle(color: Colors.grey)),
            ],
          ),
          CircularProgressIndicator(value: 0.6, color: Theme.of(context).colorScheme.secondary),
        ],
      ),
    );
  }

  Widget _buildUpcomingScheduleWidget() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Upcoming Schedule', style: TextStyle(fontWeight: FontWeight.bold)),
              TextButton(onPressed: () {}, child: const Text('View All')),
            ],
          ),
          const ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.nightlight_round),
            title: Text('Wind Down'),
            subtitle: Text('Today • 10:00 PM - 7:00 AM'),
          )
        ],
      ),
    );
  }
}
