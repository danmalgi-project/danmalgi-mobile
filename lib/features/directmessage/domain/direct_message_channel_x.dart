import 'package:danmalgi_mobile/core/generated/dm/v1/dm.pbgrpc.dart';
import 'package:danmalgi_mobile/core/generated/user/v1/user.pb.dart' as pb;

enum DirectMessageType { direct, group }

extension DirectMessageChannelX on DirectMessageChannel {
  DirectMessageType get type =>
      isGroup ? DirectMessageType.group : DirectMessageType.direct;

  List<pb.User> membersExcept(int? myId) =>
      users.where((u) => u.id.toInt() != myId).toList();
}
