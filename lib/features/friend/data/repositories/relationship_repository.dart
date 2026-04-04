import 'package:fixnum/fixnum.dart';
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart';

import 'package:danmalgi_mobile/core/generated/relationship/v1/relationship.pbgrpc.dart';

class RelationshipRepository {
  final RelationshipServiceClient client;

  RelationshipRepository(this.client);

  Future<List<Relationship>> addRelationship({
    required String name,
    required String tag,
  }) async {
    final request = AddRelationshipRequest(name: name, tag: tag);

    final response = await client.addRelationship(request);
    return response.relationships;
  }

  Future<List<Relationship>> getIncomingRelationshipList() async {
    final response = await client.getIncomingRelationshipList(Empty());
    return response.relationships;
  }

  Future<List<Relationship>> getOutgoingRelationshipList() async {
    final response = await client.getOutgoingRelationshipList(Empty());
    return response.relationships;
  }

  Future<List<Relationship>> updateIncomingRelationshipStatus({
    required Int64 relationshipId,
    required RelationshipStatus status,
  }) async {
    final request = UpdateIncomingRelationshipStatusRequest(
      relationshipId: relationshipId,
      relationshipStatus: status,
    );
    final response = await client.updateIncomingRelationshipStatus(request);
    return response.relationships;
  }

  Future<List<Relationship>> updateOutgoingRelationshipStatus({
    required Int64 relationshipId,
    required RelationshipStatus status,
  }) async {
    final request = UpdateOutgoingRelationshipStatusRequest(
      relationshipId: relationshipId,
      relationshipStatus: status,
    );

    final response = await client.updateOutgoingRelationshipStatus(request);
    return response.relationships;
  }
}
