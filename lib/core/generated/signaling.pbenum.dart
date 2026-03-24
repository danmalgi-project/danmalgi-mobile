// This is a generated file - do not edit.
//
// Generated from signaling.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// 트랙 타입 열거형
class TrackType extends $pb.ProtobufEnum {
  /// 오디오 트랙
  static const TrackType AUDIO = TrackType._(0, _omitEnumNames ? '' : 'AUDIO');

  /// 카메라 오디오 트랙
  static const TrackType CAM_AUDIO =
      TrackType._(1, _omitEnumNames ? '' : 'CAM_AUDIO');

  /// 카메라 비디오 트랙
  static const TrackType CAM_VIDEO =
      TrackType._(2, _omitEnumNames ? '' : 'CAM_VIDEO');

  /// 화면 공유 오디오 트랙
  static const TrackType SCREEN_AUDIO =
      TrackType._(3, _omitEnumNames ? '' : 'SCREEN_AUDIO');

  /// 화면 공유 비디오 트랙
  static const TrackType SCREEN_VIDEO =
      TrackType._(4, _omitEnumNames ? '' : 'SCREEN_VIDEO');

  static const $core.List<TrackType> values = <TrackType>[
    AUDIO,
    CAM_AUDIO,
    CAM_VIDEO,
    SCREEN_AUDIO,
    SCREEN_VIDEO,
  ];

  static final $core.List<TrackType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static TrackType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const TrackType._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
