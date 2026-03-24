// This is a generated file - do not edit.
//
// Generated from internalpb/internal_user.proto.

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

@$core.Deprecated('Use cacheUsersRequestDescriptor instead')
const CacheUsersRequest$json = {
  '1': 'CacheUsersRequest',
  '2': [
    {'1': 'user_ids', '3': 1, '4': 3, '5': 3, '10': 'userIds'},
  ],
};

/// Descriptor for `CacheUsersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cacheUsersRequestDescriptor = $convert.base64Decode(
    'ChFDYWNoZVVzZXJzUmVxdWVzdBIZCgh1c2VyX2lkcxgBIAMoA1IHdXNlcklkcw==');

@$core.Deprecated('Use cacheUsersResponseDescriptor instead')
const CacheUsersResponse$json = {
  '1': 'CacheUsersResponse',
  '2': [
    {
      '1': 'users',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.internalpb.User',
      '10': 'users'
    },
  ],
};

/// Descriptor for `CacheUsersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cacheUsersResponseDescriptor = $convert.base64Decode(
    'ChJDYWNoZVVzZXJzUmVzcG9uc2USJgoFdXNlcnMYASADKAsyEC5pbnRlcm5hbHBiLlVzZXJSBX'
    'VzZXJz');

@$core.Deprecated('Use userDescriptor instead')
const User$json = {
  '1': 'User',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'email', '3': 2, '4': 1, '5': 9, '10': 'email'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {'1': 'tag', '3': 4, '4': 1, '5': 9, '10': 'tag'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode(
    'CgRVc2VyEg4KAmlkGAEgASgDUgJpZBIUCgVlbWFpbBgCIAEoCVIFZW1haWwSEgoEbmFtZRgDIA'
    'EoCVIEbmFtZRIQCgN0YWcYBCABKAlSA3RhZw==');
