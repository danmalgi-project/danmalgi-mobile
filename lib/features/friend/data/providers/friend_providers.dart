import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:danmalgi_mobile/core/providers/network_provider.dart';
import 'package:danmalgi_mobile/features/friend/data/repositories/friend_repository.dart';
import 'package:danmalgi_mobile/features/friend/data/repositories/relationship_repository.dart';

final friendRepositoryProvider = Provider((ref) {
  final client = ref.read(friendServiceClientProvider);
  return FriendRepository(client);
});

final relationshipRepositoryProvider = Provider((ref) {
  final client = ref.read(relationshipServiceClientProvider);
  return RelationshipRepository(client);
});
