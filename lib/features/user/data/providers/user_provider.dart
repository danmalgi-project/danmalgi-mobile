import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:danmalgi_mobile/core/providers/network_provider.dart';
import 'package:danmalgi_mobile/core/providers/storage_provider.dart';
import 'package:danmalgi_mobile/features/user/data/repositories/user_repository.dart';

final userRepositoryProvider = Provider((ref) {
  final client = ref.watch(userServiceClientProvider);
  final authClient = ref.watch(userAuthServiceClientProvider);
  final localStorage = ref.watch(localStorageServiceProvider);
  return UserRepository(client, authClient, localStorage);
});
