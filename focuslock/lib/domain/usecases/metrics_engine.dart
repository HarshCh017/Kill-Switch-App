import 'package:drift/drift.dart';
import '../../data/database/app_database.dart';

class MetricsEngine {
  final AppDatabase _db;

  MetricsEngine(this._db);

  /// Generates the total blocked attempts derived entirely from the Event Store (Task 6.2)
  /// NEVER use precomputed counters. Always dynamically calculate from the single source of truth.
  Future<int> getTotalBlockedAttempts(String userId) async {
    final query = _db.select(_db.events)
      ..where((e) => e.userId.equals(userId))
      ..where((e) => e.eventType.equals('blocked_attempt'));
      
    final results = await query.get();
    return results.length;
  }

  /// Calculates total focus time from `session_start` and `session_end` events.
  Future<Duration> calculateTotalFocusTime(String userId) async {
    // In production, this would fold over the event stream calculating deltas between start/end
    final query = _db.select(_db.events)
      ..where((e) => e.userId.equals(userId))
      ..where((e) => e.eventType.isIn(['session_start', 'session_end']))
      ..orderBy([(e) => OrderingTerm(expression: e.timestamp)]);
      
    final events = await query.get();
    Duration totalFocus = Duration.zero;
    DateTime? sessionStart;

    for (final event in events) {
      if (event.eventType == 'session_start') {
        sessionStart = event.timestamp;
      } else if (event.eventType == 'session_end' && sessionStart != null) {
        totalFocus += event.timestamp.difference(sessionStart);
        sessionStart = null;
      }
    }
    
    return totalFocus;
  }
}
