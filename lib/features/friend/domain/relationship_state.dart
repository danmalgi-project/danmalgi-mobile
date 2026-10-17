import 'package:danmalgi_mobile/core/generated/relationship/v1/relationship.pb.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'relationship_state.freezed.dart';

@freezed
sealed class RelationshipState with _$RelationshipState {
  const factory RelationshipState({
    required List<Relationship> incomingRelationshipList,
    required List<Relationship> outgoingRelationshipList,
  }) = _RelationshipState;
}
