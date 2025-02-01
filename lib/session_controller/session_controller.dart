import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:task/session_controller/session_manage.dart';

class SecureStorageSession implements SessionManager {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  @override
  Future<void> saveSession(String token) async {
    await _storage.write(key: 'auth_token', value: token);
  }

  @override
  Future<String?> getSession() async {
    return await _storage.read(key: 'auth_token');
  }

  @override
  Future<void> clearSession() async {
    await _storage.delete(key: 'auth_token');
  }
}
