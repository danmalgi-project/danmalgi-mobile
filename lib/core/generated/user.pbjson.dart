// This is a generated file - do not edit.
//
// Generated from user.proto.

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

@$core.Deprecated('Use userStatusDescriptor instead')
const UserStatus$json = {
  '1': 'UserStatus',
  '2': [
    {'1': 'USER_PENDING', '2': 0},
    {'1': 'USER_ACTIVCE', '2': 1},
    {'1': 'USER_BLOCKED', '2': 2},
    {'1': 'USER_WITHDRAWAL', '2': 3},
  ],
};

/// Descriptor for `UserStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List userStatusDescriptor = $convert.base64Decode(
    'CgpVc2VyU3RhdHVzEhAKDFVTRVJfUEVORElORxAAEhAKDFVTRVJfQUNUSVZDRRABEhAKDFVTRV'
    'JfQkxPQ0tFRBACEhMKD1VTRVJfV0lUSERSQVdBTBAD');

@$core.Deprecated('Use oauthTypeDescriptor instead')
const OauthType$json = {
  '1': 'OauthType',
  '2': [
    {'1': 'NAVER', '2': 0},
    {'1': 'GOOGLE', '2': 1},
    {'1': 'KAKAO', '2': 2},
  ],
};

/// Descriptor for `OauthType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List oauthTypeDescriptor = $convert.base64Decode(
    'CglPYXV0aFR5cGUSCQoFTkFWRVIQABIKCgZHT09HTEUQARIJCgVLQUtBTxAC');

@$core.Deprecated('Use getUserByTokenResponseDescriptor instead')
const GetUserByTokenResponse$json = {
  '1': 'GetUserByTokenResponse',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.pb.User', '10': 'user'},
  ],
};

/// Descriptor for `GetUserByTokenResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserByTokenResponseDescriptor =
    $convert.base64Decode(
        'ChZHZXRVc2VyQnlUb2tlblJlc3BvbnNlEhwKBHVzZXIYASABKAsyCC5wYi5Vc2VyUgR1c2Vy');

@$core.Deprecated('Use verifyNameAndTagRequestDescriptor instead')
const VerifyNameAndTagRequest$json = {
  '1': 'VerifyNameAndTagRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'tag', '3': 2, '4': 1, '5': 9, '10': 'tag'},
  ],
};

/// Descriptor for `VerifyNameAndTagRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyNameAndTagRequestDescriptor =
    $convert.base64Decode(
        'ChdWZXJpZnlOYW1lQW5kVGFnUmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1lEhAKA3RhZxgCIA'
        'EoCVIDdGFn');

@$core.Deprecated('Use userDescriptor instead')
const User$json = {
  '1': 'User',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'email', '3': 2, '4': 1, '5': 9, '10': 'email'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {'1': 'tag', '3': 4, '4': 1, '5': 9, '10': 'tag'},
    {
      '1': 'oauth_type',
      '3': 5,
      '4': 1,
      '5': 14,
      '6': '.pb.OauthType',
      '10': 'oauthType'
    },
    {
      '1': 'status',
      '3': 6,
      '4': 1,
      '5': 14,
      '6': '.pb.UserStatus',
      '10': 'status'
    },
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode(
    'CgRVc2VyEg4KAmlkGAEgASgDUgJpZBIUCgVlbWFpbBgCIAEoCVIFZW1haWwSEgoEbmFtZRgDIA'
    'EoCVIEbmFtZRIQCgN0YWcYBCABKAlSA3RhZxIsCgpvYXV0aF90eXBlGAUgASgOMg0ucGIuT2F1'
    'dGhUeXBlUglvYXV0aFR5cGUSJgoGc3RhdHVzGAYgASgOMg4ucGIuVXNlclN0YXR1c1IGc3RhdH'
    'Vz');
