import 'dart:async';

import 'package:danmalgi_mobile/core/error/app_exception.dart';
import 'package:danmalgi_mobile/core/providers/app_message_notifier.dart';
import 'package:danmalgi_mobile/core/providers/app_user_provider.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:danmalgi_mobile/core/generated/dm/v1/dm.pb.dart';
import 'package:danmalgi_mobile/features/directmessage/data/providers/direct_message_channel_repository_provider.dart';
import 'package:danmalgi_mobile/features/directmessage/data/repositories/direct_message_channel_repository.dart';
import 'package:danmalgi_mobile/features/directmessage/domain/direct_message_channel_list_state.dart';
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart';

final directMessageChannelListViewModelProvider =
    AsyncNotifierProvider<
      DirectMessageChannelListViewModel,
      DirectMessageChannelListState
    >(DirectMessageChannelListViewModel.new, retry: (_, _) => null);

class DirectMessageChannelListViewModel
    extends AsyncNotifier<DirectMessageChannelListState> {
  bool _showBackToTopButton = false;
  final int _limit = 10;

  @override
  FutureOr<DirectMessageChannelListState> build() async {
    ref.watch(currentUserProvider); // Bind lifecycle to auth state

    final initialData = await ref
        .read(directMessageChannelRepositoryProvider)
        .getDirectMessageChannelList(offset: 0, limit: _limit);

    final testData = List.generate(
      20,
      (i) => DirectMessageChannelListItem(
        channel: DirectMessageChannel(
          dmId: Int64(1000 + i),
          channelName: "[TEST$i]",
        ),
        lastMessage: LastMessage(
          messageId: Int64(1),
          content: "어 내가 $i인데",
          senderId: Int64(9999),
          createdAt: Timestamp.fromDateTime(DateTime.now()),
        ),
      ),
    );

    return DirectMessageChannelListState(
      directMessageChannelList: [...initialData, ...testData],
    );
  }

  Future<DirectMessageChannel?> createDirectMessageChannel({
    required List<Int64> friendIds,
  }) async {
    try {
      final newChannel = await ref
          .read(directMessageChannelRepositoryProvider)
          .createDirectMessageChannel(friendIds: friendIds);

      final currentState = state.requireValue;
      state = AsyncData(
        currentState.copyWith(
          directMessageChannelList: [
            DirectMessageChannelListItem(channel: newChannel),
            ...currentState.directMessageChannelList,
          ],
          currentOffset: currentState.currentOffset + 1,
        ),
      );

      return newChannel;
    } on AppException catch (e) {
      ref.read(appMessageNotifierProvider.notifier).show(e.message);
      return null;
    } catch (e) {
      ref.read(appMessageNotifierProvider.notifier).show("알 수 없는 오류가 발생했습니다.");
      return null;
    }
  }

  Future<DirectMessageChannel> fetchDirectMessageChannel({
    required int id,
  }) async {
    final currentState = state.value;
    if (currentState != null) {
      final cachedChannel = currentState.directMessageChannelList
          .where((item) => item.channel.dmId.toInt() == id)
          .firstOrNull;

      if (cachedChannel != null) {
        return cachedChannel.channel;
      }
    }

    final channel = await ref
        .read(directMessageChannelRepositoryProvider)
        .getDirectMessageChannel(id: id);

    return channel;
  }

  Future<void> showBackToTop({bool show = false}) async {
    if (!(_showBackToTopButton == show)) {
      _showBackToTopButton = show;
    } else {
      _showBackToTopButton = show;
    }
  }
}
