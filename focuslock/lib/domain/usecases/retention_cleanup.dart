import 'package:drift/drift.dart';
import '../../data/database/app_database.dart';

class RetentionCleanup {
  final AppDatabase _db;

  RetentionCleanup(this._db);

  /// Executes the updated v4.0 UI/UX retention policy
  /// Universally enforces 90 days since subscriptions were removed.
  Future<void> cleanOldEvents(String userId) async {
    final retentionDays = 90;
    final cutoffDate = DateTime.now().subtract(Duration(days: retentionDays));

    await (_db.delete(_db.events)
          ..where((e) => e.userId.equals(userId))
          ..where((e) => e.timestamp.isSmallerThanValue(cutoffDate)))
        .go();
  }
}
