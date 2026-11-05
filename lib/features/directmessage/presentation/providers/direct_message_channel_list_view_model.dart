import 'dart:async';

import 'package:danmalgi_mobile/core/error/app_exception.dart';
import 'package:danmalgi_mobile/core/extensions/ref_extensions.dart';
import 'package:danmalgi_mobile/core/generated/dm/v1/dm.pb.dart';
import 'package:danmalgi_mobile/core/providers/app_message_notifier.dart';
import 'package:danmalgi_mobile/core/providers/app_user_provider.dart';
import 'package:danmalgi_mobile/core/providers/notification_provider.dart';
import 'package:danmalgi_mobile/features/directmessage/data/providers/direct_message_channel_repository_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fixnum/fixnum.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'direct_message_channel_list_view_model.g.dart';

@Riverpod()
class DirectMessageChannelListViewModel
    extends _$DirectMessageChannelListViewModel {
  Timer? debounce;
  bool _creating = false;

  @override
  Future<List<DirectMessageChannelListItem>> build() async {
    ref.watch(currentUserIdProvider); // Bind lifecycle to auth state

    ref.onDispose(() => debounce?.cancel());

    ref.listen(foregroundMessageProvider, (_, next) {
      final RemoteMessage? msg = next.value;
      if (msg == null || msg.notification == null) return;
      scheduleRefresh();
    });

    ref.onAppRestart(scheduleRefresh);

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

      ref.invalidateSelf();
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

      ref.invalidateSelf();
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

      ref.invalidateSelf();
    } on AppException catch (e) {
      ref.read(appMessageNotifierProvider.notifier).show(e.message);
    } catch (e) {
      ref.read(appMessageNotifierProvider.notifier).show("알 수 없는 오류가 발생했습니다.");
    }
  }

  void scheduleRefresh() {
    debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 800), () {
      if (state.hasValue) ref.invalidateSelf();
    });
  }
}
