import 'package:collection/collection.dart';
import 'package:fixnum/fixnum.dart';
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart';

import 'package:danmalgi_mobile/core/generated/dm/v1/dm.pbgrpc.dart';

class DirectMessageChannelRepository {
  final DirectMessageServiceClient client;

  DirectMessageChannelRepository(this.client);

  Future<DirectMessageChannel> createDirectMessageChannel({
    required List<Int64> friendIds,
  }) async {
    print('Create DirectMessageChannel');
    print(friendIds);
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

  Future<List<DirectMessageChannelListItem>> getDirectMessageChannelList({
    int offset = 0,
    int limit = 10,
  }) async {
    print('Fetching All DM Channels');

    // // Infinite Scroll
    // final request = GetDirectMessageChannelListRequest(
    //   offset: offset,
    //   limit: limit,
    //   refreshTime: DateTime.now(),
    // ).toProto();
    final response = await client.getDirectMessageChannelList(Empty());
    return _sortedByLastMessage(response.items);
  }

  List<DirectMessageChannelListItem> _sortedByLastMessage(
    List<DirectMessageChannelListItem> items,
  ) {
    return items.sortedByCompare(
      (i) => i.hasLastMessage()
          ? i.lastMessage.createdAt.toDateTime()
          : DateTime.fromMillisecondsSinceEpoch(0),
      (a, b) => b.compareTo(a), // 최신이 위
    );
  }

  Future<DirectMessageChannel> uploadChannelImage({
    required int id,
    required List<int> imageBytes,
    required String extension,
  }) async {
    final request = UploadChannelImageRequest(
      dmId: Int64(id),
      image: imageBytes,
      extension_3: extension,
    );

    final response = await client.uploadChannelImage(request);

    return response.directMessageChannel;
  }
}
