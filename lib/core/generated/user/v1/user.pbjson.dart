// This is a generated file - do not edit.
//
// Generated from user/v1/user.proto.

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
    {'1': 'USER_ACTIVE', '2': 1},
    {'1': 'USER_BLOCKED', '2': 2},
    {'1': 'USER_WITHDRAWAL', '2': 3},
  ],
};

/// Descriptor for `UserStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List userStatusDescriptor = $convert.base64Decode(
    'CgpVc2VyU3RhdHVzEhAKDFVTRVJfUEVORElORxAAEg8KC1VTRVJfQUNUSVZFEAESEAoMVVNFUl'
    '9CTE9DS0VEEAISEwoPVVNFUl9XSVRIRFJBV0FMEAM=');

@$core.Deprecated('Use oauthTypeDescriptor instead')
const OauthType$json = {
  '1': 'OauthType',
  '2': [
    {'1': 'GOOGLE', '2': 0},
    {'1': 'APPLE', '2': 1},
  ],
};

/// Descriptor for `OauthType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List oauthTypeDescriptor =
    $convert.base64Decode('CglPYXV0aFR5cGUSCgoGR09PR0xFEAASCQoFQVBQTEUQAQ==');

@$core.Deprecated('Use getUserByTokenResponseDescriptor instead')
const GetUserByTokenResponse$json = {
  '1': 'GetUserByTokenResponse',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.user.v1.User', '10': 'user'},
  ],
};

/// Descriptor for `GetUserByTokenResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserByTokenResponseDescriptor =
    $convert.base64Decode(
        'ChZHZXRVc2VyQnlUb2tlblJlc3BvbnNlEiEKBHVzZXIYASABKAsyDS51c2VyLnYxLlVzZXJSBH'
        'VzZXI=');

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

@$core.Deprecated('Use uploadProfileRequestDescriptor instead')
const UploadProfileRequest$json = {
  '1': 'UploadProfileRequest',
  '2': [
    {'1': 'image', '3': 1, '4': 1, '5': 12, '10': 'image'},
    {'1': 'extension', '3': 2, '4': 1, '5': 9, '10': 'extension'},
  ],
};

/// Descriptor for `UploadProfileRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadProfileRequestDescriptor = $convert.base64Decode(
    'ChRVcGxvYWRQcm9maWxlUmVxdWVzdBIUCgVpbWFnZRgBIAEoDFIFaW1hZ2USHAoJZXh0ZW5zaW'
    '9uGAIgASgJUglleHRlbnNpb24=');

@$core.Deprecated('Use uploadProfileResponseDescriptor instead')
const UploadProfileResponse$json = {
  '1': 'UploadProfileResponse',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.user.v1.User', '10': 'user'},
  ],
};

/// Descriptor for `UploadProfileResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadProfileResponseDescriptor = $convert.base64Decode(
    'ChVVcGxvYWRQcm9maWxlUmVzcG9uc2USIQoEdXNlchgBIAEoCzINLnVzZXIudjEuVXNlclIEdX'
    'Nlcg==');

@$core.Deprecated('Use searchUserRequestDescriptor instead')
const SearchUserRequest$json = {
  '1': 'SearchUserRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'tag', '3': 2, '4': 1, '5': 9, '10': 'tag'},
  ],
};

/// Descriptor for `SearchUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchUserRequestDescriptor = $convert.base64Decode(
    'ChFTZWFyY2hVc2VyUmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1lEhAKA3RhZxgCIAEoCVIDdG'
    'Fn');

@$core.Deprecated('Use searchUserResponseDescriptor instead')
const SearchUserResponse$json = {
  '1': 'SearchUserResponse',
  '2': [
    {
      '1': 'users',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.user.v1.SearchedUser',
      '10': 'users'
    },
  ],
};

/// Descriptor for `SearchUserResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchUserResponseDescriptor = $convert.base64Decode(
    'ChJTZWFyY2hVc2VyUmVzcG9uc2USKwoFdXNlcnMYASADKAsyFS51c2VyLnYxLlNlYXJjaGVkVX'
    'NlclIFdXNlcnM=');

@$core.Deprecated('Use searchedUserDescriptor instead')
const SearchedUser$json = {
  '1': 'SearchedUser',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'tag', '3': 3, '4': 1, '5': 9, '10': 'tag'},
    {'1': 'profile_image_url', '3': 4, '4': 1, '5': 9, '10': 'profileImageUrl'},
  ],
};

/// Descriptor for `SearchedUser`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchedUserDescriptor = $convert.base64Decode(
    'CgxTZWFyY2hlZFVzZXISDgoCaWQYASABKANSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSEAoDdG'
    'FnGAMgASgJUgN0YWcSKgoRcHJvZmlsZV9pbWFnZV91cmwYBCABKAlSD3Byb2ZpbGVJbWFnZVVy'
    'bA==');

@$core.Deprecated('Use userDescriptor instead')
const User$json = {
  '1': 'User',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'email', '3': 2, '4': 1, '5': 9, '10': 'email'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {'1': 'tag', '3': 4, '4': 1, '5': 9, '10': 'tag'},
    {
      '1': 'status',
      '3': 6,
      '4': 1,
      '5': 14,
      '6': '.user.v1.UserStatus',
      '10': 'status'
    },
    {'1': 'profile_image_url', '3': 7, '4': 1, '5': 9, '10': 'profileImageUrl'},
  ],
  '9': [
    {'1': 5, '2': 6},
  ],
  '10': ['oauth_type'],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode(
    'CgRVc2VyEg4KAmlkGAEgASgDUgJpZBIUCgVlbWFpbBgCIAEoCVIFZW1haWwSEgoEbmFtZRgDIA'
    'EoCVIEbmFtZRIQCgN0YWcYBCABKAlSA3RhZxIrCgZzdGF0dXMYBiABKA4yEy51c2VyLnYxLlVz'
    'ZXJTdGF0dXNSBnN0YXR1cxIqChFwcm9maWxlX2ltYWdlX3VybBgHIAEoCVIPcHJvZmlsZUltYW'
    'dlVXJsSgQIBRAGUgpvYXV0aF90eXBl');
