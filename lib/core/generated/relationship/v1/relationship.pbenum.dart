// This is a generated file - do not edit.
//
// Generated from relationship/v1/relationship.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Enum
class RelationshipStatus extends $pb.ProtobufEnum {
  /// incoming에서만 사용
  static const RelationshipStatus RELATION_ACCEPT =
      RelationshipStatus._(0, _omitEnumNames ? '' : 'RELATION_ACCEPT');
  static const RelationshipStatus RELATION_REJECT =
      RelationshipStatus._(1, _omitEnumNames ? '' : 'RELATION_REJECT');
  static const RelationshipStatus RELATION_PENDING =
      RelationshipStatus._(2, _omitEnumNames ? '' : 'RELATION_PENDING');

  /// outgoing에서만 사용
  static const RelationshipStatus RELATION_CANCEL =
      RelationshipStatus._(3, _omitEnumNames ? '' : 'RELATION_CANCEL');

  static const $core.List<RelationshipStatus> values = <RelationshipStatus>[
    RELATION_ACCEPT,
    RELATION_REJECT,
    RELATION_PENDING,
    RELATION_CANCEL,
  ];

  static final $core.List<RelationshipStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static RelationshipStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const RelationshipStatus._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
