import 'package:danmalgi_mobile/core/providers/network_provider.dart';
import 'package:danmalgi_mobile/features/friend/data/repositories/friend_repository.dart';
import 'package:danmalgi_mobile/features/friend/data/repositories/relationship_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'friend_providers.g.dart';

@Riverpod(keepAlive: true)
FriendRepository friendRepository(Ref ref) {
  final client = ref.read(friendServiceClientProvider);
  return FriendRepository(client);
}

@Riverpod(keepAlive: true)
RelationshipRepository relationshipRepository(Ref ref) {
  final client = ref.read(relationshipServiceClientProvider);
  return RelationshipRepository(client);
}
