// lib/features/friend/domain/friend_relation.dart
import 'package:danmalgi_mobile/core/generated/relationship/v1/relationship.pb.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'friend_relation.freezed.dart';

@freezed
sealed class FriendRelation with _$FriendRelation {
  const factory FriendRelation.none() = FriendRelationNone;
  const factory FriendRelation.me() = FriendRelationMe;
  const factory FriendRelation.friend() = FriendRelationFriend;
  const factory FriendRelation.outgoing(Relationship relationship) =
      FriendRelationOutgoing;
  const factory FriendRelation.incoming(Relationship relationship) =
      FriendRelationIncoming;
}
