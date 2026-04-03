import 'package:danmalgi_mobile/core/services/local_user_settings_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:danmalgi_mobile/core/providers/storage_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_user_settings_service_provider.g.dart';

@Riverpod(keepAlive: true)
LocalUserSettingsService localUserSettingsService(Ref ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  final localStorage = ref.watch(localStorageServiceProvider);
  return LocalUserSettingsService(secureStorage, localStorage);
}

@riverpod
Future<String> deviceId(Ref ref) async {
  final id = await ref
      .read(localUserSettingsServiceProvider)
      .getOrCreateDeviceId();
  print(id);
  return id;

  // return ref.read(localUserSettingsServiceProvider).getOrCreateDeviceId();
}
