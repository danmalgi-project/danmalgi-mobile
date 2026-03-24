import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:danmalgi_mobile/core/generated/chat.pb.dart' as pb;
import 'package:danmalgi_mobile/features/chat/data/extensions/message_status_mapper.dart';
import 'package:danmalgi_mobile/features/chat/domain/message_status.dart';
import 'package:danmalgi_mobile/features/user/domain/user.dart';

part 'message.freezed.dart';

@freezed
sealed class Message with _$Message {
  const factory Message({
    required String id,
    required String content,
    required User user,
    required String channelId,
    required bool isAuthor,
    required MessageStatus status,
    required DateTime createdAt,
  }) = _Message;

  factory Message.fromProto(pb.Message proto) {
    return Message(
      id: '${proto.id.toInt()}',
      content: proto.content,
      user: User.fromProto(proto.user),
      channelId: '${proto.channelId.toInt()}',
      isAuthor: proto.isAuthor,
      status: MessageStatus.NONE,
      createdAt: proto.createdAt.toDateTime(),
    );
  }

  factory Message.fromResponse(pb.ReceiveMessageResponse proto) {
    final messageProto = proto.message;
    final statusProto = proto.status;

    return Message(
      id: '${messageProto.id.toInt()}',
      content: messageProto.content,
      user: User.fromProto(messageProto.user),
      channelId: '${messageProto.channelId.toInt()}',
      isAuthor: messageProto.isAuthor,
      status: statusProto.toDomain(),
      createdAt: messageProto.createdAt.toDateTime(),
    );
  }
}
