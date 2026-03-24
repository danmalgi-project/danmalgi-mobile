import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:danmalgi_mobile/core/providers/device_info_provider.dart';
import 'package:danmalgi_mobile/core/providers/network_provider.dart';
import 'package:danmalgi_mobile/core/providers/storage_provider.dart';
import 'package:danmalgi_mobile/features/auth/data/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final client = ref.watch(authServiceClientProvider);
  final secureStorage = ref.watch(secureStorageProvider);
  final localStorage = ref.watch(localStorageServiceProvider);
  final deviceId = ref.read(deviceInfoProvider).value ?? "test";

  ref.onDispose(() => print("authRepository Disposed"));

  return AuthRepository(client, secureStorage, localStorage, deviceId);
});
