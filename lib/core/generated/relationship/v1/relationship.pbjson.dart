// This is a generated file - do not edit.
//
// Generated from relationship/v1/relationship.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use relationshipStatusDescriptor instead')
const RelationshipStatus$json = {
  '1': 'RelationshipStatus',
  '2': [
    {'1': 'RELATION_ACCEPT', '2': 0},
    {'1': 'RELATION_REJECT', '2': 1},
    {'1': 'RELATION_PENDING', '2': 2},
    {'1': 'RELATION_CANCEL', '2': 3},
  ],
};

/// Descriptor for `RelationshipStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List relationshipStatusDescriptor = $convert.base64Decode(
    'ChJSZWxhdGlvbnNoaXBTdGF0dXMSEwoPUkVMQVRJT05fQUNDRVBUEAASEwoPUkVMQVRJT05fUk'
    'VKRUNUEAESFAoQUkVMQVRJT05fUEVORElORxACEhMKD1JFTEFUSU9OX0NBTkNFTBAD');

@$core.Deprecated('Use getOutgoingRelationshipListResponseDescriptor instead')
const GetOutgoingRelationshipListResponse$json = {
  '1': 'GetOutgoingRelationshipListResponse',
  '2': [
    {
      '1': 'relationships',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.relationship.v1.Relationship',
      '10': 'relationships'
    },
  ],
};

/// Descriptor for `GetOutgoingRelationshipListResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOutgoingRelationshipListResponseDescriptor =
    $convert.base64Decode(
        'CiNHZXRPdXRnb2luZ1JlbGF0aW9uc2hpcExpc3RSZXNwb25zZRJDCg1yZWxhdGlvbnNoaXBzGA'
        'EgAygLMh0ucmVsYXRpb25zaGlwLnYxLlJlbGF0aW9uc2hpcFINcmVsYXRpb25zaGlwcw==');

@$core.Deprecated('Use getIncomingRelationshipListResponseDescriptor instead')
const GetIncomingRelationshipListResponse$json = {
  '1': 'GetIncomingRelationshipListResponse',
  '2': [
    {
      '1': 'relationships',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.relationship.v1.Relationship',
      '10': 'relationships'
    },
  ],
};

/// Descriptor for `GetIncomingRelationshipListResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getIncomingRelationshipListResponseDescriptor =
    $convert.base64Decode(
        'CiNHZXRJbmNvbWluZ1JlbGF0aW9uc2hpcExpc3RSZXNwb25zZRJDCg1yZWxhdGlvbnNoaXBzGA'
        'EgAygLMh0ucmVsYXRpb25zaGlwLnYxLlJlbGF0aW9uc2hpcFINcmVsYXRpb25zaGlwcw==');

@$core.Deprecated('Use addRelationshipRequestDescriptor instead')
const AddRelationshipRequest$json = {
  '1': 'AddRelationshipRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'tag', '3': 2, '4': 1, '5': 9, '10': 'tag'},
  ],
};

/// Descriptor for `AddRelationshipRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addRelationshipRequestDescriptor =
    $convert.base64Decode(
        'ChZBZGRSZWxhdGlvbnNoaXBSZXF1ZXN0EhIKBG5hbWUYASABKAlSBG5hbWUSEAoDdGFnGAIgAS'
        'gJUgN0YWc=');

@$core.Deprecated('Use addRelationshipResponseDescriptor instead')
const AddRelationshipResponse$json = {
  '1': 'AddRelationshipResponse',
  '2': [
    {
      '1': 'relationships',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.relationship.v1.Relationship',
      '10': 'relationships'
    },
  ],
};

/// Descriptor for `AddRelationshipResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addRelationshipResponseDescriptor =
    $convert.base64Decode(
        'ChdBZGRSZWxhdGlvbnNoaXBSZXNwb25zZRJDCg1yZWxhdGlvbnNoaXBzGAEgAygLMh0ucmVsYX'
        'Rpb25zaGlwLnYxLlJlbGF0aW9uc2hpcFINcmVsYXRpb25zaGlwcw==');

@$core
    .Deprecated('Use updateIncomingRelationshipStatusRequestDescriptor instead')
const UpdateIncomingRelationshipStatusRequest$json = {
  '1': 'UpdateIncomingRelationshipStatusRequest',
  '2': [
    {'1': 'relationship_id', '3': 1, '4': 1, '5': 3, '10': 'relationshipId'},
    {
      '1': 'relationship_status',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.relationship.v1.RelationshipStatus',
      '10': 'relationshipStatus'
    },
  ],
};

/// Descriptor for `UpdateIncomingRelationshipStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateIncomingRelationshipStatusRequestDescriptor =
    $convert.base64Decode(
        'CidVcGRhdGVJbmNvbWluZ1JlbGF0aW9uc2hpcFN0YXR1c1JlcXVlc3QSJwoPcmVsYXRpb25zaG'
        'lwX2lkGAEgASgDUg5yZWxhdGlvbnNoaXBJZBJUChNyZWxhdGlvbnNoaXBfc3RhdHVzGAIgASgO'
        'MiMucmVsYXRpb25zaGlwLnYxLlJlbGF0aW9uc2hpcFN0YXR1c1IScmVsYXRpb25zaGlwU3RhdH'
        'Vz');

@$core.Deprecated(
    'Use updateIncomingRelationshipStatusResponseDescriptor instead')
const UpdateIncomingRelationshipStatusResponse$json = {
  '1': 'UpdateIncomingRelationshipStatusResponse',
  '2': [
    {
      '1': 'relationships',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.relationship.v1.Relationship',
      '10': 'relationships'
    },
  ],
};

/// Descriptor for `UpdateIncomingRelationshipStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateIncomingRelationshipStatusResponseDescriptor =
    $convert.base64Decode(
        'CihVcGRhdGVJbmNvbWluZ1JlbGF0aW9uc2hpcFN0YXR1c1Jlc3BvbnNlEkMKDXJlbGF0aW9uc2'
        'hpcHMYASADKAsyHS5yZWxhdGlvbnNoaXAudjEuUmVsYXRpb25zaGlwUg1yZWxhdGlvbnNoaXBz');

@$core
    .Deprecated('Use updateOutgoingRelationshipStatusRequestDescriptor instead')
const UpdateOutgoingRelationshipStatusRequest$json = {
  '1': 'UpdateOutgoingRelationshipStatusRequest',
  '2': [
    {'1': 'relationship_id', '3': 1, '4': 1, '5': 3, '10': 'relationshipId'},
    {
      '1': 'relationship_status',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.relationship.v1.RelationshipStatus',
      '10': 'relationshipStatus'
    },
  ],
};

/// Descriptor for `UpdateOutgoingRelationshipStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateOutgoingRelationshipStatusRequestDescriptor =
    $convert.base64Decode(
        'CidVcGRhdGVPdXRnb2luZ1JlbGF0aW9uc2hpcFN0YXR1c1JlcXVlc3QSJwoPcmVsYXRpb25zaG'
        'lwX2lkGAEgASgDUg5yZWxhdGlvbnNoaXBJZBJUChNyZWxhdGlvbnNoaXBfc3RhdHVzGAIgASgO'
        'MiMucmVsYXRpb25zaGlwLnYxLlJlbGF0aW9uc2hpcFN0YXR1c1IScmVsYXRpb25zaGlwU3RhdH'
        'Vz');

@$core.Deprecated(
    'Use updateOutgoingRelationshipStatusResponseDescriptor instead')
const UpdateOutgoingRelationshipStatusResponse$json = {
  '1': 'UpdateOutgoingRelationshipStatusResponse',
  '2': [
    {
      '1': 'relationships',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.relationship.v1.Relationship',
      '10': 'relationships'
    },
  ],
};

/// Descriptor for `UpdateOutgoingRelationshipStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateOutgoingRelationshipStatusResponseDescriptor =
    $convert.base64Decode(
        'CihVcGRhdGVPdXRnb2luZ1JlbGF0aW9uc2hpcFN0YXR1c1Jlc3BvbnNlEkMKDXJlbGF0aW9uc2'
        'hpcHMYASADKAsyHS5yZWxhdGlvbnNoaXAudjEuUmVsYXRpb25zaGlwUg1yZWxhdGlvbnNoaXBz');

@$core.Deprecated('Use relationshipDescriptor instead')
const Relationship$json = {
  '1': 'Relationship',
  '2': [
    {'1': 'relationship_id', '3': 1, '4': 1, '5': 3, '10': 'relationshipId'},
    {'1': 'user', '3': 2, '4': 1, '5': 11, '6': '.user.v1.User', '10': 'user'},
    {
      '1': 'relationship_status',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.relationship.v1.RelationshipStatus',
      '10': 'relationshipStatus'
    },
  ],
};

/// Descriptor for `Relationship`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List relationshipDescriptor = $convert.base64Decode(
    'CgxSZWxhdGlvbnNoaXASJwoPcmVsYXRpb25zaGlwX2lkGAEgASgDUg5yZWxhdGlvbnNoaXBJZB'
    'IhCgR1c2VyGAIgASgLMg0udXNlci52MS5Vc2VyUgR1c2VyElQKE3JlbGF0aW9uc2hpcF9zdGF0'
    'dXMYAyABKA4yIy5yZWxhdGlvbnNoaXAudjEuUmVsYXRpb25zaGlwU3RhdHVzUhJyZWxhdGlvbn'
    'NoaXBTdGF0dXM=');
