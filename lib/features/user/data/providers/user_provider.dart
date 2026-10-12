import 'package:danmalgi_mobile/core/providers/network_provider.dart';
import 'package:danmalgi_mobile/features/user/data/repositories/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@Riverpod(keepAlive: true)
UserRepository userRepository(Ref ref) {
  final client = ref.watch(userServiceClientProvider);
  final authClient = ref.watch(userAuthServiceClientProvider);
  return UserRepository(client, authClient);
}
