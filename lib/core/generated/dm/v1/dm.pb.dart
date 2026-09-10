// This is a generated file - do not edit.
//
// Generated from dm/v1/dm.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart'
    as $3;

import '../../user/v1/user.pb.dart' as $2;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// GetDirectMessageList
class GetDirectMessageChannelListResponse extends $pb.GeneratedMessage {
  factory GetDirectMessageChannelListResponse({
    $core.Iterable<DirectMessageChannelListItem>? items,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'dm.v1'),
      createEmptyInstance: create)
    ..pPM<DirectMessageChannelListItem>(1, _omitFieldNames ? '' : 'items',
        subBuilder: DirectMessageChannelListItem.create)
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
  $pb.PbList<DirectMessageChannelListItem> get items => $_getList(0);
}

/// 채널 목록 아이템. last_message 는 목록 응답에서만 제공된다.
class DirectMessageChannelListItem extends $pb.GeneratedMessage {
  factory DirectMessageChannelListItem({
    DirectMessageChannel? channel,
    LastMessage? lastMessage,
  }) {
    final result = create();
    if (channel != null) result.channel = channel;
    if (lastMessage != null) result.lastMessage = lastMessage;
    return result;
  }

  DirectMessageChannelListItem._();

  factory DirectMessageChannelListItem.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DirectMessageChannelListItem.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DirectMessageChannelListItem',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'dm.v1'),
      createEmptyInstance: create)
    ..aOM<DirectMessageChannel>(1, _omitFieldNames ? '' : 'channel',
        subBuilder: DirectMessageChannel.create)
    ..aOM<LastMessage>(2, _omitFieldNames ? '' : 'lastMessage',
        subBuilder: LastMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DirectMessageChannelListItem clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DirectMessageChannelListItem copyWith(
          void Function(DirectMessageChannelListItem) updates) =>
      super.copyWith(
              (message) => updates(message as DirectMessageChannelListItem))
          as DirectMessageChannelListItem;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DirectMessageChannelListItem create() =>
      DirectMessageChannelListItem._();
  @$core.override
  DirectMessageChannelListItem createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DirectMessageChannelListItem getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DirectMessageChannelListItem>(create);
  static DirectMessageChannelListItem? _defaultInstance;

  @$pb.TagNumber(1)
  DirectMessageChannel get channel => $_getN(0);
  @$pb.TagNumber(1)
  set channel(DirectMessageChannel value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasChannel() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannel() => $_clearField(1);
  @$pb.TagNumber(1)
  DirectMessageChannel ensureChannel() => $_ensure(0);

  @$pb.TagNumber(2)
  LastMessage get lastMessage => $_getN(1);
  @$pb.TagNumber(2)
  set lastMessage(LastMessage value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasLastMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearLastMessage() => $_clearField(2);
  @$pb.TagNumber(2)
  LastMessage ensureLastMessage() => $_ensure(1);
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'dm.v1'),
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'dm.v1'),
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

/// UploadChannelImage
class UploadChannelImageRequest extends $pb.GeneratedMessage {
  factory UploadChannelImageRequest({
    $fixnum.Int64? dmId,
    $core.List<$core.int>? image,
    $core.String? extension_3,
  }) {
    final result = create();
    if (dmId != null) result.dmId = dmId;
    if (image != null) result.image = image;
    if (extension_3 != null) result.extension_3 = extension_3;
    return result;
  }

  UploadChannelImageRequest._();

  factory UploadChannelImageRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UploadChannelImageRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UploadChannelImageRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'dm.v1'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'dmId')
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'image', $pb.PbFieldType.OY)
    ..aOS(3, _omitFieldNames ? '' : 'extension')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadChannelImageRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadChannelImageRequest copyWith(
          void Function(UploadChannelImageRequest) updates) =>
      super.copyWith((message) => updates(message as UploadChannelImageRequest))
          as UploadChannelImageRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UploadChannelImageRequest create() => UploadChannelImageRequest._();
  @$core.override
  UploadChannelImageRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UploadChannelImageRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UploadChannelImageRequest>(create);
  static UploadChannelImageRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get dmId => $_getI64(0);
  @$pb.TagNumber(1)
  set dmId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDmId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDmId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get image => $_getN(1);
  @$pb.TagNumber(2)
  set image($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasImage() => $_has(1);
  @$pb.TagNumber(2)
  void clearImage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get extension_3 => $_getSZ(2);
  @$pb.TagNumber(3)
  set extension_3($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasExtension_3() => $_has(2);
  @$pb.TagNumber(3)
  void clearExtension_3() => $_clearField(3);
}

class UploadChannelImageResponse extends $pb.GeneratedMessage {
  factory UploadChannelImageResponse({
    DirectMessageChannel? directMessageChannel,
  }) {
    final result = create();
    if (directMessageChannel != null)
      result.directMessageChannel = directMessageChannel;
    return result;
  }

  UploadChannelImageResponse._();

  factory UploadChannelImageResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UploadChannelImageResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UploadChannelImageResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'dm.v1'),
      createEmptyInstance: create)
    ..aOM<DirectMessageChannel>(
        1, _omitFieldNames ? '' : 'directMessageChannel',
        subBuilder: DirectMessageChannel.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadChannelImageResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadChannelImageResponse copyWith(
          void Function(UploadChannelImageResponse) updates) =>
      super.copyWith(
              (message) => updates(message as UploadChannelImageResponse))
          as UploadChannelImageResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UploadChannelImageResponse create() => UploadChannelImageResponse._();
  @$core.override
  UploadChannelImageResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UploadChannelImageResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UploadChannelImageResponse>(create);
  static UploadChannelImageResponse? _defaultInstance;

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

/// UpdateDirectMessageChannel
class UpdateDirectMessageChannelRequest extends $pb.GeneratedMessage {
  factory UpdateDirectMessageChannelRequest({
    $fixnum.Int64? dmId,
    $core.String? channelName,
    $core.List<$core.int>? image,
    $core.String? extension_4,
  }) {
    final result = create();
    if (dmId != null) result.dmId = dmId;
    if (channelName != null) result.channelName = channelName;
    if (image != null) result.image = image;
    if (extension_4 != null) result.extension_4 = extension_4;
    return result;
  }

  UpdateDirectMessageChannelRequest._();

  factory UpdateDirectMessageChannelRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateDirectMessageChannelRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateDirectMessageChannelRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'dm.v1'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'dmId')
    ..aOS(2, _omitFieldNames ? '' : 'channelName')
    ..a<$core.List<$core.int>>(
        3, _omitFieldNames ? '' : 'image', $pb.PbFieldType.OY)
    ..aOS(4, _omitFieldNames ? '' : 'extension')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateDirectMessageChannelRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateDirectMessageChannelRequest copyWith(
          void Function(UpdateDirectMessageChannelRequest) updates) =>
      super.copyWith((message) =>
              updates(message as UpdateDirectMessageChannelRequest))
          as UpdateDirectMessageChannelRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateDirectMessageChannelRequest create() =>
      UpdateDirectMessageChannelRequest._();
  @$core.override
  UpdateDirectMessageChannelRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateDirectMessageChannelRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateDirectMessageChannelRequest>(
          create);
  static UpdateDirectMessageChannelRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get dmId => $_getI64(0);
  @$pb.TagNumber(1)
  set dmId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDmId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDmId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get channelName => $_getSZ(1);
  @$pb.TagNumber(2)
  set channelName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasChannelName() => $_has(1);
  @$pb.TagNumber(2)
  void clearChannelName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get image => $_getN(2);
  @$pb.TagNumber(3)
  set image($core.List<$core.int> value) => $_setBytes(2, value);
  @$pb.TagNumber(3)
  $core.bool hasImage() => $_has(2);
  @$pb.TagNumber(3)
  void clearImage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get extension_4 => $_getSZ(3);
  @$pb.TagNumber(4)
  set extension_4($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasExtension_4() => $_has(3);
  @$pb.TagNumber(4)
  void clearExtension_4() => $_clearField(4);
}

class UpdateDirectMessageChannelResponse extends $pb.GeneratedMessage {
  factory UpdateDirectMessageChannelResponse({
    DirectMessageChannel? directMessageChannel,
  }) {
    final result = create();
    if (directMessageChannel != null)
      result.directMessageChannel = directMessageChannel;
    return result;
  }

  UpdateDirectMessageChannelResponse._();

  factory UpdateDirectMessageChannelResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateDirectMessageChannelResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateDirectMessageChannelResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'dm.v1'),
      createEmptyInstance: create)
    ..aOM<DirectMessageChannel>(
        1, _omitFieldNames ? '' : 'directMessageChannel',
        subBuilder: DirectMessageChannel.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateDirectMessageChannelResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateDirectMessageChannelResponse copyWith(
          void Function(UpdateDirectMessageChannelResponse) updates) =>
      super.copyWith((message) =>
              updates(message as UpdateDirectMessageChannelResponse))
          as UpdateDirectMessageChannelResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateDirectMessageChannelResponse create() =>
      UpdateDirectMessageChannelResponse._();
  @$core.override
  UpdateDirectMessageChannelResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateDirectMessageChannelResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateDirectMessageChannelResponse>(
          create);
  static UpdateDirectMessageChannelResponse? _defaultInstance;

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

/// LeaveDirectMessageChannel
class LeaveDirectMessageChannelRequest extends $pb.GeneratedMessage {
  factory LeaveDirectMessageChannelRequest({
    $fixnum.Int64? dmId,
  }) {
    final result = create();
    if (dmId != null) result.dmId = dmId;
    return result;
  }

  LeaveDirectMessageChannelRequest._();

  factory LeaveDirectMessageChannelRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LeaveDirectMessageChannelRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LeaveDirectMessageChannelRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'dm.v1'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'dmId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LeaveDirectMessageChannelRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LeaveDirectMessageChannelRequest copyWith(
          void Function(LeaveDirectMessageChannelRequest) updates) =>
      super.copyWith(
              (message) => updates(message as LeaveDirectMessageChannelRequest))
          as LeaveDirectMessageChannelRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LeaveDirectMessageChannelRequest create() =>
      LeaveDirectMessageChannelRequest._();
  @$core.override
  LeaveDirectMessageChannelRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static LeaveDirectMessageChannelRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LeaveDirectMessageChannelRequest>(
          create);
  static LeaveDirectMessageChannelRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get dmId => $_getI64(0);
  @$pb.TagNumber(1)
  set dmId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDmId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDmId() => $_clearField(1);
}

/// model
class DirectMessageChannel extends $pb.GeneratedMessage {
  factory DirectMessageChannel({
    $fixnum.Int64? dmId,
    $core.Iterable<$2.User>? users,
    $core.String? channelName,
    $core.bool? isGroup,
    $core.String? channelImageUrl,
  }) {
    final result = create();
    if (dmId != null) result.dmId = dmId;
    if (users != null) result.users.addAll(users);
    if (channelName != null) result.channelName = channelName;
    if (isGroup != null) result.isGroup = isGroup;
    if (channelImageUrl != null) result.channelImageUrl = channelImageUrl;
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'dm.v1'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'dmId')
    ..pPM<$2.User>(2, _omitFieldNames ? '' : 'users',
        subBuilder: $2.User.create)
    ..aOS(3, _omitFieldNames ? '' : 'channelName')
    ..aOB(4, _omitFieldNames ? '' : 'isGroup')
    ..aOS(5, _omitFieldNames ? '' : 'channelImageUrl')
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

  @$pb.TagNumber(4)
  $core.bool get isGroup => $_getBF(3);
  @$pb.TagNumber(4)
  set isGroup($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasIsGroup() => $_has(3);
  @$pb.TagNumber(4)
  void clearIsGroup() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get channelImageUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set channelImageUrl($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasChannelImageUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearChannelImageUrl() => $_clearField(5);
}

/// 채널의 마지막 메시지. 메시지는 chat-server 소유이며 백엔드가 배치 조회해 채운다.
class LastMessage extends $pb.GeneratedMessage {
  factory LastMessage({
    $fixnum.Int64? messageId,
    $core.String? content,
    $fixnum.Int64? senderId,
    $3.Timestamp? createdAt,
  }) {
    final result = create();
    if (messageId != null) result.messageId = messageId;
    if (content != null) result.content = content;
    if (senderId != null) result.senderId = senderId;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  LastMessage._();

  factory LastMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LastMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LastMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'dm.v1'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'messageId')
    ..aOS(2, _omitFieldNames ? '' : 'content')
    ..aInt64(3, _omitFieldNames ? '' : 'senderId')
    ..aOM<$3.Timestamp>(4, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $3.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LastMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LastMessage copyWith(void Function(LastMessage) updates) =>
      super.copyWith((message) => updates(message as LastMessage))
          as LastMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LastMessage create() => LastMessage._();
  @$core.override
  LastMessage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static LastMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LastMessage>(create);
  static LastMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get messageId => $_getI64(0);
  @$pb.TagNumber(1)
  set messageId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMessageId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessageId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get content => $_getSZ(1);
  @$pb.TagNumber(2)
  set content($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasContent() => $_has(1);
  @$pb.TagNumber(2)
  void clearContent() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get senderId => $_getI64(2);
  @$pb.TagNumber(3)
  set senderId($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSenderId() => $_has(2);
  @$pb.TagNumber(3)
  void clearSenderId() => $_clearField(3);

  @$pb.TagNumber(4)
  $3.Timestamp get createdAt => $_getN(3);
  @$pb.TagNumber(4)
  set createdAt($3.Timestamp value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasCreatedAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearCreatedAt() => $_clearField(4);
  @$pb.TagNumber(4)
  $3.Timestamp ensureCreatedAt() => $_ensure(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
