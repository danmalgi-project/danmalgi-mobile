// This is a generated file - do not edit.
//
// Generated from internalpb/internal_chat.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class GetDevicesRequest extends $pb.GeneratedMessage {
  factory GetDevicesRequest({
    $core.Iterable<$core.String>? deviceIds,
  }) {
    final result = create();
    if (deviceIds != null) result.deviceIds.addAll(deviceIds);
    return result;
  }

  GetDevicesRequest._();

  factory GetDevicesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetDevicesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetDevicesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'internalpb'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'deviceIds')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDevicesRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDevicesRequest copyWith(void Function(GetDevicesRequest) updates) =>
      super.copyWith((message) => updates(message as GetDevicesRequest))
          as GetDevicesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetDevicesRequest create() => GetDevicesRequest._();
  @$core.override
  GetDevicesRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetDevicesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetDevicesRequest>(create);
  static GetDevicesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get deviceIds => $_getList(0);
}

class GetDevicesResponse extends $pb.GeneratedMessage {
  factory GetDevicesResponse({
    $core.Iterable<Device>? devices,
  }) {
    final result = create();
    if (devices != null) result.devices.addAll(devices);
    return result;
  }

  GetDevicesResponse._();

  factory GetDevicesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetDevicesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetDevicesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'internalpb'),
      createEmptyInstance: create)
    ..pPM<Device>(1, _omitFieldNames ? '' : 'devices',
        subBuilder: Device.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDevicesResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDevicesResponse copyWith(void Function(GetDevicesResponse) updates) =>
      super.copyWith((message) => updates(message as GetDevicesResponse))
          as GetDevicesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetDevicesResponse create() => GetDevicesResponse._();
  @$core.override
  GetDevicesResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetDevicesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetDevicesResponse>(create);
  static GetDevicesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Device> get devices => $_getList(0);
}

class GetChannelDevicesRequest extends $pb.GeneratedMessage {
  factory GetChannelDevicesRequest({
    $fixnum.Int64? channelId,
  }) {
    final result = create();
    if (channelId != null) result.channelId = channelId;
    return result;
  }

  GetChannelDevicesRequest._();

  factory GetChannelDevicesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetChannelDevicesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetChannelDevicesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'internalpb'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'channelId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetChannelDevicesRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetChannelDevicesRequest copyWith(
          void Function(GetChannelDevicesRequest) updates) =>
      super.copyWith((message) => updates(message as GetChannelDevicesRequest))
          as GetChannelDevicesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetChannelDevicesRequest create() => GetChannelDevicesRequest._();
  @$core.override
  GetChannelDevicesRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetChannelDevicesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetChannelDevicesRequest>(create);
  static GetChannelDevicesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get channelId => $_getI64(0);
  @$pb.TagNumber(1)
  set channelId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChannelId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannelId() => $_clearField(1);
}

class GetChannelDevicesResponse extends $pb.GeneratedMessage {
  factory GetChannelDevicesResponse({
    $core.Iterable<Device>? devices,
  }) {
    final result = create();
    if (devices != null) result.devices.addAll(devices);
    return result;
  }

  GetChannelDevicesResponse._();

  factory GetChannelDevicesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetChannelDevicesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetChannelDevicesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'internalpb'),
      createEmptyInstance: create)
    ..pPM<Device>(1, _omitFieldNames ? '' : 'devices',
        subBuilder: Device.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetChannelDevicesResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetChannelDevicesResponse copyWith(
          void Function(GetChannelDevicesResponse) updates) =>
      super.copyWith((message) => updates(message as GetChannelDevicesResponse))
          as GetChannelDevicesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetChannelDevicesResponse create() => GetChannelDevicesResponse._();
  @$core.override
  GetChannelDevicesResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetChannelDevicesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetChannelDevicesResponse>(create);
  static GetChannelDevicesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Device> get devices => $_getList(0);
}

class GetChannelNamesRequest extends $pb.GeneratedMessage {
  factory GetChannelNamesRequest({
    $fixnum.Int64? channelId,
    $core.Iterable<$fixnum.Int64>? userIds,
  }) {
    final result = create();
    if (channelId != null) result.channelId = channelId;
    if (userIds != null) result.userIds.addAll(userIds);
    return result;
  }

  GetChannelNamesRequest._();

  factory GetChannelNamesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetChannelNamesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetChannelNamesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'internalpb'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'channelId')
    ..p<$fixnum.Int64>(2, _omitFieldNames ? '' : 'userIds', $pb.PbFieldType.K6)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetChannelNamesRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetChannelNamesRequest copyWith(
          void Function(GetChannelNamesRequest) updates) =>
      super.copyWith((message) => updates(message as GetChannelNamesRequest))
          as GetChannelNamesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetChannelNamesRequest create() => GetChannelNamesRequest._();
  @$core.override
  GetChannelNamesRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetChannelNamesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetChannelNamesRequest>(create);
  static GetChannelNamesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get channelId => $_getI64(0);
  @$pb.TagNumber(1)
  set channelId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChannelId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannelId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$fixnum.Int64> get userIds => $_getList(1);
}

class GetChannelNamesResponse extends $pb.GeneratedMessage {
  factory GetChannelNamesResponse({
    $core.Iterable<ChannelName>? channelNames,
  }) {
    final result = create();
    if (channelNames != null) result.channelNames.addAll(channelNames);
    return result;
  }

  GetChannelNamesResponse._();

  factory GetChannelNamesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetChannelNamesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetChannelNamesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'internalpb'),
      createEmptyInstance: create)
    ..pPM<ChannelName>(1, _omitFieldNames ? '' : 'channelNames',
        subBuilder: ChannelName.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetChannelNamesResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetChannelNamesResponse copyWith(
          void Function(GetChannelNamesResponse) updates) =>
      super.copyWith((message) => updates(message as GetChannelNamesResponse))
          as GetChannelNamesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetChannelNamesResponse create() => GetChannelNamesResponse._();
  @$core.override
  GetChannelNamesResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetChannelNamesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetChannelNamesResponse>(create);
  static GetChannelNamesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<ChannelName> get channelNames => $_getList(0);
}

class Device extends $pb.GeneratedMessage {
  factory Device({
    $fixnum.Int64? userId,
    $core.String? deviceId,
    $core.String? fcmToken,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (deviceId != null) result.deviceId = deviceId;
    if (fcmToken != null) result.fcmToken = fcmToken;
    return result;
  }

  Device._();

  factory Device.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Device.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Device',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'internalpb'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'deviceId')
    ..aOS(3, _omitFieldNames ? '' : 'fcmToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Device clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Device copyWith(void Function(Device) updates) =>
      super.copyWith((message) => updates(message as Device)) as Device;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Device create() => Device._();
  @$core.override
  Device createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Device getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Device>(create);
  static Device? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get userId => $_getI64(0);
  @$pb.TagNumber(1)
  set userId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get deviceId => $_getSZ(1);
  @$pb.TagNumber(2)
  set deviceId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDeviceId() => $_has(1);
  @$pb.TagNumber(2)
  void clearDeviceId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get fcmToken => $_getSZ(2);
  @$pb.TagNumber(3)
  set fcmToken($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFcmToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearFcmToken() => $_clearField(3);
}

class ChannelName extends $pb.GeneratedMessage {
  factory ChannelName({
    $fixnum.Int64? userId,
    $core.String? channelName,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (channelName != null) result.channelName = channelName;
    return result;
  }

  ChannelName._();

  factory ChannelName.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChannelName.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChannelName',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'internalpb'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'channelName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChannelName clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChannelName copyWith(void Function(ChannelName) updates) =>
      super.copyWith((message) => updates(message as ChannelName))
          as ChannelName;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChannelName create() => ChannelName._();
  @$core.override
  ChannelName createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChannelName getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChannelName>(create);
  static ChannelName? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get userId => $_getI64(0);
  @$pb.TagNumber(1)
  set userId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get channelName => $_getSZ(1);
  @$pb.TagNumber(2)
  set channelName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasChannelName() => $_has(1);
  @$pb.TagNumber(2)
  void clearChannelName() => $_clearField(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
