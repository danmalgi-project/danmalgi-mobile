import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService{
  final FlutterSecureStorage _storage;

  SecureStorageService(this._storage);

  final String _accessTokenKey = "accessToken";

  Future<void> setAccessToken(String accessToken) async {
    try {
      await _storage.write(key: _accessTokenKey, value: accessToken);
      print("Token saved securely: $accessToken");
    } catch (e) {
      print("rror saving token: $e");
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
      print("Storage deleted successfully!");
    } catch (e) {
      print("Error deleting storage: $e");
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