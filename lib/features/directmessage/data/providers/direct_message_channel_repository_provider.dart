import 'package:danmalgi_mobile/core/providers/network_provider.dart';
import 'package:danmalgi_mobile/features/directmessage/data/repositories/direct_message_channel_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'direct_message_channel_repository_provider.g.dart';

@Riverpod(keepAlive: true)
DirectMessageChannelRepository directMessageChannelRepository(Ref ref) {
  final client = ref.read(directMessageServiceClientProvider);
  return DirectMessageChannelRepository(client);
}
