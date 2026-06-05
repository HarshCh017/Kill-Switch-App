import 'package:drift/drift.dart';
import '../../core/services/sync_service.dart';
import '../database/app_database.dart';

class BlockedAppRepositoryImpl {
  final AppDatabase _db;
  final SyncService _syncService;

  BlockedAppRepositoryImpl(this._db, this._syncService);

  Future<void> blockApp(String userId, String packageName, String appName) async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    
    final companion = BlockedAppsCompanion(
      id: Value(id),
      userId: Value(userId),
      packageName: Value(packageName),
      appName: Value(appName),
      status: const Value('active'),
      createdAt: Value(DateTime.now()),
      updatedAt: Value(DateTime.now()),
    );

    // 1. Write to Drift (Offline-First)
    await _db.into(_db.blockedApps).insert(companion);

    // 2. Queue for Firestore Sync
    await _syncService.enqueueOperation(
      'blocked_apps',
      id,
      'CREATE',
      {
        'userId': userId,
        'packageName': packageName,
        'appName': appName,
        'status': 'active'
      },
    );
  }
}
