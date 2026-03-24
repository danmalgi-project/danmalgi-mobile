// This is a generated file - do not edit.
//
// Generated from chat.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class MessageStatus extends $pb.ProtobufEnum {
  static const MessageStatus NONE =
      MessageStatus._(0, _omitEnumNames ? '' : 'NONE');
  static const MessageStatus MODIFIED =
      MessageStatus._(1, _omitEnumNames ? '' : 'MODIFIED');
  static const MessageStatus DELETED =
      MessageStatus._(2, _omitEnumNames ? '' : 'DELETED');

  static const $core.List<MessageStatus> values = <MessageStatus>[
    NONE,
    MODIFIED,
    DELETED,
  ];

  static final $core.List<MessageStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static MessageStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const MessageStatus._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
