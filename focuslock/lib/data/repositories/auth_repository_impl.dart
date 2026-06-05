import 'package:drift/drift.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:google_sign_in/google_sign_in.dart';
import '../../domain/repositories/auth_repository.dart';
import '../database/app_database.dart';

class AuthRepositoryImpl implements AuthRepository {
  final firebase.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final AppDatabase _db;

  AuthRepositoryImpl(this._firebaseAuth, this._googleSignIn, this._db);

  @override
  Stream<String?> get authStateChanges {
    return _firebaseAuth.authStateChanges().map((user) => user?.uid);
  }

  @override
  Future<String?> login(String email, String password) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    final user = credential.user;
    if (user != null) {
      await _syncUserToLocal(user.uid, user.email);
      return user.uid;
    }
    return null;
  }

  @override
  Future<String?> register(String email, String password) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    final user = credential.user;
    if (user != null) {
      await _syncUserToLocal(user.uid, user.email);
      return user.uid;
    }
    return null;
  }

  @override
  Future<void> logout() async {
    await Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  @override
  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<String?> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;
    final credential = firebase.GoogleAuthProvider.credential(
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
