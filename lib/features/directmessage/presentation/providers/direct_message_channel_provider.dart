import 'package:collection/collection.dart';
import 'package:danmalgi_mobile/core/generated/dm/v1/dm.pb.dart';
import 'package:danmalgi_mobile/features/directmessage/data/providers/direct_message_channel_repository_provider.dart';
import 'package:danmalgi_mobile/features/directmessage/presentation/providers/direct_message_channel_list_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'direct_message_channel_provider.g.dart';

@riverpod
Future<DirectMessageChannel> directMessageChannel(
  Ref ref,
  int channelId,
) async {
  final cached = ref.watch(
    directMessageChannelListViewModelProvider.select(
      (s) => s.value
          ?.firstWhereOrNull((i) => i.channel.dmId.toInt() == channelId)
          ?.channel,
    ),
  );
  if (cached != null) return cached;

  final remote = await ref
      .read(directMessageChannelRepositoryProvider)
      .getDirectMessageChannel(id: channelId);
  return remote;
}
