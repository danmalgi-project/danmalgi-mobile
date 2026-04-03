import 'package:danmalgi_mobile/core/providers/local_user_settings_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:danmalgi_mobile/core/providers/network_provider.dart';
import 'package:danmalgi_mobile/core/providers/storage_provider.dart';
import 'package:danmalgi_mobile/features/auth/data/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final client = ref.watch(authServiceClientProvider);
  final secureStorage = ref.watch(secureStorageProvider);
  final localStorage = ref.watch(localStorageServiceProvider);

  ref.onDispose(() => print("authRepository Disposed"));

  return AuthRepository(client, secureStorage, localStorage);
});
