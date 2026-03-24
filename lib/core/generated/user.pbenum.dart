// This is a generated file - do not edit.
//
// Generated from user.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class UserStatus extends $pb.ProtobufEnum {
  static const UserStatus USER_PENDING =
      UserStatus._(0, _omitEnumNames ? '' : 'USER_PENDING');
  static const UserStatus USER_ACTIVCE =
      UserStatus._(1, _omitEnumNames ? '' : 'USER_ACTIVCE');
  static const UserStatus USER_BLOCKED =
      UserStatus._(2, _omitEnumNames ? '' : 'USER_BLOCKED');
  static const UserStatus USER_WITHDRAWAL =
      UserStatus._(3, _omitEnumNames ? '' : 'USER_WITHDRAWAL');

  static const $core.List<UserStatus> values = <UserStatus>[
    USER_PENDING,
    USER_ACTIVCE,
    USER_BLOCKED,
    USER_WITHDRAWAL,
  ];

  static final $core.List<UserStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static UserStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const UserStatus._(super.value, super.name);
}

class OauthType extends $pb.ProtobufEnum {
  static const OauthType NAVER = OauthType._(0, _omitEnumNames ? '' : 'NAVER');
  static const OauthType GOOGLE =
      OauthType._(1, _omitEnumNames ? '' : 'GOOGLE');
  static const OauthType KAKAO = OauthType._(2, _omitEnumNames ? '' : 'KAKAO');

  static const $core.List<OauthType> values = <OauthType>[
    NAVER,
    GOOGLE,
    KAKAO,
  ];

  static final $core.List<OauthType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static OauthType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const OauthType._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
