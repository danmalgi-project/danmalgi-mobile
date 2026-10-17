import 'dart:async';

import 'package:danmalgi_mobile/core/error/app_exception.dart';
import 'package:danmalgi_mobile/core/generated/dm/v1/dm.pb.dart';
import 'package:danmalgi_mobile/core/providers/app_message_notifier.dart';
import 'package:danmalgi_mobile/core/providers/app_user_provider.dart';
import 'package:danmalgi_mobile/core/providers/notification_provider.dart';
import 'package:danmalgi_mobile/features/directmessage/data/providers/direct_message_channel_repository_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'direct_message_channel_list_view_model.g.dart';

@Riverpod()
class DirectMessageChannelListViewModel
    extends _$DirectMessageChannelListViewModel {
  static final _log = Logger('dm.DirectMessageChannelListViewModel');

  Timer? debounce;
  bool _creating = false;

  @override
  Future<List<DirectMessageChannelListItem>> build() async {
    ref.watch(currentUserProvider); // Bind lifecycle to auth state

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

    return ref
        .read(directMessageChannelRepositoryProvider)
        .getDirectMessageChannelList();
  }

  Future<DirectMessageChannel?> createDirectMessageChannel({
    required List<Int64> friendIds,
  }) async {
    if (_creating) return null;
    _creating = true;
    try {
      final newChannel = await ref
          .read(directMessageChannelRepositoryProvider)
          .createDirectMessageChannel(friendIds: friendIds);

      unawaited(refresh());
      return newChannel;
    } on AppException catch (e) {
      ref.read(appMessageNotifierProvider.notifier).show(e.message);
      return null;
    } catch (e) {
      ref.read(appMessageNotifierProvider.notifier).show("알 수 없는 오류가 발생했습니다.");
      return null;
    } finally {
      _creating = false;
    }
  }

  Future<DirectMessageChannel?> updateDirectMessageChannel({
    required Int64 id,
    String? channelName,
    List<int>? imageBytes,
    String? extension,
  }) async {
    try {
      final newChannel = await ref
          .read(directMessageChannelRepositoryProvider)
          .updateDirectMessageChannel(
            id: id,
            channelName: channelName,
            imageBytes: imageBytes,
            extension: extension,
          );

      unawaited(refresh());
      return newChannel;
    } on AppException catch (e) {
      ref.read(appMessageNotifierProvider.notifier).show(e.message);
      return null;
    } catch (e) {
      ref.read(appMessageNotifierProvider.notifier).show("알 수 없는 오류가 발생했습니다.");
      return null;
    }
  }

  Future<void> leaveDirectMessageChannel({required Int64 id}) async {
    try {
      await ref
          .read(directMessageChannelRepositoryProvider)
          .leaveDirectMessageChannel(id: id);

      unawaited(refresh());
    } on AppException catch (e) {
      ref.read(appMessageNotifierProvider.notifier).show(e.message);
    } catch (e) {
      ref.read(appMessageNotifierProvider.notifier).show("알 수 없는 오류가 발생했습니다.");
    }
  }

  void scheduleRefresh() {
    debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 800), () {
      if (state.hasValue) refresh();
    });
  }

  Future<void> refresh() async {
    try {
      state = AsyncData(
        await ref
            .read(directMessageChannelRepositoryProvider)
            .getDirectMessageChannelList(),
      );
    } catch (e, st) {
      _log.warning('Failed to refresh DM channel list', e, st);
    }
  }
}
