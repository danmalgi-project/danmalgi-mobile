// This is a generated file - do not edit.
//
// Generated from direct_message.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'user.pb.dart' as $2;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// GetDirectMessageList
class GetDirectMessageChannelListResponse extends $pb.GeneratedMessage {
  factory GetDirectMessageChannelListResponse({
    $core.Iterable<DirectMessageChannel>? directMessageChannels,
  }) {
    final result = create();
    if (directMessageChannels != null)
      result.directMessageChannels.addAll(directMessageChannels);
    return result;
  }

  GetDirectMessageChannelListResponse._();

  factory GetDirectMessageChannelListResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetDirectMessageChannelListResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetDirectMessageChannelListResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pPM<DirectMessageChannel>(
        1, _omitFieldNames ? '' : 'directMessageChannels',
        subBuilder: DirectMessageChannel.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDirectMessageChannelListResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDirectMessageChannelListResponse copyWith(
          void Function(GetDirectMessageChannelListResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetDirectMessageChannelListResponse))
          as GetDirectMessageChannelListResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetDirectMessageChannelListResponse create() =>
      GetDirectMessageChannelListResponse._();
  @$core.override
  GetDirectMessageChannelListResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetDirectMessageChannelListResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetDirectMessageChannelListResponse>(create);
  static GetDirectMessageChannelListResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<DirectMessageChannel> get directMessageChannels => $_getList(0);
}

/// CreateDirectMessage
class CreateDirectMessageChannelRequest extends $pb.GeneratedMessage {
  factory CreateDirectMessageChannelRequest({
    $core.Iterable<$fixnum.Int64>? friendIds,
  }) {
    final result = create();
    if (friendIds != null) result.friendIds.addAll(friendIds);
    return result;
  }

  CreateDirectMessageChannelRequest._();

  factory CreateDirectMessageChannelRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateDirectMessageChannelRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateDirectMessageChannelRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..p<$fixnum.Int64>(
        1, _omitFieldNames ? '' : 'friendIds', $pb.PbFieldType.K6)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateDirectMessageChannelRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateDirectMessageChannelRequest copyWith(
          void Function(CreateDirectMessageChannelRequest) updates) =>
      super.copyWith((message) =>
              updates(message as CreateDirectMessageChannelRequest))
          as CreateDirectMessageChannelRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateDirectMessageChannelRequest create() =>
      CreateDirectMessageChannelRequest._();
  @$core.override
  CreateDirectMessageChannelRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CreateDirectMessageChannelRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateDirectMessageChannelRequest>(
          create);
  static CreateDirectMessageChannelRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$fixnum.Int64> get friendIds => $_getList(0);
}

class CreateDirectMessageChannelResponse extends $pb.GeneratedMessage {
  factory CreateDirectMessageChannelResponse({
    DirectMessageChannel? directMessageChannel,
  }) {
    final result = create();
    if (directMessageChannel != null)
      result.directMessageChannel = directMessageChannel;
    return result;
  }

  CreateDirectMessageChannelResponse._();

  factory CreateDirectMessageChannelResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateDirectMessageChannelResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateDirectMessageChannelResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<DirectMessageChannel>(
        1, _omitFieldNames ? '' : 'directMessageChannel',
        subBuilder: DirectMessageChannel.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateDirectMessageChannelResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateDirectMessageChannelResponse copyWith(
          void Function(CreateDirectMessageChannelResponse) updates) =>
      super.copyWith((message) =>
              updates(message as CreateDirectMessageChannelResponse))
          as CreateDirectMessageChannelResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateDirectMessageChannelResponse create() =>
      CreateDirectMessageChannelResponse._();
  @$core.override
  CreateDirectMessageChannelResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CreateDirectMessageChannelResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateDirectMessageChannelResponse>(
          create);
  static CreateDirectMessageChannelResponse? _defaultInstance;

  @$pb.TagNumber(1)
  DirectMessageChannel get directMessageChannel => $_getN(0);
  @$pb.TagNumber(1)
  set directMessageChannel(DirectMessageChannel value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasDirectMessageChannel() => $_has(0);
  @$pb.TagNumber(1)
  void clearDirectMessageChannel() => $_clearField(1);
  @$pb.TagNumber(1)
  DirectMessageChannel ensureDirectMessageChannel() => $_ensure(0);
}

/// model
class DirectMessageChannel extends $pb.GeneratedMessage {
  factory DirectMessageChannel({
    $fixnum.Int64? dmId,
    $core.Iterable<$2.User>? users,
    $core.String? channelName,
  }) {
    final result = create();
    if (dmId != null) result.dmId = dmId;
    if (users != null) result.users.addAll(users);
    if (channelName != null) result.channelName = channelName;
    return result;
  }

  DirectMessageChannel._();

  factory DirectMessageChannel.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DirectMessageChannel.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DirectMessageChannel',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'dmId')
    ..pPM<$2.User>(2, _omitFieldNames ? '' : 'users',
        subBuilder: $2.User.create)
    ..aOS(3, _omitFieldNames ? '' : 'channelName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DirectMessageChannel clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DirectMessageChannel copyWith(void Function(DirectMessageChannel) updates) =>
      super.copyWith((message) => updates(message as DirectMessageChannel))
          as DirectMessageChannel;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DirectMessageChannel create() => DirectMessageChannel._();
  @$core.override
  DirectMessageChannel createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DirectMessageChannel getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DirectMessageChannel>(create);
  static DirectMessageChannel? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get dmId => $_getI64(0);
  @$pb.TagNumber(1)
  set dmId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDmId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDmId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$2.User> get users => $_getList(1);

  @$pb.TagNumber(3)
  $core.String get channelName => $_getSZ(2);
  @$pb.TagNumber(3)
  set channelName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasChannelName() => $_has(2);
  @$pb.TagNumber(3)
  void clearChannelName() => $_clearField(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
