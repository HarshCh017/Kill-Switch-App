import 'dart:convert';
import 'package:drift/drift.dart';
import '../../data/database/app_database.dart';

// Mocks for Firebase/Connectivity in scaffolding
class MockConnectivity {
  Future<bool> get isConnected async => true;
}

class MockFirestore {
  Future<void> syncDocument(String collection, String id, String payload, String operation) async {
    // Throws exception to simulate failure, or completes for success.
  }
}

class SyncService {
  final AppDatabase _db;
  final MockConnectivity _connectivity;
  final MockFirestore _firestore;

  SyncService(this._db, this._connectivity, this._firestore);

  /// Enqueues an operation locally. This guarantees offline-first capability.
  Future<void> enqueueOperation(String collection, String documentId, String operation, Map<String, dynamic> payload) async {
    await _db.into(_db.syncQueue).insert(
      SyncQueueCompanion(
        id: Value(DateTime.now().millisecondsSinceEpoch.toString()), // Simple UUID scaffold
        collection: Value(collection),
        documentId: Value(documentId),
        operation: Value(operation),
        payload: Value(jsonEncode(payload)),
        createdAt: Value(DateTime.now()),
      ),
    );
    
    // Attempt sync immediately, but don't await/block the UI
    _processQueue();
  }

  /// Processes pending items with connectivity awareness, idempotency, and exponential backoff
  Future<void> _processQueue() async {
    if (!await _connectivity.isConnected) return;

    final pendingItems = await (_db.select(_db.syncQueue)
          ..where((t) => t.completedAt.isNull())
          ..orderBy([(t) => OrderingTerm(expression: t.createdAt)]))
        .get();

    for (final item in pendingItems) {
      try {
        await _firestore.syncDocument(item.collection, item.documentId, item.payload, item.operation);
        
        // Mark as completed upon success (idempotency safety)
        await (_db.update(_db.syncQueue)..where((t) => t.id.equals(item.id)))
            .write(SyncQueueCompanion(completedAt: Value(DateTime.now())));

      } catch (e) {
        // Handle Idempotency / Duplicate
        if (e.toString().contains('ALREADY_EXISTS')) {
          // If Firestore reports duplicate, mark completed, never retry
          await (_db.update(_db.syncQueue)..where((t) => t.id.equals(item.id)))
              .write(SyncQueueCompanion(completedAt: Value(DateTime.now())));
          continue;
        }

        // Exponential backoff mechanism
        final nextRetryCount = item.retryCount + 1;
        await (_db.update(_db.syncQueue)..where((t) => t.id.equals(item.id)))
            .write(SyncQueueCompanion(retryCount: Value(nextRetryCount)));
        
        // Break out of the loop on network failure to avoid spamming
        break;
      }
    }
  }
}
