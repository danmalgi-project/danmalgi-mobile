import 'dart:async';

import 'package:danmalgi_mobile/core/extensions/string_extensions.dart';
import 'package:danmalgi_mobile/core/generated/friend/v1/friend.pb.dart';
import 'package:danmalgi_mobile/core/generated/relationship/v1/relationship.pbgrpc.dart';
import 'package:danmalgi_mobile/core/generated/user/v1/user.pb.dart' as pb;
import 'package:danmalgi_mobile/core/providers/app_user_provider.dart';
import 'package:danmalgi_mobile/features/friend/domain/relationship_state.dart';
import 'package:danmalgi_mobile/features/friend/presentation/providers/add_friend_view_model.dart';
import 'package:danmalgi_mobile/features/friend/presentation/providers/friend_view_model.dart';
import 'package:danmalgi_mobile/features/friend/presentation/providers/relationship_view_model.dart';
import 'package:danmalgi_mobile/features/user/domain/user_profile.dart';
import 'package:fixnum/fixnum.dart';
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

pb.User _user(int id, String name) => pb.User(
  id: Int64(-id), // 실제 데이터와 겹치지 않게 음수 사용
  name: name,
  tag: '1111',
  profileImageUrl: '',
);

final _incomingUsers = [
  _user(1, '문서연'),
  _user(2, '윤지호'),
  _user(3, '한예린'),
  _user(4, '최유나'),
];
const _incomingAges = [
  Duration(minutes: 10), // 10분 전
  Duration(hours: 1), // 1시간 전
  Duration(days: 1), // 어제
  Duration(days: 10), // 1주일 전
];

final fakeFriendUsers = [
  for (final (i, name) in [
    '강민서',
    '김하늘',
    '박지민',
    '서지우',
    '이도윤',
    '정하린',
    '조은우',
    '한서준',
  ].indexed)
    _user(100 + i, name),
];
final _outgoingUsers = [_user(200, '오세린')];
final _strangerUsers = [_user(300, '피그마'), _user(301, '단말기')];

List<pb.User> get _directory => [
  ..._incomingUsers,
  ...fakeFriendUsers,
  ..._outgoingUsers,
  ..._strangerUsers,
];

final _fakeFriendStore = <Friend>[
  for (final u in fakeFriendUsers)
    Friend(
      id: Int64(u.id.toInt() - 1000),
      user: u,
      status: FriendStatus.ACCEPT,
    ),
];
final _fakeIncomingStore = <Relationship>[
  for (final (i, u) in _incomingUsers.indexed)
    Relationship(
      relationshipId: Int64(-(i + 1)),
      user: u,
      relationshipStatus: RelationshipStatus.RELATION_PENDING,
      requestedAt: Timestamp.fromDateTime(
        DateTime.now().subtract(_incomingAges[i]),
      ),
    ),
];
final _fakeOutgoingStore = <Relationship>[
  for (final (i, u) in _outgoingUsers.indexed)
    Relationship(
      relationshipId: Int64(-(i + 500)),
      user: u,
      relationshipStatus: RelationshipStatus.RELATION_PENDING,
    ),
];

class FakeFriendViewModel extends FriendViewModel {
  @override
  Future<List<Friend>> build() async {
    await Future.delayed(const Duration(seconds: 1));
    return List.of(_fakeFriendStore);
  }
}

class FakeRelationshipViewModel extends RelationshipViewModel {
  @override
  Future<RelationshipState> build() async {
    await Future.delayed(const Duration(seconds: 1));
    return RelationshipState(
      incomingRelationshipList: List.of(_fakeIncomingStore),
      outgoingRelationshipList: List.of(_fakeOutgoingStore),
    );
  }

  @override
  Future<void> addRelationship({
    required String name,
    required String tag,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final user = _directory.firstWhere((u) => u.name == name && u.tag == tag);
    _fakeOutgoingStore.add(
      Relationship(
        relationshipId: Int64(-(1000 + _fakeOutgoingStore.length)),
        user: user,
        relationshipStatus: RelationshipStatus.RELATION_PENDING,
      ),
    );
  }

  @override
  Future<void> updateIncomingRelationshipStatus({
    required Relationship relationship,
    required bool isAccept,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500)); // 버튼 비활성 상태 확인

    _fakeIncomingStore.removeWhere(
      (r) => r.relationshipId == relationship.relationshipId,
    );
    if (isAccept) {
      _fakeFriendStore.insert(
        0,
        Friend(
          id: Int64(relationship.relationshipId.toInt() - 1000),
          user: relationship.user,
          status: FriendStatus.ACCEPT,
        ),
      );
    }

    state = AsyncData(
      state.requireValue.copyWith(
        incomingRelationshipList: List.of(_fakeIncomingStore),
      ),
    );
  }
}

class FakeAddFriendViewModel extends AddFriendViewModel {
  @override
  Future<void> search(String query) async {
    state = const AsyncLoading();
    await Future.delayed(const Duration(milliseconds: 600)); // 로딩 확인

    final me = ref.read(currentUserProvider);
    final everyone = [
      for (final u in _directory) _toProfile(u),
      if (me != null)
        UserProfile(
          id: me.id,
          name: me.name,
          tag: me.tag,
          imageUrl: me.imageUrl,
        ),
    ];

    final q = query.trim();
    state = AsyncData(
      q.isEmpty
          ? everyone
          : everyone.where((u) => '${u.name}#${u.tag}' == q).toList(),
    );
  }
}

UserProfile _toProfile(pb.User u) => UserProfile(
  id: u.id.toInt(),
  name: u.name,
  tag: u.tag,
  imageUrl: u.profileImageUrl.nullIfEmpty,
);
