// This is a generated file - do not edit.
//
// Generated from internalpb/internal_chat.proto.

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

@$core.Deprecated('Use getDevicesRequestDescriptor instead')
const GetDevicesRequest$json = {
  '1': 'GetDevicesRequest',
  '2': [
    {'1': 'device_ids', '3': 1, '4': 3, '5': 9, '10': 'deviceIds'},
  ],
};

/// Descriptor for `GetDevicesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDevicesRequestDescriptor = $convert.base64Decode(
    'ChFHZXREZXZpY2VzUmVxdWVzdBIdCgpkZXZpY2VfaWRzGAEgAygJUglkZXZpY2VJZHM=');

@$core.Deprecated('Use getDevicesResponseDescriptor instead')
const GetDevicesResponse$json = {
  '1': 'GetDevicesResponse',
  '2': [
    {
      '1': 'devices',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.internalpb.Device',
      '10': 'devices'
    },
  ],
};

/// Descriptor for `GetDevicesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDevicesResponseDescriptor = $convert.base64Decode(
    'ChJHZXREZXZpY2VzUmVzcG9uc2USLAoHZGV2aWNlcxgBIAMoCzISLmludGVybmFscGIuRGV2aW'
    'NlUgdkZXZpY2Vz');

@$core.Deprecated('Use getChannelDevicesRequestDescriptor instead')
const GetChannelDevicesRequest$json = {
  '1': 'GetChannelDevicesRequest',
  '2': [
    {'1': 'channel_id', '3': 1, '4': 1, '5': 3, '10': 'channelId'},
  ],
};

/// Descriptor for `GetChannelDevicesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getChannelDevicesRequestDescriptor =
    $convert.base64Decode(
        'ChhHZXRDaGFubmVsRGV2aWNlc1JlcXVlc3QSHQoKY2hhbm5lbF9pZBgBIAEoA1IJY2hhbm5lbE'
        'lk');

@$core.Deprecated('Use getChannelDevicesResponseDescriptor instead')
const GetChannelDevicesResponse$json = {
  '1': 'GetChannelDevicesResponse',
  '2': [
    {
      '1': 'devices',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.internalpb.Device',
      '10': 'devices'
    },
  ],
};

/// Descriptor for `GetChannelDevicesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getChannelDevicesResponseDescriptor =
    $convert.base64Decode(
        'ChlHZXRDaGFubmVsRGV2aWNlc1Jlc3BvbnNlEiwKB2RldmljZXMYASADKAsyEi5pbnRlcm5hbH'
        'BiLkRldmljZVIHZGV2aWNlcw==');

@$core.Deprecated('Use getChannelNamesRequestDescriptor instead')
const GetChannelNamesRequest$json = {
  '1': 'GetChannelNamesRequest',
  '2': [
    {'1': 'channel_id', '3': 1, '4': 1, '5': 3, '10': 'channelId'},
    {'1': 'user_ids', '3': 2, '4': 3, '5': 3, '10': 'userIds'},
  ],
};

/// Descriptor for `GetChannelNamesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getChannelNamesRequestDescriptor =
    $convert.base64Decode(
        'ChZHZXRDaGFubmVsTmFtZXNSZXF1ZXN0Eh0KCmNoYW5uZWxfaWQYASABKANSCWNoYW5uZWxJZB'
        'IZCgh1c2VyX2lkcxgCIAMoA1IHdXNlcklkcw==');

@$core.Deprecated('Use getChannelNamesResponseDescriptor instead')
const GetChannelNamesResponse$json = {
  '1': 'GetChannelNamesResponse',
  '2': [
    {
      '1': 'channel_names',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.internalpb.ChannelName',
      '10': 'channelNames'
    },
  ],
};

/// Descriptor for `GetChannelNamesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getChannelNamesResponseDescriptor =
    $convert.base64Decode(
        'ChdHZXRDaGFubmVsTmFtZXNSZXNwb25zZRI8Cg1jaGFubmVsX25hbWVzGAEgAygLMhcuaW50ZX'
        'JuYWxwYi5DaGFubmVsTmFtZVIMY2hhbm5lbE5hbWVz');

@$core.Deprecated('Use deviceDescriptor instead')
const Device$json = {
  '1': 'Device',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 3, '10': 'userId'},
    {'1': 'device_id', '3': 2, '4': 1, '5': 9, '10': 'deviceId'},
    {'1': 'fcm_token', '3': 3, '4': 1, '5': 9, '10': 'fcmToken'},
  ],
};

/// Descriptor for `Device`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceDescriptor = $convert.base64Decode(
    'CgZEZXZpY2USFwoHdXNlcl9pZBgBIAEoA1IGdXNlcklkEhsKCWRldmljZV9pZBgCIAEoCVIIZG'
    'V2aWNlSWQSGwoJZmNtX3Rva2VuGAMgASgJUghmY21Ub2tlbg==');

@$core.Deprecated('Use channelNameDescriptor instead')
const ChannelName$json = {
  '1': 'ChannelName',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 3, '10': 'userId'},
    {'1': 'channel_name', '3': 2, '4': 1, '5': 9, '10': 'channelName'},
  ],
};

/// Descriptor for `ChannelName`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelNameDescriptor = $convert.base64Decode(
    'CgtDaGFubmVsTmFtZRIXCgd1c2VyX2lkGAEgASgDUgZ1c2VySWQSIQoMY2hhbm5lbF9uYW1lGA'
    'IgASgJUgtjaGFubmVsTmFtZQ==');
