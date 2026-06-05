import 'package:flutter/services.dart';
import '../../data/database/app_database.dart';

class ScheduleEvaluator {
  final AppDatabase _db;
  static const _channel = MethodChannel('com.focuslock.focus_lock/method');

  ScheduleEvaluator(this._db);

  /// Analyzes all schedules to determine which apps are currently blocked.
  /// Task 5.1 & 5.2: Temporary and Recurring schedules logic.
  Future<void> evaluateAndApplySchedules() async {
    final now = DateTime.now();
    final currentHour = now.hour;
    final currentMinute = now.minute;
    final currentWeekday = now.weekday; // 1 = Mon, 7 = Sun

    // Fetch all active schedules joined with blocked apps
    final activeSchedulesQuery = _db.select(_db.schedules).join([
      innerJoin(_db.blockedApps, _db.blockedApps.id.equalsExp(_db.schedules.blockedAppId)),
    ]);

    final List<String> activeBlockedPackages = [];

    final results = await activeSchedulesQuery.get();

    for (final row in results) {
      final schedule = row.readTable(_db.schedules);
      final blockedApp = row.readTable(_db.blockedApps);

      if (blockedApp.status != 'active') continue;

      // Check Weekday
      final activeDays = _parseDaysOfWeek(schedule.daysOfWeek);
      if (!activeDays.contains(currentWeekday)) continue;

      // Check Time Constraints
      final startTotalMinutes = (schedule.startHour * 60) + schedule.startMinute;
      final endTotalMinutes = (schedule.endHour * 60) + schedule.endMinute;
      final currentTotalMinutes = (currentHour * 60) + currentMinute;

      if (currentTotalMinutes >= startTotalMinutes && currentTotalMinutes <= endTotalMinutes) {
        activeBlockedPackages.add(blockedApp.packageName);
      }
    }

    // Refresh the native Android cache (O(1) requirement from Task 4.1 & 5.2)
    await _updateNativeBlockCache(activeBlockedPackages);
  }

  Future<void> _updateNativeBlockCache(List<String> packages) async {
    try {
      await _channel.invokeMethod('refreshBlockCache', {'packages': packages});
    } on PlatformException catch (e) {
      // Handle native bridge failure silently in background
      print("Failed to update cache: '${e.message}'.");
    }
  }

  List<int> _parseDaysOfWeek(String jsonStr) {
    // Scaffold: Assuming JSON like "[1,2,3,4,5]" for Mon-Fri
    return [1, 2, 3, 4, 5, 6, 7]; 
  }
}
