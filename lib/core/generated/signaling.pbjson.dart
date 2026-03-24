// This is a generated file - do not edit.
//
// Generated from signaling.proto.

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

@$core.Deprecated('Use trackTypeDescriptor instead')
const TrackType$json = {
  '1': 'TrackType',
  '2': [
    {'1': 'AUDIO', '2': 0},
    {'1': 'CAM_AUDIO', '2': 1},
    {'1': 'CAM_VIDEO', '2': 2},
    {'1': 'SCREEN_AUDIO', '2': 3},
    {'1': 'SCREEN_VIDEO', '2': 4},
  ],
};

/// Descriptor for `TrackType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List trackTypeDescriptor = $convert.base64Decode(
    'CglUcmFja1R5cGUSCQoFQVVESU8QABINCglDQU1fQVVESU8QARINCglDQU1fVklERU8QAhIQCg'
    'xTQ1JFRU5fQVVESU8QAxIQCgxTQ1JFRU5fVklERU8QBA==');

@$core.Deprecated('Use signalingRequestDescriptor instead')
const SignalingRequest$json = {
  '1': 'SignalingRequest',
  '2': [
    {
      '1': 'signaling_request_info',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.pb.SignalingRequestInfo',
      '10': 'signalingRequestInfo'
    },
  ],
};

/// Descriptor for `SignalingRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signalingRequestDescriptor = $convert.base64Decode(
    'ChBTaWduYWxpbmdSZXF1ZXN0Ek4KFnNpZ25hbGluZ19yZXF1ZXN0X2luZm8YASABKAsyGC5wYi'
    '5TaWduYWxpbmdSZXF1ZXN0SW5mb1IUc2lnbmFsaW5nUmVxdWVzdEluZm8=');

@$core.Deprecated('Use signalingResponseDescriptor instead')
const SignalingResponse$json = {
  '1': 'SignalingResponse',
  '2': [
    {
      '1': 'signaling_response_info',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.pb.SignalingResponseInfo',
      '10': 'signalingResponseInfo'
    },
  ],
};

/// Descriptor for `SignalingResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signalingResponseDescriptor = $convert.base64Decode(
    'ChFTaWduYWxpbmdSZXNwb25zZRJRChdzaWduYWxpbmdfcmVzcG9uc2VfaW5mbxgBIAEoCzIZLn'
    'BiLlNpZ25hbGluZ1Jlc3BvbnNlSW5mb1IVc2lnbmFsaW5nUmVzcG9uc2VJbmZv');

@$core.Deprecated('Use signalingRequestInfoDescriptor instead')
const SignalingRequestInfo$json = {
  '1': 'SignalingRequestInfo',
  '2': [
    {
      '1': 'answer',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.pb.Answer',
      '9': 0,
      '10': 'answer'
    },
    {
      '1': 'candidate',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.pb.Candidate',
      '9': 0,
      '10': 'candidate'
    },
  ],
  '8': [
    {'1': 'message'},
  ],
};

/// Descriptor for `SignalingRequestInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signalingRequestInfoDescriptor = $convert.base64Decode(
    'ChRTaWduYWxpbmdSZXF1ZXN0SW5mbxIkCgZhbnN3ZXIYASABKAsyCi5wYi5BbnN3ZXJIAFIGYW'
    '5zd2VyEi0KCWNhbmRpZGF0ZRgCIAEoCzINLnBiLkNhbmRpZGF0ZUgAUgljYW5kaWRhdGVCCQoH'
    'bWVzc2FnZQ==');

@$core.Deprecated('Use signalingResponseInfoDescriptor instead')
const SignalingResponseInfo$json = {
  '1': 'SignalingResponseInfo',
  '2': [
    {
      '1': 'offer',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.pb.Offer',
      '9': 0,
      '10': 'offer'
    },
    {
      '1': 'answer',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.pb.Answer',
      '9': 0,
      '10': 'answer'
    },
    {
      '1': 'candidate',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.pb.Candidate',
      '9': 0,
      '10': 'candidate'
    },
  ],
  '8': [
    {'1': 'message'},
  ],
};

/// Descriptor for `SignalingResponseInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signalingResponseInfoDescriptor = $convert.base64Decode(
    'ChVTaWduYWxpbmdSZXNwb25zZUluZm8SIQoFb2ZmZXIYASABKAsyCS5wYi5PZmZlckgAUgVvZm'
    'ZlchIkCgZhbnN3ZXIYAiABKAsyCi5wYi5BbnN3ZXJIAFIGYW5zd2VyEi0KCWNhbmRpZGF0ZRgD'
    'IAEoCzINLnBiLkNhbmRpZGF0ZUgAUgljYW5kaWRhdGVCCQoHbWVzc2FnZQ==');

@$core.Deprecated('Use offerDescriptor instead')
const Offer$json = {
  '1': 'Offer',
  '2': [
    {
      '1': 'sdp',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.pb.SessionDescription',
      '10': 'sdp'
    },
    {
      '1': 'joined_user_tracks',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.pb.UserTracks',
      '9': 0,
      '10': 'joinedUserTracks',
      '17': true
    },
  ],
  '8': [
    {'1': '_joined_user_tracks'},
  ],
};

/// Descriptor for `Offer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List offerDescriptor = $convert.base64Decode(
    'CgVPZmZlchIoCgNzZHAYASABKAsyFi5wYi5TZXNzaW9uRGVzY3JpcHRpb25SA3NkcBJBChJqb2'
    'luZWRfdXNlcl90cmFja3MYAiABKAsyDi5wYi5Vc2VyVHJhY2tzSABSEGpvaW5lZFVzZXJUcmFj'
    'a3OIAQFCFQoTX2pvaW5lZF91c2VyX3RyYWNrcw==');

@$core.Deprecated('Use answerDescriptor instead')
const Answer$json = {
  '1': 'Answer',
  '2': [
    {
      '1': 'sdp',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.pb.SessionDescription',
      '10': 'sdp'
    },
  ],
};

/// Descriptor for `Answer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List answerDescriptor = $convert.base64Decode(
    'CgZBbnN3ZXISKAoDc2RwGAEgASgLMhYucGIuU2Vzc2lvbkRlc2NyaXB0aW9uUgNzZHA=');

@$core.Deprecated('Use sessionDescriptionDescriptor instead')
const SessionDescription$json = {
  '1': 'SessionDescription',
  '2': [
    {'1': 'sdp_type', '3': 1, '4': 1, '5': 9, '10': 'sdpType'},
    {'1': 'sdp_data', '3': 2, '4': 1, '5': 9, '10': 'sdpData'},
  ],
};

/// Descriptor for `SessionDescription`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sessionDescriptionDescriptor = $convert.base64Decode(
    'ChJTZXNzaW9uRGVzY3JpcHRpb24SGQoIc2RwX3R5cGUYASABKAlSB3NkcFR5cGUSGQoIc2RwX2'
    'RhdGEYAiABKAlSB3NkcERhdGE=');

@$core.Deprecated('Use candidateDescriptor instead')
const Candidate$json = {
  '1': 'Candidate',
  '2': [
    {'1': 'candidate', '3': 1, '4': 1, '5': 9, '10': 'candidate'},
    {'1': 'sdp_mid', '3': 2, '4': 1, '5': 9, '10': 'sdpMid'},
    {'1': 'sdp_mline_index', '3': 3, '4': 1, '5': 5, '10': 'sdpMlineIndex'},
  ],
};

/// Descriptor for `Candidate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List candidateDescriptor = $convert.base64Decode(
    'CglDYW5kaWRhdGUSHAoJY2FuZGlkYXRlGAEgASgJUgljYW5kaWRhdGUSFwoHc2RwX21pZBgCIA'
    'EoCVIGc2RwTWlkEiYKD3NkcF9tbGluZV9pbmRleBgDIAEoBVINc2RwTWxpbmVJbmRleA==');

@$core.Deprecated('Use userTracksDescriptor instead')
const UserTracks$json = {
  '1': 'UserTracks',
  '2': [
    {
      '1': 'user_tracks',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.pb.UserTrack',
      '10': 'userTracks'
    },
  ],
};

/// Descriptor for `UserTracks`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userTracksDescriptor = $convert.base64Decode(
    'CgpVc2VyVHJhY2tzEi4KC3VzZXJfdHJhY2tzGAEgAygLMg0ucGIuVXNlclRyYWNrUgp1c2VyVH'
    'JhY2tz');

@$core.Deprecated('Use userTrackDescriptor instead')
const UserTrack$json = {
  '1': 'UserTrack',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.pb.User', '10': 'user'},
    {'1': 'track_id', '3': 2, '4': 1, '5': 9, '10': 'trackId'},
    {
      '1': 'track_type',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.pb.TrackType',
      '10': 'trackType'
    },
  ],
};

/// Descriptor for `UserTrack`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userTrackDescriptor = $convert.base64Decode(
    'CglVc2VyVHJhY2sSHAoEdXNlchgBIAEoCzIILnBiLlVzZXJSBHVzZXISGQoIdHJhY2tfaWQYAi'
    'ABKAlSB3RyYWNrSWQSLAoKdHJhY2tfdHlwZRgDIAEoDjINLnBiLlRyYWNrVHlwZVIJdHJhY2tU'
    'eXBl');
