// This is a generated file - do not edit.
//
// Generated from direct_message.proto.

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

@$core.Deprecated('Use getDirectMessageChannelListResponseDescriptor instead')
const GetDirectMessageChannelListResponse$json = {
  '1': 'GetDirectMessageChannelListResponse',
  '2': [
    {
      '1': 'direct_message_channels',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.pb.DirectMessageChannel',
      '10': 'directMessageChannels'
    },
  ],
};

/// Descriptor for `GetDirectMessageChannelListResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDirectMessageChannelListResponseDescriptor =
    $convert.base64Decode(
        'CiNHZXREaXJlY3RNZXNzYWdlQ2hhbm5lbExpc3RSZXNwb25zZRJQChdkaXJlY3RfbWVzc2FnZV'
        '9jaGFubmVscxgBIAMoCzIYLnBiLkRpcmVjdE1lc3NhZ2VDaGFubmVsUhVkaXJlY3RNZXNzYWdl'
        'Q2hhbm5lbHM=');

@$core.Deprecated('Use createDirectMessageChannelRequestDescriptor instead')
const CreateDirectMessageChannelRequest$json = {
  '1': 'CreateDirectMessageChannelRequest',
  '2': [
    {'1': 'friend_ids', '3': 1, '4': 3, '5': 3, '10': 'friendIds'},
  ],
};

/// Descriptor for `CreateDirectMessageChannelRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createDirectMessageChannelRequestDescriptor =
    $convert.base64Decode(
        'CiFDcmVhdGVEaXJlY3RNZXNzYWdlQ2hhbm5lbFJlcXVlc3QSHQoKZnJpZW5kX2lkcxgBIAMoA1'
        'IJZnJpZW5kSWRz');

@$core.Deprecated('Use createDirectMessageChannelResponseDescriptor instead')
const CreateDirectMessageChannelResponse$json = {
  '1': 'CreateDirectMessageChannelResponse',
  '2': [
    {
      '1': 'direct_message_channel',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.pb.DirectMessageChannel',
      '10': 'directMessageChannel'
    },
  ],
};

/// Descriptor for `CreateDirectMessageChannelResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createDirectMessageChannelResponseDescriptor =
    $convert.base64Decode(
        'CiJDcmVhdGVEaXJlY3RNZXNzYWdlQ2hhbm5lbFJlc3BvbnNlEk4KFmRpcmVjdF9tZXNzYWdlX2'
        'NoYW5uZWwYASABKAsyGC5wYi5EaXJlY3RNZXNzYWdlQ2hhbm5lbFIUZGlyZWN0TWVzc2FnZUNo'
        'YW5uZWw=');

@$core.Deprecated('Use directMessageChannelDescriptor instead')
const DirectMessageChannel$json = {
  '1': 'DirectMessageChannel',
  '2': [
    {'1': 'dm_id', '3': 1, '4': 1, '5': 3, '10': 'dmId'},
    {'1': 'users', '3': 2, '4': 3, '5': 11, '6': '.pb.User', '10': 'users'},
    {'1': 'channel_name', '3': 3, '4': 1, '5': 9, '10': 'channelName'},
  ],
};

/// Descriptor for `DirectMessageChannel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List directMessageChannelDescriptor = $convert.base64Decode(
    'ChREaXJlY3RNZXNzYWdlQ2hhbm5lbBITCgVkbV9pZBgBIAEoA1IEZG1JZBIeCgV1c2VycxgCIA'
    'MoCzIILnBiLlVzZXJSBXVzZXJzEiEKDGNoYW5uZWxfbmFtZRgDIAEoCVILY2hhbm5lbE5hbWU=');
