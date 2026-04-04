// This is a generated file - do not edit.
//
// Generated from etc/room.proto.

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

@$core.Deprecated('Use roleDescriptor instead')
const Role$json = {
  '1': 'Role',
  '2': [
    {'1': 'admin', '2': 0},
    {'1': 'user', '2': 1},
  ],
};

/// Descriptor for `Role`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List roleDescriptor =
    $convert.base64Decode('CgRSb2xlEgkKBWFkbWluEAASCAoEdXNlchAB');

@$core.Deprecated('Use roomDescriptor instead')
const Room$json = {
  '1': 'Room',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'socket_url', '3': 3, '4': 1, '5': 9, '10': 'socketUrl'},
    {
      '1': 'created_at',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
  ],
};

/// Descriptor for `Room`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List roomDescriptor = $convert.base64Decode(
    'CgRSb29tEg4KAmlkGAEgASgDUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEh0KCnNvY2tldF91cm'
    'wYAyABKAlSCXNvY2tldFVybBI5CgpjcmVhdGVkX2F0GAQgASgLMhouZ29vZ2xlLnByb3RvYnVm'
    'LlRpbWVzdGFtcFIJY3JlYXRlZEF0');

@$core.Deprecated('Use roomItemDescriptor instead')
const RoomItem$json = {
  '1': 'RoomItem',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `RoomItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List roomItemDescriptor = $convert.base64Decode(
    'CghSb29tSXRlbRIOCgJpZBgBIAEoA1ICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZQ==');

@$core.Deprecated('Use createRoomRequestDescriptor instead')
const CreateRoomRequest$json = {
  '1': 'CreateRoomRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `CreateRoomRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createRoomRequestDescriptor = $convert
    .base64Decode('ChFDcmVhdGVSb29tUmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1l');

@$core.Deprecated('Use createRoomResponseDescriptor instead')
const CreateRoomResponse$json = {
  '1': 'CreateRoomResponse',
  '2': [
    {'1': 'room', '3': 1, '4': 1, '5': 11, '6': '.pb.Room', '10': 'room'},
  ],
};

/// Descriptor for `CreateRoomResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createRoomResponseDescriptor =
    $convert.base64Decode(
        'ChJDcmVhdGVSb29tUmVzcG9uc2USHAoEcm9vbRgBIAEoCzIILnBiLlJvb21SBHJvb20=');

@$core.Deprecated('Use getRoomListRequestDescriptor instead')
const GetRoomListRequest$json = {
  '1': 'GetRoomListRequest',
  '2': [
    {'1': 'offset', '3': 1, '4': 1, '5': 5, '10': 'offset'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    {
      '1': 'refresh_time',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'refreshTime'
    },
  ],
};

/// Descriptor for `GetRoomListRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRoomListRequestDescriptor = $convert.base64Decode(
    'ChJHZXRSb29tTGlzdFJlcXVlc3QSFgoGb2Zmc2V0GAEgASgFUgZvZmZzZXQSFAoFbGltaXQYAi'
    'ABKAVSBWxpbWl0Ej0KDHJlZnJlc2hfdGltZRgDIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1l'
    'c3RhbXBSC3JlZnJlc2hUaW1l');

@$core.Deprecated('Use getRoomListResponseDescriptor instead')
const GetRoomListResponse$json = {
  '1': 'GetRoomListResponse',
  '2': [
    {
      '1': 'roomList',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.pb.RoomItem',
      '10': 'roomList'
    },
  ],
};

/// Descriptor for `GetRoomListResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRoomListResponseDescriptor = $convert.base64Decode(
    'ChNHZXRSb29tTGlzdFJlc3BvbnNlEigKCHJvb21MaXN0GAEgAygLMgwucGIuUm9vbUl0ZW1SCH'
    'Jvb21MaXN0');

@$core.Deprecated('Use getRoomRequestDescriptor instead')
const GetRoomRequest$json = {
  '1': 'GetRoomRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
  ],
};

/// Descriptor for `GetRoomRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRoomRequestDescriptor =
    $convert.base64Decode('Cg5HZXRSb29tUmVxdWVzdBIOCgJpZBgBIAEoA1ICaWQ=');

@$core.Deprecated('Use getRoomResponseDescriptor instead')
const GetRoomResponse$json = {
  '1': 'GetRoomResponse',
  '2': [
    {'1': 'room', '3': 1, '4': 1, '5': 11, '6': '.pb.Room', '10': 'room'},
  ],
};

/// Descriptor for `GetRoomResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRoomResponseDescriptor = $convert.base64Decode(
    'Cg9HZXRSb29tUmVzcG9uc2USHAoEcm9vbRgBIAEoCzIILnBiLlJvb21SBHJvb20=');
