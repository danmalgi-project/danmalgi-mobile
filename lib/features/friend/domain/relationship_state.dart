import 'package:danmalgi_mobile/core/generated/relationship/v1/relationship.pb.dart';

class RelationshipState {
  final List<Relationship> incomingRelationshipList;
  final List<Relationship> outgoingRelationshipList;
  final String? error;

  RelationshipState({
    required this.incomingRelationshipList,
    required this.outgoingRelationshipList,
    this.error,
  });

  RelationshipState copyWith({
    List<Relationship>? incomingRelationshipList,
    List<Relationship>? outgoingRelationshipList,
    String? error,
  }) {
    return RelationshipState(
      incomingRelationshipList:
          incomingRelationshipList ?? this.incomingRelationshipList,
      outgoingRelationshipList:
          outgoingRelationshipList ?? this.outgoingRelationshipList,
      error: error ?? this.error,
    );
  }
}
