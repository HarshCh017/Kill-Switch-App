import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/theme/app_spacing.dart';
import '../../widgets/common/app_card.dart';
import 'widgets/insights_card.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Theme.of(context).colorScheme.primary,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Theme.of(context).colorScheme.primary,
          tabs: const [
            Tab(text: 'Day'),
            Tab(text: 'Week'),
            Tab(text: 'Month'),
            Tab(text: 'Year'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAnalyticsView('Today', 'Focused 45 minutes today, 12% more than yesterday.'),
          _buildAnalyticsView('This Week', 'Focused 14 hours this week. Most productive day was Tuesday.'),
          _buildAnalyticsView('This Month', 'Focused 52 hours this month. 430 distractions blocked.'),
          _buildAnalyticsView('This Year', 'Focused 200 hours this year. Longest streak: 14 days.'),
        ],
      ),
    );
  }

  Widget _buildAnalyticsView(String period, String accessibilitySummary) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Accessibility Requirement: Text Summary
          Semantics(
            header: true,
            child: Text(accessibilitySummary, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ),
          const SizedBox(height: AppSpacing.xl),
          
          Row(
            children: [
              Expanded(child: _buildMetricCard('Focus Time', '4h 12m')),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: _buildMetricCard('Distractions', '42')),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(child: _buildMetricCard('Longest Streak', '5 days')),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: _buildMetricCard('Avg Session', '45m')),
            ],
          ),
          
          const SizedBox(height: AppSpacing.xl),
          const Text('Focus Trend', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: AppSpacing.md),
          _buildChart(accessibilitySummary),
          
          const SizedBox(height: AppSpacing.xl),
          const InsightsCard(
            title: 'Weekly Insight',
            insight: 'You are 40% more likely to be distracted by Social Media between 2 PM and 4 PM. Consider scheduling a Deep Work block then.',
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String label, String value) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: AppSpacing.xs),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildChart(String semanticsLabel) {
    return AppCard(
      child: SizedBox(
        height: 200,
        child: Semantics(
          label: 'Trend Chart. $semanticsLabel',
          child: LineChart(
            LineChartData(
              gridData: const FlGridData(show: false),
              titlesData: const FlTitlesData(
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: const [
                    FlSpot(0, 1),
                    FlSpot(1, 3),
                    FlSpot(2, 2),
                    FlSpot(3, 4),
                    FlSpot(4, 3.5),
                  ],
                  isCurved: true,
                  color: Theme.of(context).colorScheme.primary,
                  barWidth: 4,
                  dotData: const FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
