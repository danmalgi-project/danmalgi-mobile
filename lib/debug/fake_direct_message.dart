import 'package:collection/collection.dart';
import 'package:danmalgi_mobile/core/error/app_exception.dart';
import 'package:danmalgi_mobile/core/generated/dm/v1/dm.pbgrpc.dart';
import 'package:danmalgi_mobile/core/generated/user/v1/user.pb.dart' as pb;
import 'package:danmalgi_mobile/debug/fake_friend.dart';
import 'package:danmalgi_mobile/features/directmessage/data/repositories/direct_message_channel_repository.dart';
import 'package:fixnum/fixnum.dart';
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart';

DirectMessageChannelListItem _dm(
  int id,
  List<pb.User> users, {
  String? name,
  bool group = false,
  String? last,
  Duration ago = Duration.zero,
}) {
  return DirectMessageChannelListItem(
    channel: DirectMessageChannel(
      dmId: Int64(-id),
      users: users,
      channelName: name ?? users.map((u) => u.name).join(', '),
      isGroup: group,
    ),
    lastMessage: last == null
        ? null
        : LastMessage(
            content: last,
            createdAt: Timestamp.fromDateTime(DateTime.now().subtract(ago)),
          ),
  );
}

final _f = fakeFriendUsers;

final _fakeDmStore = <DirectMessageChannelListItem>[
  _dm(1, [_f[0]], last: '내일 몇 시에 볼까요?', ago: const Duration(seconds: 30)),
  _dm(
    2,
    [_f[1], _f[2], _f[3]],
    name: '단말기 프로젝트',
    group: true,
    last: '회의록 공유드려요',
    ago: const Duration(minutes: 10),
  ),
  _dm(
    3,
    [_f[4]],
    last: '아까 말한 디자인 시안 확인했는데 두 번째 안이 더 좋은 것 같아요. 색상만 조금 바꿔 보면 어떨까요?',
    ago: const Duration(hours: 1),
  ),
  _dm(
    4,
    [_f[5], _f[6]],
    name: '주말 등산 모임 (이번 달 일정 정하기)',
    group: true,
    last: '사진 올렸어요',
    ago: const Duration(days: 1),
  ),
  _dm(5, [_f[7]], last: '고마워요!', ago: const Duration(days: 14)),
  _dm(6, [_f[2]]), // 메시지 없는 새 채팅방
];
var _nextId = 100;

class FakeDirectMessageChannelRepository
    implements DirectMessageChannelRepository {
  @override
  DirectMessageServiceClient get client =>
      throw UnsupportedError('fake repository');

  @override
  Future<DirectMessageChannel> createDirectMessageChannel({
    required List<Int64> friendIds,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));

    if (friendIds.length == 1) {
      final existing = _fakeDmStore.firstWhereOrNull(
        (i) =>
            !i.channel.isGroup &&
            i.channel.users.any((u) => u.id == friendIds.first),
      );
      if (existing != null) return existing.channel;
    }
    final users = _f.where((u) => friendIds.contains(u.id)).toList();
    final item = _dm(_nextId++, users, group: users.length > 1);
    _fakeDmStore.add(item);
    return item.channel;
  }

  @override
  Future<List<DirectMessageChannelListItem>>
  getDirectMessageChannelList() async {
    await Future.delayed(const Duration(milliseconds: 600));

    return _fakeDmStore.sortedByCompare(
      (i) => i.hasLastMessage()
          ? i.lastMessage.createdAt.toDateTime()
          : DateTime.fromMillisecondsSinceEpoch(0),
      (a, b) => b.compareTo(a),
    );
  }

  @override
  Future<DirectMessageChannel> getDirectMessageChannel({
    required int id,
  }) async {
    final item = _fakeDmStore.firstWhereOrNull(
      (i) => i.channel.dmId.toInt() == id,
    );
    if (item == null) throw const AppException.notFound();
    return item.channel;
  }

  @override
  Future<void> leaveDirectMessageChannel({required Int64 id}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _fakeDmStore.removeWhere((i) => i.channel.dmId == id);
  }

  @override
  Future<DirectMessageChannel> updateDirectMessageChannel({
    required Int64 id,
    String? channelName,
    List<int>? imageBytes,
    String? extension,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _fakeDmStore.indexWhere((i) => i.channel.dmId == id);
    final item = _fakeDmStore[index];
    final channel = item.channel.deepCopy();
    if (channelName != null) channel.channelName = channelName;
    _fakeDmStore[index] = item.deepCopy()..channel = channel;
    return channel;
  }
}
