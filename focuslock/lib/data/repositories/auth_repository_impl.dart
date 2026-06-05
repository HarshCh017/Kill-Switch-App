import 'package:drift/drift.dart';
// import 'package:firebase_auth/firebase_auth.dart' as firebase;
// import 'package:google_sign_in/google_sign_in.dart';
import '../../domain/repositories/auth_repository.dart';
import '../database/app_database.dart';

// Firebase Mock interfaces for the scaffolding testability
class MockUser {
  final String uid;
  final String email;
  MockUser(this.uid, this.email);
}

class MockFirebaseAuth {
  Stream<MockUser?> authStateChanges() => const Stream.empty();
  Future<MockUserCredential> signInWithEmailAndPassword(String email, String password) async => MockUserCredential();
  Future<MockUserCredential> createUserWithEmailAndPassword(String email, String password) async => MockUserCredential();
  Future<void> signOut() async {}
  Future<void> sendPasswordResetEmail(String email) async {}
  Future<MockUserCredential> signInWithCredential(dynamic credential) async => MockUserCredential();
}

class MockUserCredential {
  final user = MockUser('mock-uuid-1234', 'test@example.com');
}

class MockGoogleSignIn {
  Future<dynamic> signIn() async => MockGoogleSignInAccount();
}

class MockGoogleSignInAccount {
  Future<dynamic> get authentication async => MockGoogleSignInAuthentication();
}

class MockGoogleSignInAuthentication {
  final String accessToken = 'mock-access';
  final String idToken = 'mock-id';
}

class MockGoogleAuthProvider {
  static dynamic credential({required String accessToken, required String idToken}) => null;
}

class AuthRepositoryImpl implements AuthRepository {
  final MockFirebaseAuth _firebaseAuth;
  final MockGoogleSignIn _googleSignIn;
  final AppDatabase _db;

  AuthRepositoryImpl(this._firebaseAuth, this._googleSignIn, this._db);

  @override
  Stream<String?> get authStateChanges {
    return _firebaseAuth.authStateChanges().map((user) => user?.uid);
  }

  @override
  Future<String?> login(String email, String password) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(email, password);
    final user = credential.user;
    if (user != null) {
      await _syncUserToLocal(user.uid, user.email);
      return user.uid;
    }
    return null;
  }

  @override
  Future<String?> register(String email, String password) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(email, password);
    final user = credential.user;
    if (user != null) {
      await _syncUserToLocal(user.uid, user.email);
      return user.uid;
    }
    return null;
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email);
  }

  @override
  Future<String?> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;
    final credential = MockGoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    final user = userCredential.user;
    
    if (user != null) {
      await _syncUserToLocal(user.uid, user.email);
      return user.uid;
    }
    return null;
  }

  /// Syncs the remote Firebase user to the local Drift database.
  /// This fulfills the v6.1 Task 2.3 requirement for offline-first User Sync.
  Future<void> _syncUserToLocal(String uid, String? email) async {
    await _db.into(_db.users).insertOnConflictUpdate(
      UsersCompanion(
        id: Value(uid),
        email: Value(email),
        createdAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
}
