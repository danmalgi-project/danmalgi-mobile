import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage;

  SecureStorageService(this._storage);

  final String _accessTokenKey = "accessToken";
  final String _deviceId = "device_id";

  Future<void> setAccessToken(String accessToken) async {
    try {
      await _storage.write(key: _accessTokenKey, value: accessToken);
      print("Token saved securely: $accessToken");
    } catch (e) {
      print("Error saving token: $e");
    }
  }

  Future<String?> getAccessToken() async {
    try {
      return await _storage.read(key: _accessTokenKey);
    } catch (e) {
      print("Error retrieving token: $e");
      return null;
    }
  }

  Future<void> deleteAccessToken() async {
    try {
      await _storage.delete(key: _accessTokenKey);
      print("Token deleted successfully!");
    } catch (e) {
      print("Error deleting storage: $e");
    }
  }

  Future<void> createDeviceId({required String deviceId}) async {
    try {
      await _storage.write(key: _deviceId, value: deviceId);
      print("DeviceId created securely: $deviceId");
    } catch (e) {
      print("Error creating device id: $e");
    }
  }

  Future<String?> getDeviceId() async {
    try {
      return await _storage.read(key: _deviceId);
    } catch (e) {
      print("Error retrieving device id: $e");
      return null;
    }
  }

  Future<void> deleteDeviceId() async {
    try {
      await _storage.delete(key: _deviceId);
      print("DeviceId deleted successfully!");
    } catch (e) {
      print("Error deleting device id: $e");
    }
  }

  Future<void> clearStorage() async {
    try {
      await _storage.deleteAll();
      print("Storage cleared successfully!");
    } catch (e) {
      print("Error clearing storage: $e");
    }
  }
}
