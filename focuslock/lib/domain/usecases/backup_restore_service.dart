import 'dart:convert';
import 'dart:io';
import '../../data/database/app_database.dart';
import '../../core/services/sync_service.dart';

class BackupRestoreService {
  final AppDatabase _db;
  final SyncService _syncService;

  BackupRestoreService(this._db, this._syncService);

  /// Generates a complete JSON representation of the user's configuration
  Future<String> exportBackup(String userId) async {
    final apps = await (_db.select(_db.blockedApps)..where((a) => a.userId.equals(userId))).get();
    
    final payload = {
      'version': 'v6.1',
      'timestamp': DateTime.now().toIso8601String(),
      'blockedApps': apps.map((a) => {
        'packageName': a.packageName,
        'appName': a.appName,
        'status': a.status
      }).toList(),
    };
    
    return jsonEncode(payload);
  }

  /// Restores configuration from a JSON backup file
  Future<void> importBackup(String userId, String jsonBackup) async {
    final Map<String, dynamic> data = jsonDecode(jsonBackup);
    final apps = data['blockedApps'] as List<dynamic>;

    for (var app in apps) {
      final packageName = app['packageName'];
      final appName = app['appName'];
      
      final id = DateTime.now().microsecondsSinceEpoch.toString();
      await _db.into(_db.blockedApps).insert(BlockedAppsCompanion(
        id: drift.Value(id),
        userId: drift.Value(userId),
        packageName: drift.Value(packageName),
        appName: drift.Value(appName),
        status: const drift.Value('active'),
        createdAt: drift.Value(DateTime.now()),
        updatedAt: drift.Value(DateTime.now()),
      ));

      await _syncService.enqueueOperation('blocked_apps', id, 'CREATE', {
        'userId': userId,
        'packageName': packageName,
        'appName': appName,
      });
    }
  }
}
