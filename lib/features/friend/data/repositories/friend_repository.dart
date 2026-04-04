import 'package:fixnum/fixnum.dart';
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart';

import 'package:danmalgi_mobile/core/generated/friend/v1/friend.pbgrpc.dart';

class FriendRepository {
  final FriendServiceClient client;

  FriendRepository(this.client);

  Future<List<Friend>> getFriendList() async {
    final response = await client.getFriendList(Empty());
    return response.friends;
  }

  Future<List<Friend>> updateFriendStatus({
    required Int64 friendshipId,
    required FriendStatus friendStatus,
  }) async {
    final request = UpdateFriendStatusRequest(
      friendshipId: friendshipId,
      friendStatus: friendStatus,
    );

    final response = await client.updateFriendStatus(request);
    return response.friends;
  }
}
