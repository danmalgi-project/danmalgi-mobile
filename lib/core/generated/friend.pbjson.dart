// This is a generated file - do not edit.
//
// Generated from friend.proto.

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

@$core.Deprecated('Use friendStatusDescriptor instead')
const FriendStatus$json = {
  '1': 'FriendStatus',
  '2': [
    {'1': 'friend_accept', '2': 0},
    {'1': 'friend_block', '2': 1},
    {'1': 'friend_delete', '2': 2},
  ],
};

/// Descriptor for `FriendStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List friendStatusDescriptor = $convert.base64Decode(
    'CgxGcmllbmRTdGF0dXMSEQoNZnJpZW5kX2FjY2VwdBAAEhAKDGZyaWVuZF9ibG9jaxABEhEKDW'
    'ZyaWVuZF9kZWxldGUQAg==');

@$core.Deprecated('Use getFriendListResponseDescriptor instead')
const GetFriendListResponse$json = {
  '1': 'GetFriendListResponse',
  '2': [
    {
      '1': 'friends',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.pb.Friend',
      '10': 'friends'
    },
  ],
};

/// Descriptor for `GetFriendListResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFriendListResponseDescriptor = $convert.base64Decode(
    'ChVHZXRGcmllbmRMaXN0UmVzcG9uc2USJAoHZnJpZW5kcxgBIAMoCzIKLnBiLkZyaWVuZFIHZn'
    'JpZW5kcw==');

@$core.Deprecated('Use updateFriendStatusRequestDescriptor instead')
const UpdateFriendStatusRequest$json = {
  '1': 'UpdateFriendStatusRequest',
  '2': [
    {'1': 'friendship_id', '3': 1, '4': 1, '5': 3, '10': 'friendshipId'},
    {
      '1': 'friend_status',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.pb.FriendStatus',
      '10': 'friendStatus'
    },
  ],
};

/// Descriptor for `UpdateFriendStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateFriendStatusRequestDescriptor = $convert.base64Decode(
    'ChlVcGRhdGVGcmllbmRTdGF0dXNSZXF1ZXN0EiMKDWZyaWVuZHNoaXBfaWQYASABKANSDGZyaW'
    'VuZHNoaXBJZBI1Cg1mcmllbmRfc3RhdHVzGAIgASgOMhAucGIuRnJpZW5kU3RhdHVzUgxmcmll'
    'bmRTdGF0dXM=');

@$core.Deprecated('Use updateFriendStatusResponseDescriptor instead')
const UpdateFriendStatusResponse$json = {
  '1': 'UpdateFriendStatusResponse',
  '2': [
    {
      '1': 'friends',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.pb.Friend',
      '10': 'friends'
    },
  ],
};

/// Descriptor for `UpdateFriendStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateFriendStatusResponseDescriptor =
    $convert.base64Decode(
        'ChpVcGRhdGVGcmllbmRTdGF0dXNSZXNwb25zZRIkCgdmcmllbmRzGAEgAygLMgoucGIuRnJpZW'
        '5kUgdmcmllbmRz');

@$core.Deprecated('Use friendDescriptor instead')
const Friend$json = {
  '1': 'Friend',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'user', '3': 2, '4': 1, '5': 11, '6': '.pb.User', '10': 'user'},
    {
      '1': 'status',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.pb.FriendStatus',
      '10': 'status'
    },
  ],
};

/// Descriptor for `Friend`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List friendDescriptor = $convert.base64Decode(
    'CgZGcmllbmQSDgoCaWQYASABKANSAmlkEhwKBHVzZXIYAiABKAsyCC5wYi5Vc2VyUgR1c2VyEi'
    'gKBnN0YXR1cxgDIAEoDjIQLnBiLkZyaWVuZFN0YXR1c1IGc3RhdHVz');
