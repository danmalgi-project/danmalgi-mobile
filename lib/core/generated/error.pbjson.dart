// This is a generated file - do not edit.
//
// Generated from error.proto.

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

@$core.Deprecated('Use errorCodeDescriptor instead')
const ErrorCode$json = {
  '1': 'ErrorCode',
  '2': [
    {'1': 'INVALID_TOKEN', '2': 0},
    {'1': 'INVALID_INPUT', '2': 1},
    {'1': 'DUPLICATED_DATA', '2': 2},
    {'1': 'OAUTH_ERROR', '2': 3},
    {'1': 'TOKEN_CREATION_FAILED', '2': 4},
    {'1': 'PERSISTENCE_ERROR', '2': 5},
    {'1': 'RECORD_NOT_FOUND', '2': 6},
    {'1': 'SIGNALING_ERROR', '2': 7},
  ],
};

/// Descriptor for `ErrorCode`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List errorCodeDescriptor = $convert.base64Decode(
    'CglFcnJvckNvZGUSEQoNSU5WQUxJRF9UT0tFThAAEhEKDUlOVkFMSURfSU5QVVQQARITCg9EVV'
    'BMSUNBVEVEX0RBVEEQAhIPCgtPQVVUSF9FUlJPUhADEhkKFVRPS0VOX0NSRUFUSU9OX0ZBSUxF'
    'RBAEEhUKEVBFUlNJU1RFTkNFX0VSUk9SEAUSFAoQUkVDT1JEX05PVF9GT1VORBAGEhMKD1NJR0'
    '5BTElOR19FUlJPUhAH');

@$core.Deprecated('Use errorDetailDescriptor instead')
const ErrorDetail$json = {
  '1': 'ErrorDetail',
  '2': [
    {
      '1': 'error_code',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.pb.ErrorCode',
      '10': 'errorCode'
    },
  ],
};

/// Descriptor for `ErrorDetail`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List errorDetailDescriptor = $convert.base64Decode(
    'CgtFcnJvckRldGFpbBIsCgplcnJvcl9jb2RlGAEgASgOMg0ucGIuRXJyb3JDb2RlUgllcnJvck'
    'NvZGU=');
