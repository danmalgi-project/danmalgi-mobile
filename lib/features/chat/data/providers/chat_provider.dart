import 'package:danmalgi_mobile/core/providers/network_provider.dart';
import 'package:danmalgi_mobile/features/chat/data/repositories/chat_repository.dart';
import 'package:danmalgi_mobile/features/user/data/providers/user_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_provider.g.dart';

@Riverpod(keepAlive: true)
ChatRepository chatRepository(Ref ref) {
  final client = ref.watch(chatServiceClientProvider);
  final userRepository = ref.watch(userRepositoryProvider);
  return ChatRepository(client, userRepository);
}
