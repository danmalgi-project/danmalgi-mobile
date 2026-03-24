import 'dart:async';

import 'package:fixnum/fixnum.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:danmalgi_mobile/features/chat/data/providers/chat_provider.dart';
import 'package:danmalgi_mobile/features/chat/domain/chat_state.dart';
import 'package:danmalgi_mobile/features/chat/domain/message.dart';
import 'package:danmalgi_mobile/features/chat/domain/message_status.dart';

final chatViewModelProvider = AsyncNotifierProvider.autoDispose
    .family<ChatViewModel, ChatState, int>(ChatViewModel.new);

class ChatViewModel extends AsyncNotifier<ChatState> {
  final int channelId;

  ChatViewModel(this.channelId);

  @override
  FutureOr<ChatState> build() async {
    final stream = ref
        .read(chatRepositoryProvider)
        .receiveMessage(channelId: channelId);

    final subscription = stream.listen((newMessage) {
      print(newMessage);
      final currentState = state.value;
      if (currentState == null) return;

      if (newMessage.channelId != '$channelId') return;

      final currentList = currentState.messages;
      List<Message> newList;

      switch (newMessage.status) {
        case MessageStatus.NONE:
          newList = [newMessage, ...currentList];
          break;
        case MessageStatus.MODIFIED:
          newList = currentList.map((m) {
            return m.id == newMessage.id ? newMessage : m;
          }).toList();
          break;
        case MessageStatus.DELETED:
          newList = currentList.where((m) => m.id != newMessage.id).toList();
          break;
        default:
          newList = currentList;
      }

      state = AsyncData(currentState.copyWith(messages: newList));
    });

    ref.onDispose(() {
      subscription.cancel();
      print("ChatViewModel Disposed");
    });

    final List<Message> initialData = await ref
        .read(chatRepositoryProvider)
        .getPreviousMessages(channelId: channelId, messageId: -1, limit: 10);

    return ChatState(messages: initialData);
  }

  Future<void> getPreviousMessages({
    required int channelId,
    int messageId = -1,
    int limit = 10,
  }) async {
    try {
      final List<Message> newMessageList = await ref
          .read(chatRepositoryProvider)
          .getPreviousMessages(
            channelId: channelId,
            messageId: messageId,
            limit: limit,
          );

      final currentState = state.value;
      if (currentState != null) {
        final existingIds = currentState.messages.map((m) => m.id).toSet();

        final uniqueNewMessages = newMessageList
            .where((m) => !existingIds.contains(m.id))
            .toList();

        state = AsyncData(
          currentState.copyWith(
            messages: [...currentState.messages, ...uniqueNewMessages],
          ),
        );
      }
    } catch (e, stack) {
      print(e.toString());
      // state = AsyncError(e, stack);
    }
  }

  Future<void> modifyMessage({
    required Int64 messageId,
    required String content,
  }) async {
    try {
      await ref
          .read(chatRepositoryProvider)
          .modifyMessage(
            channelId: Int64(channelId),
            messageId: messageId,
            content: content,
          );
    } catch (e, stack) {
      print(e.toString());
      // state = AsyncError(e, stack);
    }
  }

  Future<void> deleteMessage({required Int64 messageId}) async {
    try {
      await ref
          .read(chatRepositoryProvider)
          .deleteMessage(channelId: Int64(channelId), messageId: messageId);
    } catch (e, stack) {
      print(e.toString());
      // state = AsyncError(e, stack);
    }
  }

  Future<void> sendMessage({required String content, List<int>? file}) async {
    try {
      await ref
          .read(chatRepositoryProvider)
          .sendMessage(channelId: channelId, content: content);
    } catch (e, stack) {
      print(e.toString());
      // state = AsyncError(e, stack);
    }
  }
}
