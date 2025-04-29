import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const _storage = FlutterSecureStorage();
  static const _pinKey = 'user_pin';

  // Save user pin
  static Future<void> savePin(String pin) async {
    await _storage.write(key: _pinKey, value: pin);
  }

  // Get user pin
  static Future<String?> getPin() async {
    return await _storage.read(key: _pinKey);
  }

  // Delete user pin
  static Future<void> deletePin() async {
    await _storage.delete(key: _pinKey);
  }
}
