// This is a generated file - do not edit.
//
// Generated from friend/v1/friend.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Enum
class FriendStatus extends $pb.ProtobufEnum {
  static const FriendStatus ACCEPT =
      FriendStatus._(0, _omitEnumNames ? '' : 'ACCEPT');
  static const FriendStatus BLOCK =
      FriendStatus._(1, _omitEnumNames ? '' : 'BLOCK');
  static const FriendStatus DELETE =
      FriendStatus._(2, _omitEnumNames ? '' : 'DELETE');

  static const $core.List<FriendStatus> values = <FriendStatus>[
    ACCEPT,
    BLOCK,
    DELETE,
  ];

  static final $core.List<FriendStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static FriendStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const FriendStatus._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
