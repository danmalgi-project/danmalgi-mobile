import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:danmalgi_mobile/core/providers/network_provider.dart';
import 'package:danmalgi_mobile/features/directmessage/data/repositories/direct_message_repository.dart';

final directMessageChannelRepositoryProvider = Provider((ref) {
  final client = ref.read(directMessageServiceClientProvider);
  return DirectMessageChannelRepository(client);
});
