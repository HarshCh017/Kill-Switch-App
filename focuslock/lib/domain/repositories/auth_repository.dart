abstract class AuthRepository {
  Stream<String?> get authStateChanges;
  
  Future<String?> login(String email, String password);
  Future<String?> register(String email, String password);
  Future<void> logout();
  Future<void> resetPassword(String email);
  Future<String?> signInWithGoogle();
}
