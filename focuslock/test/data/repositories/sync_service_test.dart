import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:focuslock/data/database/app_database.dart';
import 'package:focuslock/core/services/sync_service.dart';
import 'package:focuslock/data/repositories/blocked_app_repository_impl.dart';

class TestMockFirestore extends MockFirestore {
  bool throwNetworkError = false;
  bool throwDuplicateError = false;
  int callCount = 0;

  @override
  Future<void> syncDocument(String collection, String id, String payload, String operation) async {
    callCount++;
    if (throwNetworkError) throw Exception('NETWORK_FAILED');
    if (throwDuplicateError) throw Exception('ALREADY_EXISTS');
  }
}

void main() {
  late AppDatabase db;
  late MockConnectivity connectivity;
  late TestMockFirestore firestore;
  late SyncService syncService;
  late BlockedAppRepositoryImpl repository;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    connectivity = MockConnectivity();
    firestore = TestMockFirestore();
    syncService = SyncService(db, connectivity, firestore);
    repository = BlockedAppRepositoryImpl(db, syncService);
  });

  tearDown(() async {
    await db.close();
  });

  group('Sync Queue Mechanics', () {
    test('Offline Write: Saves to Drift and Enqueues Sync', () async {
      await repository.blockApp('user-1', 'com.example.app', 'Example App');

      // Verify Drift DB has the record
      final apps = await db.select(db.blockedApps).get();
      expect(apps.length, 1);
      expect(apps.first.packageName, 'com.example.app');

      // Verify Sync Queue has the item and processed it immediately (completedAt not null)
      final queue = await db.select(db.syncQueue).get();
      expect(queue.length, 1);
      expect(queue.first.completedAt, isNotNull);
      expect(firestore.callCount, 1);
    });

    test('Network Failure: Increments RetryCount and leaves completedAt null', () async {
      firestore.throwNetworkError = true;
      await repository.blockApp('user-1', 'com.example.app', 'Example App');

      final queue = await db.select(db.syncQueue).get();
      expect(queue.length, 1);
      expect(queue.first.completedAt, isNull);
      expect(queue.first.retryCount, 1); // Exponential backoff trigger
    });

    test('Idempotency Handling: Marks completed on duplicate without retrying', () async {
      firestore.throwDuplicateError = true;
      await repository.blockApp('user-1', 'com.example.app', 'Example App');

      final queue = await db.select(db.syncQueue).get();
      expect(queue.length, 1);
      expect(queue.first.completedAt, isNotNull); // Marked complete to prevent loop
      expect(queue.first.retryCount, 0);
    });
  });
}
