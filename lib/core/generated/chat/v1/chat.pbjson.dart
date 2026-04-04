// This is a generated file - do not edit.
//
// Generated from chat/v1/chat.proto.

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

@$core.Deprecated('Use messageStatusDescriptor instead')
const MessageStatus$json = {
  '1': 'MessageStatus',
  '2': [
    {'1': 'NONE', '2': 0},
    {'1': 'MODIFIED', '2': 1},
    {'1': 'DELETED', '2': 2},
  ],
};

/// Descriptor for `MessageStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List messageStatusDescriptor = $convert.base64Decode(
    'Cg1NZXNzYWdlU3RhdHVzEggKBE5PTkUQABIMCghNT0RJRklFRBABEgsKB0RFTEVURUQQAg==');

@$core.Deprecated('Use getPreviousMessagesRequestDescriptor instead')
const GetPreviousMessagesRequest$json = {
  '1': 'GetPreviousMessagesRequest',
  '2': [
    {'1': 'channel_id', '3': 1, '4': 1, '5': 3, '10': 'channelId'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    {
      '1': 'message_id',
      '3': 3,
      '4': 1,
      '5': 3,
      '9': 0,
      '10': 'messageId',
      '17': true
    },
  ],
  '8': [
    {'1': '_message_id'},
  ],
};

/// Descriptor for `GetPreviousMessagesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPreviousMessagesRequestDescriptor =
    $convert.base64Decode(
        'ChpHZXRQcmV2aW91c01lc3NhZ2VzUmVxdWVzdBIdCgpjaGFubmVsX2lkGAEgASgDUgljaGFubm'
        'VsSWQSFAoFbGltaXQYAiABKAVSBWxpbWl0EiIKCm1lc3NhZ2VfaWQYAyABKANIAFIJbWVzc2Fn'
        'ZUlkiAEBQg0KC19tZXNzYWdlX2lk');

@$core.Deprecated('Use getPreviousMessagesResponseDescriptor instead')
const GetPreviousMessagesResponse$json = {
  '1': 'GetPreviousMessagesResponse',
  '2': [
    {
      '1': 'messages',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.chat.v1.Message',
      '10': 'messages'
    },
  ],
};

/// Descriptor for `GetPreviousMessagesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPreviousMessagesResponseDescriptor =
    $convert.base64Decode(
        'ChtHZXRQcmV2aW91c01lc3NhZ2VzUmVzcG9uc2USLAoIbWVzc2FnZXMYASADKAsyEC5jaGF0Ln'
        'YxLk1lc3NhZ2VSCG1lc3NhZ2Vz');

@$core.Deprecated('Use modifyMessageRequestDescriptor instead')
const ModifyMessageRequest$json = {
  '1': 'ModifyMessageRequest',
  '2': [
    {'1': 'channel_id', '3': 1, '4': 1, '5': 3, '10': 'channelId'},
    {'1': 'message_id', '3': 2, '4': 1, '5': 3, '10': 'messageId'},
    {'1': 'content', '3': 3, '4': 1, '5': 9, '10': 'content'},
  ],
};

/// Descriptor for `ModifyMessageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List modifyMessageRequestDescriptor = $convert.base64Decode(
    'ChRNb2RpZnlNZXNzYWdlUmVxdWVzdBIdCgpjaGFubmVsX2lkGAEgASgDUgljaGFubmVsSWQSHQ'
    'oKbWVzc2FnZV9pZBgCIAEoA1IJbWVzc2FnZUlkEhgKB2NvbnRlbnQYAyABKAlSB2NvbnRlbnQ=');

@$core.Deprecated('Use deleteMessageRequestDescriptor instead')
const DeleteMessageRequest$json = {
  '1': 'DeleteMessageRequest',
  '2': [
    {'1': 'channel_id', '3': 1, '4': 1, '5': 3, '10': 'channelId'},
    {'1': 'message_id', '3': 2, '4': 1, '5': 3, '10': 'messageId'},
  ],
};

/// Descriptor for `DeleteMessageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteMessageRequestDescriptor = $convert.base64Decode(
    'ChREZWxldGVNZXNzYWdlUmVxdWVzdBIdCgpjaGFubmVsX2lkGAEgASgDUgljaGFubmVsSWQSHQ'
    'oKbWVzc2FnZV9pZBgCIAEoA1IJbWVzc2FnZUlk');

@$core.Deprecated('Use sendMessageRequestDescriptor instead')
const SendMessageRequest$json = {
  '1': 'SendMessageRequest',
  '2': [
    {'1': 'channel_id', '3': 1, '4': 1, '5': 3, '10': 'channelId'},
    {'1': 'content', '3': 2, '4': 1, '5': 9, '10': 'content'},
    {'1': 'file', '3': 3, '4': 1, '5': 12, '10': 'file'},
  ],
};

/// Descriptor for `SendMessageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendMessageRequestDescriptor = $convert.base64Decode(
    'ChJTZW5kTWVzc2FnZVJlcXVlc3QSHQoKY2hhbm5lbF9pZBgBIAEoA1IJY2hhbm5lbElkEhgKB2'
    'NvbnRlbnQYAiABKAlSB2NvbnRlbnQSEgoEZmlsZRgDIAEoDFIEZmlsZQ==');

@$core.Deprecated('Use receiveMessageRequestDescriptor instead')
const ReceiveMessageRequest$json = {
  '1': 'ReceiveMessageRequest',
  '2': [
    {'1': 'channel_id', '3': 1, '4': 1, '5': 3, '10': 'channelId'},
  ],
};

/// Descriptor for `ReceiveMessageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List receiveMessageRequestDescriptor = $convert.base64Decode(
    'ChVSZWNlaXZlTWVzc2FnZVJlcXVlc3QSHQoKY2hhbm5lbF9pZBgBIAEoA1IJY2hhbm5lbElk');

@$core.Deprecated('Use receiveMessageResponseDescriptor instead')
const ReceiveMessageResponse$json = {
  '1': 'ReceiveMessageResponse',
  '2': [
    {
      '1': 'message',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.chat.v1.Message',
      '10': 'message'
    },
    {
      '1': 'status',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.chat.v1.MessageStatus',
      '10': 'status'
    },
  ],
};

/// Descriptor for `ReceiveMessageResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List receiveMessageResponseDescriptor = $convert.base64Decode(
    'ChZSZWNlaXZlTWVzc2FnZVJlc3BvbnNlEioKB21lc3NhZ2UYASABKAsyEC5jaGF0LnYxLk1lc3'
    'NhZ2VSB21lc3NhZ2USLgoGc3RhdHVzGAIgASgOMhYuY2hhdC52MS5NZXNzYWdlU3RhdHVzUgZz'
    'dGF0dXM=');

@$core.Deprecated('Use messageDescriptor instead')
const Message$json = {
  '1': 'Message',
  '2': [
    {'1': 'channel_id', '3': 1, '4': 1, '5': 3, '10': 'channelId'},
    {'1': 'content', '3': 2, '4': 1, '5': 9, '10': 'content'},
    {'1': 'file', '3': 3, '4': 1, '5': 9, '10': 'file'},
    {'1': 'user', '3': 4, '4': 1, '5': 11, '6': '.user.v1.User', '10': 'user'},
    {
      '1': 'created_at',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
    {
      '1': 'updated_at',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'updatedAt'
    },
    {'1': 'id', '3': 7, '4': 1, '5': 3, '10': 'id'},
    {'1': 'is_author', '3': 8, '4': 1, '5': 8, '10': 'isAuthor'},
  ],
};

/// Descriptor for `Message`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List messageDescriptor = $convert.base64Decode(
    'CgdNZXNzYWdlEh0KCmNoYW5uZWxfaWQYASABKANSCWNoYW5uZWxJZBIYCgdjb250ZW50GAIgAS'
    'gJUgdjb250ZW50EhIKBGZpbGUYAyABKAlSBGZpbGUSIQoEdXNlchgEIAEoCzINLnVzZXIudjEu'
    'VXNlclIEdXNlchI5CgpjcmVhdGVkX2F0GAUgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdG'
    'FtcFIJY3JlYXRlZEF0EjkKCnVwZGF0ZWRfYXQYBiABKAsyGi5nb29nbGUucHJvdG9idWYuVGlt'
    'ZXN0YW1wUgl1cGRhdGVkQXQSDgoCaWQYByABKANSAmlkEhsKCWlzX2F1dGhvchgIIAEoCFIIaX'
    'NBdXRob3I=');
