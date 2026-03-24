// This is a generated file - do not edit.
//
// Generated from auth.proto.

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

@$core.Deprecated('Use authorizationRequestDescriptor instead')
const AuthorizationRequest$json = {
  '1': 'AuthorizationRequest',
  '2': [
    {'1': 'id_token', '3': 1, '4': 1, '5': 9, '10': 'idToken'},
    {'1': 'device_id', '3': 2, '4': 1, '5': 9, '10': 'deviceId'},
    {
      '1': 'oauth_type',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.pb.OauthType',
      '10': 'oauthType'
    },
  ],
};

/// Descriptor for `AuthorizationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List authorizationRequestDescriptor = $convert.base64Decode(
    'ChRBdXRob3JpemF0aW9uUmVxdWVzdBIZCghpZF90b2tlbhgBIAEoCVIHaWRUb2tlbhIbCglkZX'
    'ZpY2VfaWQYAiABKAlSCGRldmljZUlkEiwKCm9hdXRoX3R5cGUYAyABKA4yDS5wYi5PYXV0aFR5'
    'cGVSCW9hdXRoVHlwZQ==');

@$core.Deprecated('Use authorizationResponseDescriptor instead')
const AuthorizationResponse$json = {
  '1': 'AuthorizationResponse',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.pb.User', '10': 'user'},
    {'1': 'access_token', '3': 2, '4': 1, '5': 9, '10': 'accessToken'},
  ],
};

/// Descriptor for `AuthorizationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List authorizationResponseDescriptor = $convert.base64Decode(
    'ChVBdXRob3JpemF0aW9uUmVzcG9uc2USHAoEdXNlchgBIAEoCzIILnBiLlVzZXJSBHVzZXISIQ'
    'oMYWNjZXNzX3Rva2VuGAIgASgJUgthY2Nlc3NUb2tlbg==');

@$core.Deprecated('Use registerRequestDescriptor instead')
const RegisterRequest$json = {
  '1': 'RegisterRequest',
  '2': [
    {'1': 'nickname', '3': 1, '4': 1, '5': 9, '10': 'nickname'},
    {'1': 'tag', '3': 2, '4': 1, '5': 9, '10': 'tag'},
  ],
};

/// Descriptor for `RegisterRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerRequestDescriptor = $convert.base64Decode(
    'Cg9SZWdpc3RlclJlcXVlc3QSGgoIbmlja25hbWUYASABKAlSCG5pY2tuYW1lEhAKA3RhZxgCIA'
    'EoCVIDdGFn');

@$core.Deprecated('Use registerResponseDescriptor instead')
const RegisterResponse$json = {
  '1': 'RegisterResponse',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.pb.User', '10': 'user'},
  ],
};

/// Descriptor for `RegisterResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerResponseDescriptor = $convert.base64Decode(
    'ChBSZWdpc3RlclJlc3BvbnNlEhwKBHVzZXIYASABKAsyCC5wYi5Vc2VyUgR1c2Vy');

@$core.Deprecated('Use upsertFcmTokenRequestDescriptor instead')
const UpsertFcmTokenRequest$json = {
  '1': 'UpsertFcmTokenRequest',
  '2': [
    {'1': 'fcm_token', '3': 1, '4': 1, '5': 9, '10': 'fcmToken'},
  ],
};

/// Descriptor for `UpsertFcmTokenRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List upsertFcmTokenRequestDescriptor = $convert.base64Decode(
    'ChVVcHNlcnRGY21Ub2tlblJlcXVlc3QSGwoJZmNtX3Rva2VuGAEgASgJUghmY21Ub2tlbg==');
