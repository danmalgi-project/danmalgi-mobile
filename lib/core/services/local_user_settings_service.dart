import 'package:danmalgi_mobile/core/services/local_storage_service.dart';
import 'package:danmalgi_mobile/core/services/secure_storage_service.dart';
import 'package:uuid/uuid.dart';

class LocalUserSettingsService {
  final SecureStorageService secureStorage;
  final LocalStorageService localStorage;

  LocalUserSettingsService(this.secureStorage, this.localStorage);

  Future<String> getOrCreateDeviceId() async {
    final existing = await secureStorage.getDeviceId();
    if (existing != null) return existing;

    final newId = const Uuid().v4();
    await secureStorage.createDeviceId(deviceId: newId);
    return newId;
  }
}
