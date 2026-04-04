import 'package:danmalgi_mobile/core/generated/chat/v1/chat.pbenum.dart' as pb;
import 'package:danmalgi_mobile/features/chat/domain/message_status.dart';

extension MessageStatusMapper on pb.MessageStatus {
  MessageStatus toDomain() {
    switch (this) {
      case pb.MessageStatus.NONE:
        return MessageStatus.NONE;
      case pb.MessageStatus.MODIFIED:
        return MessageStatus.MODIFIED;
      case pb.MessageStatus.DELETED:
        return MessageStatus.DELETED;
      default:
        return MessageStatus.UNKNOWN;
    }
  }
}
