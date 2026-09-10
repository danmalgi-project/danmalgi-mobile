import 'dart:async';

import 'package:danmalgi_mobile/core/error/app_exception.dart';
import 'package:danmalgi_mobile/core/providers/app_message_notifier.dart';
import 'package:danmalgi_mobile/core/providers/app_user_provider.dart';
import 'package:danmalgi_mobile/core/providers/notification_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:danmalgi_mobile/core/generated/dm/v1/dm.pb.dart';
import 'package:danmalgi_mobile/features/directmessage/data/providers/direct_message_channel_repository_provider.dart';
import 'package:danmalgi_mobile/features/directmessage/data/repositories/direct_message_channel_repository.dart';
import 'package:danmalgi_mobile/features/directmessage/domain/direct_message_channel_list_state.dart';
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'direct_message_channel_list_view_model.g.dart';

@Riverpod()
class DirectMessageChannelListViewModel
    extends _$DirectMessageChannelListViewModel {
  bool _showBackToTopButton = false;
  final int _limit = 10;

  @override
  Future<DirectMessageChannelListState> build() async {
    ref.watch(currentUserProvider); // Bind lifecycle to auth state

    Timer? debounce;
    void scheduleRefresh() {
      debounce?.cancel();
      debounce = Timer(const Duration(milliseconds: 800), () {
        if (state.hasValue) refresh();
      });
    }

    ref.onDispose(() => debounce?.cancel());

    ref.listen(foregroundMessageProvider, (_, next) {
      final RemoteMessage? msg = next.value;
      if (msg == null || msg.notification == null) return;
      scheduleRefresh();
    });

    AppLifecycleState? last;
    final lifecycle = AppLifecycleListener(
      onStateChange: (next) {
        if (last == AppLifecycleState.paused &&
            next == AppLifecycleState.resumed) {
          scheduleRefresh();
        }
        last = next;
      },
    );
    ref.onDispose(lifecycle.dispose);

    final initialData = await ref
        .read(directMessageChannelRepositoryProvider)
        .getDirectMessageChannelList(offset: 0, limit: _limit);

    return DirectMessageChannelListState(directMessageChannelList: initialData);
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

  Future<void> refresh() async {
    try {
      final data = await ref
          .read(directMessageChannelRepositoryProvider)
          .getDirectMessageChannelList(offset: 0, limit: _limit);

      final current = state.value;
      state = AsyncData(
        (current ?? const DirectMessageChannelListState()).copyWith(
          directMessageChannelList: data,
        ),
      );
    } catch (e) {}
  }

  Future<void> showBackToTop({bool show = false}) async {
    if (!(_showBackToTopButton == show)) {
      _showBackToTopButton = show;
    } else {
      _showBackToTopButton = show;
    }
  }
}
