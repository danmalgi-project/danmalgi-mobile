import 'package:danmalgi_mobile/core/generated/dm/v1/dm.pbgrpc.dart';
import 'package:fixnum/fixnum.dart';
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart';

class DirectMessageChannelRepository {
  final DirectMessageServiceClient client;

  DirectMessageChannelRepository(this.client);

  Future<DirectMessageChannel> createDirectMessageChannel({
    required List<Int64> friendIds,
  }) async {
    final request = CreateDirectMessageChannelRequest(friendIds: friendIds);

    final response = await client.createDirectMessageChannel(request);
    return response.directMessageChannel;
  }

  Future<List<DirectMessageChannelListItem>>
  getDirectMessageChannelList() async {
    final response = await client.getDirectMessageChannelList(Empty());
    return response.items;
  }

  Future<DirectMessageChannel> getDirectMessageChannel({
    required int id,
  }) async {
    final response = await client.getDirectMessageChannel(
      GetDirectMessageChannelRequest(dmId: Int64(id)),
    );
    return response.directMessageChannel;
  }

  Future<DirectMessageChannel> updateDirectMessageChannel({
    required Int64 id,
    String? channelName,
    List<int>? imageBytes,
    String? extension,
  }) async {
    final request = UpdateDirectMessageChannelRequest(
      dmId: id,
      channelName: channelName,
      image: imageBytes,
      extension_4: extension,
    );

    final response = await client.updateDirectMessageChannel(request);

    return response.directMessageChannel;
  }

  Future<void> leaveDirectMessageChannel({required Int64 id}) async {
    await client.leaveDirectMessageChannel(
      LeaveDirectMessageChannelRequest(dmId: id),
    );
  }
}
