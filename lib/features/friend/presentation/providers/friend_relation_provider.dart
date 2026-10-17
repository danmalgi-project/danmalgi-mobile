import 'package:collection/collection.dart';
import 'package:danmalgi_mobile/core/providers/app_user_provider.dart';
import 'package:danmalgi_mobile/features/friend/domain/friend_relation.dart';
import 'package:danmalgi_mobile/features/friend/presentation/providers/friend_view_model.dart';
import 'package:danmalgi_mobile/features/friend/presentation/providers/relationship_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'friend_relation_provider.g.dart';

@riverpod
FriendRelation friendRelation(Ref ref, int userId) {
  if (ref.watch(currentUserProvider)?.id == userId) {
    return const FriendRelation.me();
  }

  final friends = ref.watch(friendViewModelProvider).value ?? const [];
  if (friends.any((f) => f.user.id.toInt() == userId)) {
    return const FriendRelation.friend();
  }

  final rel = ref.watch(relationshipViewModelProvider).value;

  final outgoing = rel?.outgoingRelationshipList.firstWhereOrNull(
    (r) => r.user.id.toInt() == userId,
  );
  if (outgoing != null) return FriendRelation.outgoing(outgoing);

  final incoming = rel?.incomingRelationshipList.firstWhereOrNull(
    (r) => r.user.id.toInt() == userId,
  );
  if (incoming != null) return FriendRelation.incoming(incoming);

  return const FriendRelation.none();
}
