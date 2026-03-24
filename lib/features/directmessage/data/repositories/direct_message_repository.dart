import 'package:fixnum/fixnum.dart';
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart';

import 'package:danmalgi_mobile/core/generated/direct_message.pbgrpc.dart';

class DirectMessageChannelRepository {
  final DirectMessageServiceClient client;

  DirectMessageChannelRepository(this.client);

  Future<DirectMessageChannel> createDirectMessageChannel({
    required List<Int64> friendIds,
  }) async {
    print('Create DirectMessageChannel');
    final request = CreateDirectMessageChannelRequest(friendIds: friendIds);

    final response = await client.createDirectMessageChannel(request);
    return response.directMessageChannel;
  }

  Future<DirectMessageChannel> getDirectMessageChannel({
    required int id,
  }) async {
    throw UnimplementedError();
    // final response =
    //     await _directMessageDataSource.getDirectMessageChannel(id: id);
    // return response.directMessageChannel;
  }

  Future<List<DirectMessageChannel>> getDirectMessageChannelList({
    int offset = 0,
    limit = 10,
  }) async {
    print('Fetching All DM Channels');

    // // Infinite Scroll
    // final request = GetDirectMessageChannelListRequest(
    //   offset: offset,
    //   limit: limit,
    //   refreshTime: DateTime.now(),
    // ).toProto();
    final response = await client.getDirectMessageChannelList(Empty());
    return response.directMessageChannels;
  }
}
