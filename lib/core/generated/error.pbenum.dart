// This is a generated file - do not edit.
//
// Generated from error.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ErrorCode extends $pb.ProtobufEnum {
  static const ErrorCode INVALID_TOKEN =
      ErrorCode._(0, _omitEnumNames ? '' : 'INVALID_TOKEN');
  static const ErrorCode INVALID_INPUT =
      ErrorCode._(1, _omitEnumNames ? '' : 'INVALID_INPUT');
  static const ErrorCode DUPLICATED_DATA =
      ErrorCode._(2, _omitEnumNames ? '' : 'DUPLICATED_DATA');
  static const ErrorCode OAUTH_ERROR =
      ErrorCode._(3, _omitEnumNames ? '' : 'OAUTH_ERROR');
  static const ErrorCode TOKEN_CREATION_FAILED =
      ErrorCode._(4, _omitEnumNames ? '' : 'TOKEN_CREATION_FAILED');
  static const ErrorCode PERSISTENCE_ERROR =
      ErrorCode._(5, _omitEnumNames ? '' : 'PERSISTENCE_ERROR');
  static const ErrorCode RECORD_NOT_FOUND =
      ErrorCode._(6, _omitEnumNames ? '' : 'RECORD_NOT_FOUND');
  static const ErrorCode SIGNALING_ERROR =
      ErrorCode._(7, _omitEnumNames ? '' : 'SIGNALING_ERROR');

  static const $core.List<ErrorCode> values = <ErrorCode>[
    INVALID_TOKEN,
    INVALID_INPUT,
    DUPLICATED_DATA,
    OAUTH_ERROR,
    TOKEN_CREATION_FAILED,
    PERSISTENCE_ERROR,
    RECORD_NOT_FOUND,
    SIGNALING_ERROR,
  ];

  static final $core.List<ErrorCode?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 7);
  static ErrorCode? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ErrorCode._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
