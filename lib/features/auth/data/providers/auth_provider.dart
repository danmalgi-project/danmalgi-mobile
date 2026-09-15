import 'package:danmalgi_mobile/features/auth/data/authenticators/google_authenticator.dart';
import 'package:danmalgi_mobile/features/auth/domain/social_authenticator.dart';
import 'package:danmalgi_mobile/features/user/domain/oauth_type.dart';
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
