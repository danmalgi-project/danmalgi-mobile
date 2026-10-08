import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logging/logging.dart';

class SecureStorageService {
  static final _log = Logger('storage.SecureStorageService');

  final FlutterSecureStorage _storage;

  SecureStorageService(this._storage);

  final String _accessTokenKey = "accessToken";
  final String _deviceId = "device_id";

  Future<void> setAccessToken(String accessToken) async {
    try {
      await _storage.write(key: _accessTokenKey, value: accessToken);
      _log.fine("Token saved securely");
    } catch (e, st) {
      _log.severe("Failed to save token", e, st);
    }
  }

  Future<String?> getAccessToken() async {
    try {
      return await _storage.read(key: _accessTokenKey);
    } catch (e, st) {
      _log.severe("Failed to get token", e, st);
      return null;
    }
  }

  Future<void> deleteAccessToken() async {
    try {
      await _storage.delete(key: _accessTokenKey);
      _log.fine("Token deleted successfully!");
    } catch (e, st) {
      _log.severe("Failed to delete token", e, st);
    }
  }

  Future<void> createDeviceId({required String deviceId}) async {
    try {
      await _storage.write(key: _deviceId, value: deviceId);
      _log.fine("DeviceId created securely");
    } catch (e, st) {
      _log.severe("Failed to create deviceId", e, st);
    }
  }

  Future<String?> getDeviceId() async {
    try {
      return await _storage.read(key: _deviceId);
    } catch (e, st) {
      _log.severe("Failed to get deviceId", e, st);
      return null;
    }
  }

  Future<void> deleteDeviceId() async {
    try {
      await _storage.delete(key: _deviceId);
      _log.fine("DeviceId deleted successfully!");
    } catch (e, st) {
      _log.severe("Failed to delete deviceId", e, st);
    }
  }

  Future<void> clearStorage() async {
    try {
      await _storage.deleteAll();
      _log.fine("Storage cleared successfully!");
    } catch (e, st) {
      _log.severe("Failed to clear storage", e, st);
    }
  }
}
