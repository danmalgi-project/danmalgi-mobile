import 'dart:async';

import 'package:danmalgi_mobile/core/providers/app_user_provider.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:danmalgi_mobile/core/generated/relationship/v1/relationship.pb.dart';
import 'package:danmalgi_mobile/core/generated/user/v1/user.pb.dart';
import 'package:danmalgi_mobile/features/friend/data/providers/friend_providers.dart';
import 'package:danmalgi_mobile/features/friend/domain/relationship_state.dart';
import 'package:danmalgi_mobile/features/friend/presentation/providers/friend_view_model.dart';

final relationshipViewModelProvider =
    AsyncNotifierProvider.autoDispose<RelationshipViewModel, RelationshipState>(
      RelationshipViewModel.new,
    );

class RelationshipViewModel extends AsyncNotifier<RelationshipState> {
  @override
  FutureOr<RelationshipState> build() async {
    ref.watch(currentUserProvider); // Bind lifecycle to auth state

    final List<Relationship> incoming = await ref
        .read(relationshipRepositoryProvider)
        .getIncomingRelationshipList();

    final List<Relationship> outgoing = await ref
        .read(relationshipRepositoryProvider)
        .getOutgoingRelationshipList();

    incoming.addAll([
      Relationship(
        relationshipId: Int64(1021),
        user: User(id: Int64(-1), email: '', name: '[TEST21]', tag: '7797'),
        relationshipStatus: RelationshipStatus.RELATION_PENDING,
      ),
      Relationship(
        relationshipId: Int64(1022),
        user: User(id: Int64(-1), email: '', name: '[TEST22]', tag: '7798'),
        relationshipStatus: RelationshipStatus.RELATION_PENDING,
      ),
    ]);

    outgoing.addAll([
      Relationship(
        relationshipId: Int64(1023),
        user: User(id: Int64(-1), email: '', name: '[TEST23]', tag: '7799'),
        relationshipStatus: RelationshipStatus.RELATION_PENDING,
      ),
    ]);

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
      print(e);
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
      print(e);
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
      print(e);
    }
  }
}
