import 'dart:async';

import 'package:danmalgi_mobile/core/generated/relationship/v1/relationship.pb.dart';
import 'package:danmalgi_mobile/core/providers/app_user_provider.dart';
import 'package:danmalgi_mobile/features/friend/data/providers/friend_providers.dart';
import 'package:danmalgi_mobile/features/friend/domain/relationship_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'relationship_view_model.g.dart';

@riverpod
class RelationshipViewModel extends _$RelationshipViewModel {
  @override
  Future<RelationshipState> build() async {
    ref.watch(currentUserProvider); // Bind lifecycle to auth state

    final List<Relationship> incoming = await ref
        .read(relationshipRepositoryProvider)
        .getIncomingRelationshipList();

    final List<Relationship> outgoing = await ref
        .read(relationshipRepositoryProvider)
        .getOutgoingRelationshipList();

    return RelationshipState(
      incomingRelationshipList: incoming,
      outgoingRelationshipList: outgoing,
    );
  }

  Future<void> addRelationship({
    required String name,
    required String tag,
  }) async {
    try {
      await ref
          .read(relationshipRepositoryProvider)
          .addRelationship(name: name, tag: tag);
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }

  Future<void> updateIncomingRelationshipStatus({
    required Relationship relationship,
    required bool isAccept,
  }) async {
    try {
      final status = (isAccept)
          ? RelationshipStatus.RELATION_ACCEPT
          : RelationshipStatus.RELATION_REJECT;

      final response = await ref
          .read(relationshipRepositoryProvider)
          .updateIncomingRelationshipStatus(
            relationshipId: relationship.relationshipId,
            status: status,
          );

      final currentState = state.value;
      if (currentState != null) {
        state = AsyncData(
          currentState.copyWith(incomingRelationshipList: response),
        );
      }
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }

  Future<void> updateOutgoingRelationshipStatus({
    required Relationship relationship,
    required bool isCancel,
  }) async {
    try {
      if (!isCancel) return;
      final status = RelationshipStatus.RELATION_CANCEL;

      final response = await ref
          .read(relationshipRepositoryProvider)
          .updateOutgoingRelationshipStatus(
            relationshipId: relationship.relationshipId,
            status: status,
          );

      final currentState = state.value;
      if (currentState != null) {
        state = AsyncData(
          currentState.copyWith(outgoingRelationshipList: response),
        );
      }
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }
}
