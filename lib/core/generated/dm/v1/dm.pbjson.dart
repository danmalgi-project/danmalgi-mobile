// This is a generated file - do not edit.
//
// Generated from dm/v1/dm.proto.

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
      '1': 'items',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.dm.v1.DirectMessageChannelListItem',
      '10': 'items'
    },
  ],
};

/// Descriptor for `GetDirectMessageChannelListResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDirectMessageChannelListResponseDescriptor =
    $convert.base64Decode(
        'CiNHZXREaXJlY3RNZXNzYWdlQ2hhbm5lbExpc3RSZXNwb25zZRI5CgVpdGVtcxgBIAMoCzIjLm'
        'RtLnYxLkRpcmVjdE1lc3NhZ2VDaGFubmVsTGlzdEl0ZW1SBWl0ZW1z');

@$core.Deprecated('Use directMessageChannelListItemDescriptor instead')
const DirectMessageChannelListItem$json = {
  '1': 'DirectMessageChannelListItem',
  '2': [
    {
      '1': 'channel',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.dm.v1.DirectMessageChannel',
      '10': 'channel'
    },
    {
      '1': 'last_message',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.dm.v1.LastMessage',
      '10': 'lastMessage'
    },
  ],
};

/// Descriptor for `DirectMessageChannelListItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List directMessageChannelListItemDescriptor =
    $convert.base64Decode(
        'ChxEaXJlY3RNZXNzYWdlQ2hhbm5lbExpc3RJdGVtEjUKB2NoYW5uZWwYASABKAsyGy5kbS52MS'
        '5EaXJlY3RNZXNzYWdlQ2hhbm5lbFIHY2hhbm5lbBI1CgxsYXN0X21lc3NhZ2UYAiABKAsyEi5k'
        'bS52MS5MYXN0TWVzc2FnZVILbGFzdE1lc3NhZ2U=');

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
      '6': '.dm.v1.DirectMessageChannel',
      '10': 'directMessageChannel'
    },
  ],
};

/// Descriptor for `CreateDirectMessageChannelResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createDirectMessageChannelResponseDescriptor =
    $convert.base64Decode(
        'CiJDcmVhdGVEaXJlY3RNZXNzYWdlQ2hhbm5lbFJlc3BvbnNlElEKFmRpcmVjdF9tZXNzYWdlX2'
        'NoYW5uZWwYASABKAsyGy5kbS52MS5EaXJlY3RNZXNzYWdlQ2hhbm5lbFIUZGlyZWN0TWVzc2Fn'
        'ZUNoYW5uZWw=');

@$core.Deprecated('Use uploadChannelImageRequestDescriptor instead')
const UploadChannelImageRequest$json = {
  '1': 'UploadChannelImageRequest',
  '2': [
    {'1': 'dm_id', '3': 1, '4': 1, '5': 3, '10': 'dmId'},
    {'1': 'image', '3': 2, '4': 1, '5': 12, '10': 'image'},
    {'1': 'extension', '3': 3, '4': 1, '5': 9, '10': 'extension'},
  ],
};

/// Descriptor for `UploadChannelImageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadChannelImageRequestDescriptor =
    $convert.base64Decode(
        'ChlVcGxvYWRDaGFubmVsSW1hZ2VSZXF1ZXN0EhMKBWRtX2lkGAEgASgDUgRkbUlkEhQKBWltYW'
        'dlGAIgASgMUgVpbWFnZRIcCglleHRlbnNpb24YAyABKAlSCWV4dGVuc2lvbg==');

@$core.Deprecated('Use uploadChannelImageResponseDescriptor instead')
const UploadChannelImageResponse$json = {
  '1': 'UploadChannelImageResponse',
  '2': [
    {
      '1': 'direct_message_channel',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.dm.v1.DirectMessageChannel',
      '10': 'directMessageChannel'
    },
  ],
};

/// Descriptor for `UploadChannelImageResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadChannelImageResponseDescriptor =
    $convert.base64Decode(
        'ChpVcGxvYWRDaGFubmVsSW1hZ2VSZXNwb25zZRJRChZkaXJlY3RfbWVzc2FnZV9jaGFubmVsGA'
        'EgASgLMhsuZG0udjEuRGlyZWN0TWVzc2FnZUNoYW5uZWxSFGRpcmVjdE1lc3NhZ2VDaGFubmVs');

@$core.Deprecated('Use updateDirectMessageChannelRequestDescriptor instead')
const UpdateDirectMessageChannelRequest$json = {
  '1': 'UpdateDirectMessageChannelRequest',
  '2': [
    {'1': 'dm_id', '3': 1, '4': 1, '5': 3, '10': 'dmId'},
    {'1': 'channel_name', '3': 2, '4': 1, '5': 9, '10': 'channelName'},
    {'1': 'image', '3': 3, '4': 1, '5': 12, '10': 'image'},
    {'1': 'extension', '3': 4, '4': 1, '5': 9, '10': 'extension'},
  ],
};

/// Descriptor for `UpdateDirectMessageChannelRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateDirectMessageChannelRequestDescriptor =
    $convert.base64Decode(
        'CiFVcGRhdGVEaXJlY3RNZXNzYWdlQ2hhbm5lbFJlcXVlc3QSEwoFZG1faWQYASABKANSBGRtSW'
        'QSIQoMY2hhbm5lbF9uYW1lGAIgASgJUgtjaGFubmVsTmFtZRIUCgVpbWFnZRgDIAEoDFIFaW1h'
        'Z2USHAoJZXh0ZW5zaW9uGAQgASgJUglleHRlbnNpb24=');

@$core.Deprecated('Use updateDirectMessageChannelResponseDescriptor instead')
const UpdateDirectMessageChannelResponse$json = {
  '1': 'UpdateDirectMessageChannelResponse',
  '2': [
    {
      '1': 'direct_message_channel',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.dm.v1.DirectMessageChannel',
      '10': 'directMessageChannel'
    },
  ],
};

/// Descriptor for `UpdateDirectMessageChannelResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateDirectMessageChannelResponseDescriptor =
    $convert.base64Decode(
        'CiJVcGRhdGVEaXJlY3RNZXNzYWdlQ2hhbm5lbFJlc3BvbnNlElEKFmRpcmVjdF9tZXNzYWdlX2'
        'NoYW5uZWwYASABKAsyGy5kbS52MS5EaXJlY3RNZXNzYWdlQ2hhbm5lbFIUZGlyZWN0TWVzc2Fn'
        'ZUNoYW5uZWw=');

@$core.Deprecated('Use leaveDirectMessageChannelRequestDescriptor instead')
const LeaveDirectMessageChannelRequest$json = {
  '1': 'LeaveDirectMessageChannelRequest',
  '2': [
    {'1': 'dm_id', '3': 1, '4': 1, '5': 3, '10': 'dmId'},
  ],
};

/// Descriptor for `LeaveDirectMessageChannelRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List leaveDirectMessageChannelRequestDescriptor =
    $convert.base64Decode(
        'CiBMZWF2ZURpcmVjdE1lc3NhZ2VDaGFubmVsUmVxdWVzdBITCgVkbV9pZBgBIAEoA1IEZG1JZA'
        '==');

@$core.Deprecated('Use directMessageChannelDescriptor instead')
const DirectMessageChannel$json = {
  '1': 'DirectMessageChannel',
  '2': [
    {'1': 'dm_id', '3': 1, '4': 1, '5': 3, '10': 'dmId'},
    {
      '1': 'users',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.user.v1.User',
      '10': 'users'
    },
    {'1': 'channel_name', '3': 3, '4': 1, '5': 9, '10': 'channelName'},
    {'1': 'is_group', '3': 4, '4': 1, '5': 8, '10': 'isGroup'},
    {'1': 'channel_image_url', '3': 5, '4': 1, '5': 9, '10': 'channelImageUrl'},
  ],
  '9': [
    {'1': 6, '2': 7},
  ],
  '10': ['last_message'],
};

/// Descriptor for `DirectMessageChannel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List directMessageChannelDescriptor = $convert.base64Decode(
    'ChREaXJlY3RNZXNzYWdlQ2hhbm5lbBITCgVkbV9pZBgBIAEoA1IEZG1JZBIjCgV1c2VycxgCIA'
    'MoCzINLnVzZXIudjEuVXNlclIFdXNlcnMSIQoMY2hhbm5lbF9uYW1lGAMgASgJUgtjaGFubmVs'
    'TmFtZRIZCghpc19ncm91cBgEIAEoCFIHaXNHcm91cBIqChFjaGFubmVsX2ltYWdlX3VybBgFIA'
    'EoCVIPY2hhbm5lbEltYWdlVXJsSgQIBhAHUgxsYXN0X21lc3NhZ2U=');

@$core.Deprecated('Use lastMessageDescriptor instead')
const LastMessage$json = {
  '1': 'LastMessage',
  '2': [
    {'1': 'message_id', '3': 1, '4': 1, '5': 3, '10': 'messageId'},
    {'1': 'content', '3': 2, '4': 1, '5': 9, '10': 'content'},
    {'1': 'sender_id', '3': 3, '4': 1, '5': 3, '10': 'senderId'},
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

/// Descriptor for `LastMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lastMessageDescriptor = $convert.base64Decode(
    'CgtMYXN0TWVzc2FnZRIdCgptZXNzYWdlX2lkGAEgASgDUgltZXNzYWdlSWQSGAoHY29udGVudB'
    'gCIAEoCVIHY29udGVudBIbCglzZW5kZXJfaWQYAyABKANSCHNlbmRlcklkEjkKCmNyZWF0ZWRf'
    'YXQYBCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQ=');
