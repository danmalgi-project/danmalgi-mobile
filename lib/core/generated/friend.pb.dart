// This is a generated file - do not edit.
//
// Generated from friend.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'friend.pbenum.dart';
import 'user.pb.dart' as $2;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'friend.pbenum.dart';

/// Request, Resposne Messages
/// GetFriendList
class GetFriendListResponse extends $pb.GeneratedMessage {
  factory GetFriendListResponse({
    $core.Iterable<Friend>? friends,
  }) {
    final result = create();
    if (friends != null) result.friends.addAll(friends);
    return result;
  }

  GetFriendListResponse._();

  factory GetFriendListResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetFriendListResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetFriendListResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pPM<Friend>(1, _omitFieldNames ? '' : 'friends',
        subBuilder: Friend.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFriendListResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFriendListResponse copyWith(
          void Function(GetFriendListResponse) updates) =>
      super.copyWith((message) => updates(message as GetFriendListResponse))
          as GetFriendListResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFriendListResponse create() => GetFriendListResponse._();
  @$core.override
  GetFriendListResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetFriendListResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFriendListResponse>(create);
  static GetFriendListResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Friend> get friends => $_getList(0);
}

/// UpdateFriendStatus
class UpdateFriendStatusRequest extends $pb.GeneratedMessage {
  factory UpdateFriendStatusRequest({
    $fixnum.Int64? friendshipId,
    FriendStatus? friendStatus,
  }) {
    final result = create();
    if (friendshipId != null) result.friendshipId = friendshipId;
    if (friendStatus != null) result.friendStatus = friendStatus;
    return result;
  }

  UpdateFriendStatusRequest._();

  factory UpdateFriendStatusRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateFriendStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateFriendStatusRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'friendshipId')
    ..aE<FriendStatus>(2, _omitFieldNames ? '' : 'friendStatus',
        enumValues: FriendStatus.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateFriendStatusRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateFriendStatusRequest copyWith(
          void Function(UpdateFriendStatusRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateFriendStatusRequest))
          as UpdateFriendStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateFriendStatusRequest create() => UpdateFriendStatusRequest._();
  @$core.override
  UpdateFriendStatusRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateFriendStatusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateFriendStatusRequest>(create);
  static UpdateFriendStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get friendshipId => $_getI64(0);
  @$pb.TagNumber(1)
  set friendshipId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFriendshipId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFriendshipId() => $_clearField(1);

  @$pb.TagNumber(2)
  FriendStatus get friendStatus => $_getN(1);
  @$pb.TagNumber(2)
  set friendStatus(FriendStatus value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasFriendStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearFriendStatus() => $_clearField(2);
}

class UpdateFriendStatusResponse extends $pb.GeneratedMessage {
  factory UpdateFriendStatusResponse({
    $core.Iterable<Friend>? friends,
  }) {
    final result = create();
    if (friends != null) result.friends.addAll(friends);
    return result;
  }

  UpdateFriendStatusResponse._();

  factory UpdateFriendStatusResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateFriendStatusResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateFriendStatusResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pPM<Friend>(1, _omitFieldNames ? '' : 'friends',
        subBuilder: Friend.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateFriendStatusResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateFriendStatusResponse copyWith(
          void Function(UpdateFriendStatusResponse) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateFriendStatusResponse))
          as UpdateFriendStatusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateFriendStatusResponse create() => UpdateFriendStatusResponse._();
  @$core.override
  UpdateFriendStatusResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateFriendStatusResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateFriendStatusResponse>(create);
  static UpdateFriendStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Friend> get friends => $_getList(0);
}

/// Resource Messages
class Friend extends $pb.GeneratedMessage {
  factory Friend({
    $fixnum.Int64? id,
    $2.User? user,
    FriendStatus? status,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (user != null) result.user = user;
    if (status != null) result.status = status;
    return result;
  }

  Friend._();

  factory Friend.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Friend.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Friend',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'id')
    ..aOM<$2.User>(2, _omitFieldNames ? '' : 'user', subBuilder: $2.User.create)
    ..aE<FriendStatus>(3, _omitFieldNames ? '' : 'status',
        enumValues: FriendStatus.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Friend clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Friend copyWith(void Function(Friend) updates) =>
      super.copyWith((message) => updates(message as Friend)) as Friend;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Friend create() => Friend._();
  @$core.override
  Friend createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Friend getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Friend>(create);
  static Friend? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $2.User get user => $_getN(1);
  @$pb.TagNumber(2)
  set user($2.User value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasUser() => $_has(1);
  @$pb.TagNumber(2)
  void clearUser() => $_clearField(2);
  @$pb.TagNumber(2)
  $2.User ensureUser() => $_ensure(1);

  @$pb.TagNumber(3)
  FriendStatus get status => $_getN(2);
  @$pb.TagNumber(3)
  set status(FriendStatus value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => $_clearField(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
