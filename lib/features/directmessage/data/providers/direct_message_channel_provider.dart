import 'dart:async';

import 'package:danmalgi_mobile/core/generated/dm/v1/dm.pb.dart';
import 'package:danmalgi_mobile/core/providers/app_user_provider.dart';

import 'package:danmalgi_mobile/features/directmessage/presentation/providers/direct_message_channel_list_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'direct_message_channel_provider.g.dart';

@riverpod
Future<DirectMessageChannel> directMessageChannel(
  Ref ref, {
  required int channelId,
}) async {
  ref.watch(currentUserProvider);

  return ref
      .read(directMessageChannelListViewModelProvider.notifier)
      .fetchDirectMessageChannel(id: channelId);
}
