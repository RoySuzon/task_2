abstract class SessionManager {
  Future<void> saveSession(String token);
  Future<String?> getSession();
  Future<void> clearSession();
}
