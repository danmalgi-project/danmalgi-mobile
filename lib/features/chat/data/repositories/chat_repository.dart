import 'dart:async';

import 'package:fixnum/fixnum.dart';

import 'package:danmalgi_mobile/core/generated/chat/v1/chat.pbgrpc.dart' as pb;
import 'package:danmalgi_mobile/features/chat/domain/message.dart';
import 'package:danmalgi_mobile/features/user/data/repositories/user_repository.dart';

class ChatRepository {
  final pb.ChatServiceClient client;
  final UserRepository userRepository;

  ChatRepository(this.client, this.userRepository);

  Future<List<Message>> getPreviousMessages({
    required int channelId,
    int messageId = -1,
    int limit = 10,
  }) async {
    final request = pb.GetPreviousMessagesRequest(
      channelId: Int64(channelId),
      messageId: Int64(messageId),
      limit: limit,
    );

    final response = await client.getPreviousMessages(request);
    return List.unmodifiable(
      response.messages.map((message) => Message.fromProto(message)),
    );
  }

  Future<void> modifyMessage({
    required Int64 channelId,
    required Int64 messageId,
    required String content,
  }) async {
    final request = pb.ModifyMessageRequest(
      channelId: channelId,
      messageId: messageId,
      content: content,
    );

    await client.modifyMessage(request);
  }

  Future<void> deleteMessage({
    required Int64 channelId,
    required Int64 messageId,
  }) async {
    final request = pb.DeleteMessageRequest(
      channelId: channelId,
      messageId: messageId,
    );

    await client.deleteMessage(request);
  }

  Future<void> sendMessage({
    required int channelId,
    required String content,
    List<int>? file,
  }) async {
    final request = pb.SendMessageRequest(
      channelId: Int64(channelId),
      content: content,
      file: file,
    );

    await client.sendMessage(request);
  }

  Stream<Message> receiveMessage({required int channelId}) {
    final request = pb.ReceiveMessageRequest(channelId: Int64(channelId));

    return client
        .receiveMessage(request)
        .map((response) => Message.fromResponse(response));
  }
}
