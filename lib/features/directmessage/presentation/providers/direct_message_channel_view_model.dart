import 'dart:async';

import 'package:danmalgi_mobile/core/providers/app_user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:danmalgi_mobile/features/directmessage/domain/direct_message_channel_detail_state.dart';
import 'package:danmalgi_mobile/features/directmessage/presentation/providers/direct_message_channel_list_view_model.dart';

final directMessageChannelViewModelProvider = AsyncNotifierProvider.autoDispose
    .family<
      DirectMessageChannelViewModel,
      DirectMessageChannelDetailState,
      int
    >(DirectMessageChannelViewModel.new);

class DirectMessageChannelViewModel
    extends AsyncNotifier<DirectMessageChannelDetailState> {
  final int channelId;

  DirectMessageChannelViewModel(this.channelId);

  @override
  FutureOr<DirectMessageChannelDetailState> build() async {
    ref.watch(currentUserProvider); // Bind lifecycle to auth state

    final initialData = await ref
        .read(directMessageChannelListViewModelProvider.notifier)
        .fetchDirectMessageChannel(id: channelId);

    return DirectMessageChannelDetailState(
      channel: initialData,
      isCalling: false,
    );
  }

  Future<void> call() async {
    final currentState = state.value;
    if (currentState != null) {
      state = AsyncData(currentState.copyWith(isCalling: true));
    }
  }

  Future<void> hangOut() async {
    final currentState = state.value;
    if (currentState != null) {
      state = AsyncData(currentState.copyWith(isCalling: false));
    }
  }
}
