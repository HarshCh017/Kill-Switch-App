import 'package:flutter_test/flutter_test.dart';
import 'package:focuslock/domain/usecases/schedule_evaluator.dart';
import 'package:focuslock/data/database/app_database.dart';

void main() {
  group('ScheduleEvaluator Unit Tests', () {
    test('isScheduleActive returns true if current time is within bounds', () {
      final evaluator = ScheduleEvaluator();
      
      // Simulate a schedule: 9:00 AM to 5:00 PM on Monday (day 1)
      final schedule = Schedule(
        id: '1',
        blockedAppId: 'app1',
        startHour: 9,
        startMinute: 0,
        endHour: 17,
        endMinute: 0,
        daysOfWeek: '[1]',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Assume today is Monday, 10:30 AM
      final now = DateTime(2023, 10, 2, 10, 30); // 2023-10-02 was a Monday
      
      final isActive = evaluator.isScheduleActive(schedule, currentTime: now);
      expect(isActive, isTrue);
    });

    test('isScheduleActive returns false if outside time bounds', () {
      final evaluator = ScheduleEvaluator();
      
      final schedule = Schedule(
        id: '1',
        blockedAppId: 'app1',
        startHour: 9,
        startMinute: 0,
        endHour: 17,
        endMinute: 0,
        daysOfWeek: '[1]',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Monday, 8:00 PM
      final now = DateTime(2023, 10, 2, 20, 0);
      
      final isActive = evaluator.isScheduleActive(schedule, currentTime: now);
      expect(isActive, isFalse);
    });
  });
}
