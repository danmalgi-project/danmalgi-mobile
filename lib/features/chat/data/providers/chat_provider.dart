import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:danmalgi_mobile/core/providers/network_provider.dart';
import 'package:danmalgi_mobile/features/chat/data/repositories/chat_repository.dart';
import 'package:danmalgi_mobile/features/user/data/providers/user_provider.dart';

final chatRepositoryProvider = Provider.autoDispose((ref) {
  final client = ref.watch(chatServiceClientProvider);
  final userRepository = ref.read(userRepositoryProvider);
  return ChatRepository(client, userRepository);
});
