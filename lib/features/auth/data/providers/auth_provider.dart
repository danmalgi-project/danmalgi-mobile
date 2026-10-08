import 'package:danmalgi_mobile/core/providers/network_provider.dart';
import 'package:danmalgi_mobile/features/auth/data/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final client = ref.watch(authServiceClientProvider);
  return AuthRepository(client);
});
