import 'dart:async';

import 'package:danmalgi_mobile/core/generated/friend/v1/friend.pb.dart';
import 'package:danmalgi_mobile/core/generated/relationship/v1/relationship.pbgrpc.dart';
import 'package:danmalgi_mobile/core/generated/user/v1/user.pb.dart' as pb;
import 'package:danmalgi_mobile/features/friend/domain/friend_state.dart';
import 'package:danmalgi_mobile/features/friend/domain/relationship_state.dart';
import 'package:danmalgi_mobile/features/friend/presentation/providers/friend_view_model.dart';
import 'package:danmalgi_mobile/features/friend/presentation/providers/relationship_view_model.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

pb.User _user(int id, String name) =>
    pb.User(id: Int64(-id), name: name, tag: '1111', profileImageUrl: '');

final _fakeRequests = [
  for (final (i, name) in ['문서연', '윤지호', '한예린', '최유나'].indexed)
    Relationship(
      relationshipId: Int64(-(i + 1)),
      user: _user(i + 1, name),
      relationshipStatus: RelationshipStatus.RELATION_PENDING,
    ),
];

final _fakeFriends = [
  for (final (i, name) in [
    '강민서',
    '김하늘',
    '박지민',
    '서지우',
    '이도윤',
    '정수빈',
    '최유진',
    '한서준',
  ].indexed)
    Friend(
      id: Int64(-(i + 100)),
      user: _user(i + 100, name),
      status: FriendStatus.ACCEPT,
    ),
];

class FakeFriendViewModel extends FriendViewModel {
  @override
  Future<FriendState> build() async {
    await Future.delayed(const Duration(seconds: 1));
    return FriendState(friendList: _fakeFriends);
  }
}

class FakeRelationshipViewModel extends RelationshipViewModel {
  @override
  Future<RelationshipState> build() async {
    await Future.delayed(const Duration(seconds: 1));
    return RelationshipState(
      incomingRelationshipList: _fakeRequests,
      outgoingRelationshipList: const [],
    );
  }

  @override
  Future<void> updateIncomingRelationshipStatus({
    required Relationship relationship,
    required bool isAccept,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500)); // 버튼 비활성 상태 확인
    final current = state.requireValue;
    state = AsyncData(
      current.copyWith(
        incomingRelationshipList: current.incomingRelationshipList
            .where((r) => r.relationshipId != relationship.relationshipId)
            .toList(),
      ),
    );
  }
}
