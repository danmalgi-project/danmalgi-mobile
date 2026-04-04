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

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../user/v1/user.pb.dart' as $2;
import 'relationship.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'relationship.pbenum.dart';

/// Request, Resposne Messages
/// GetOutgoingRelationshipList
class GetOutgoingRelationshipListResponse extends $pb.GeneratedMessage {
  factory GetOutgoingRelationshipListResponse({
    $core.Iterable<Relationship>? relationships,
  }) {
    final result = create();
    if (relationships != null) result.relationships.addAll(relationships);
    return result;
  }

  GetOutgoingRelationshipListResponse._();

  factory GetOutgoingRelationshipListResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetOutgoingRelationshipListResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetOutgoingRelationshipListResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'relationship.v1'),
      createEmptyInstance: create)
    ..pPM<Relationship>(1, _omitFieldNames ? '' : 'relationships',
        subBuilder: Relationship.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOutgoingRelationshipListResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOutgoingRelationshipListResponse copyWith(
          void Function(GetOutgoingRelationshipListResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetOutgoingRelationshipListResponse))
          as GetOutgoingRelationshipListResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOutgoingRelationshipListResponse create() =>
      GetOutgoingRelationshipListResponse._();
  @$core.override
  GetOutgoingRelationshipListResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetOutgoingRelationshipListResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetOutgoingRelationshipListResponse>(create);
  static GetOutgoingRelationshipListResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Relationship> get relationships => $_getList(0);
}

/// GetIncomingRelationshipList
class GetIncomingRelationshipListResponse extends $pb.GeneratedMessage {
  factory GetIncomingRelationshipListResponse({
    $core.Iterable<Relationship>? relationships,
  }) {
    final result = create();
    if (relationships != null) result.relationships.addAll(relationships);
    return result;
  }

  GetIncomingRelationshipListResponse._();

  factory GetIncomingRelationshipListResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetIncomingRelationshipListResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetIncomingRelationshipListResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'relationship.v1'),
      createEmptyInstance: create)
    ..pPM<Relationship>(1, _omitFieldNames ? '' : 'relationships',
        subBuilder: Relationship.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetIncomingRelationshipListResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetIncomingRelationshipListResponse copyWith(
          void Function(GetIncomingRelationshipListResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetIncomingRelationshipListResponse))
          as GetIncomingRelationshipListResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetIncomingRelationshipListResponse create() =>
      GetIncomingRelationshipListResponse._();
  @$core.override
  GetIncomingRelationshipListResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetIncomingRelationshipListResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetIncomingRelationshipListResponse>(create);
  static GetIncomingRelationshipListResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Relationship> get relationships => $_getList(0);
}

/// AddRelationship
class AddRelationshipRequest extends $pb.GeneratedMessage {
  factory AddRelationshipRequest({
    $core.String? name,
    $core.String? tag,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (tag != null) result.tag = tag;
    return result;
  }

  AddRelationshipRequest._();

  factory AddRelationshipRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AddRelationshipRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddRelationshipRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'relationship.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'tag')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddRelationshipRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddRelationshipRequest copyWith(
          void Function(AddRelationshipRequest) updates) =>
      super.copyWith((message) => updates(message as AddRelationshipRequest))
          as AddRelationshipRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddRelationshipRequest create() => AddRelationshipRequest._();
  @$core.override
  AddRelationshipRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AddRelationshipRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddRelationshipRequest>(create);
  static AddRelationshipRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get tag => $_getSZ(1);
  @$pb.TagNumber(2)
  set tag($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTag() => $_has(1);
  @$pb.TagNumber(2)
  void clearTag() => $_clearField(2);
}

class AddRelationshipResponse extends $pb.GeneratedMessage {
  factory AddRelationshipResponse({
    $core.Iterable<Relationship>? relationships,
  }) {
    final result = create();
    if (relationships != null) result.relationships.addAll(relationships);
    return result;
  }

  AddRelationshipResponse._();

  factory AddRelationshipResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AddRelationshipResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddRelationshipResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'relationship.v1'),
      createEmptyInstance: create)
    ..pPM<Relationship>(1, _omitFieldNames ? '' : 'relationships',
        subBuilder: Relationship.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddRelationshipResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddRelationshipResponse copyWith(
          void Function(AddRelationshipResponse) updates) =>
      super.copyWith((message) => updates(message as AddRelationshipResponse))
          as AddRelationshipResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddRelationshipResponse create() => AddRelationshipResponse._();
  @$core.override
  AddRelationshipResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AddRelationshipResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddRelationshipResponse>(create);
  static AddRelationshipResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Relationship> get relationships => $_getList(0);
}

/// UpdateIncomingRelationshipStatus
class UpdateIncomingRelationshipStatusRequest extends $pb.GeneratedMessage {
  factory UpdateIncomingRelationshipStatusRequest({
    $fixnum.Int64? relationshipId,
    RelationshipStatus? relationshipStatus,
  }) {
    final result = create();
    if (relationshipId != null) result.relationshipId = relationshipId;
    if (relationshipStatus != null)
      result.relationshipStatus = relationshipStatus;
    return result;
  }

  UpdateIncomingRelationshipStatusRequest._();

  factory UpdateIncomingRelationshipStatusRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateIncomingRelationshipStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateIncomingRelationshipStatusRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'relationship.v1'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'relationshipId')
    ..aE<RelationshipStatus>(2, _omitFieldNames ? '' : 'relationshipStatus',
        enumValues: RelationshipStatus.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateIncomingRelationshipStatusRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateIncomingRelationshipStatusRequest copyWith(
          void Function(UpdateIncomingRelationshipStatusRequest) updates) =>
      super.copyWith((message) =>
              updates(message as UpdateIncomingRelationshipStatusRequest))
          as UpdateIncomingRelationshipStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateIncomingRelationshipStatusRequest create() =>
      UpdateIncomingRelationshipStatusRequest._();
  @$core.override
  UpdateIncomingRelationshipStatusRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateIncomingRelationshipStatusRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          UpdateIncomingRelationshipStatusRequest>(create);
  static UpdateIncomingRelationshipStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get relationshipId => $_getI64(0);
  @$pb.TagNumber(1)
  set relationshipId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRelationshipId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRelationshipId() => $_clearField(1);

  @$pb.TagNumber(2)
  RelationshipStatus get relationshipStatus => $_getN(1);
  @$pb.TagNumber(2)
  set relationshipStatus(RelationshipStatus value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasRelationshipStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearRelationshipStatus() => $_clearField(2);
}

class UpdateIncomingRelationshipStatusResponse extends $pb.GeneratedMessage {
  factory UpdateIncomingRelationshipStatusResponse({
    $core.Iterable<Relationship>? relationships,
  }) {
    final result = create();
    if (relationships != null) result.relationships.addAll(relationships);
    return result;
  }

  UpdateIncomingRelationshipStatusResponse._();

  factory UpdateIncomingRelationshipStatusResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateIncomingRelationshipStatusResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateIncomingRelationshipStatusResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'relationship.v1'),
      createEmptyInstance: create)
    ..pPM<Relationship>(1, _omitFieldNames ? '' : 'relationships',
        subBuilder: Relationship.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateIncomingRelationshipStatusResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateIncomingRelationshipStatusResponse copyWith(
          void Function(UpdateIncomingRelationshipStatusResponse) updates) =>
      super.copyWith((message) =>
              updates(message as UpdateIncomingRelationshipStatusResponse))
          as UpdateIncomingRelationshipStatusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateIncomingRelationshipStatusResponse create() =>
      UpdateIncomingRelationshipStatusResponse._();
  @$core.override
  UpdateIncomingRelationshipStatusResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateIncomingRelationshipStatusResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          UpdateIncomingRelationshipStatusResponse>(create);
  static UpdateIncomingRelationshipStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Relationship> get relationships => $_getList(0);
}

/// UpdateOutgoingRelationshipStatus
class UpdateOutgoingRelationshipStatusRequest extends $pb.GeneratedMessage {
  factory UpdateOutgoingRelationshipStatusRequest({
    $fixnum.Int64? relationshipId,
    RelationshipStatus? relationshipStatus,
  }) {
    final result = create();
    if (relationshipId != null) result.relationshipId = relationshipId;
    if (relationshipStatus != null)
      result.relationshipStatus = relationshipStatus;
    return result;
  }

  UpdateOutgoingRelationshipStatusRequest._();

  factory UpdateOutgoingRelationshipStatusRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateOutgoingRelationshipStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateOutgoingRelationshipStatusRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'relationship.v1'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'relationshipId')
    ..aE<RelationshipStatus>(2, _omitFieldNames ? '' : 'relationshipStatus',
        enumValues: RelationshipStatus.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateOutgoingRelationshipStatusRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateOutgoingRelationshipStatusRequest copyWith(
          void Function(UpdateOutgoingRelationshipStatusRequest) updates) =>
      super.copyWith((message) =>
              updates(message as UpdateOutgoingRelationshipStatusRequest))
          as UpdateOutgoingRelationshipStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateOutgoingRelationshipStatusRequest create() =>
      UpdateOutgoingRelationshipStatusRequest._();
  @$core.override
  UpdateOutgoingRelationshipStatusRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateOutgoingRelationshipStatusRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          UpdateOutgoingRelationshipStatusRequest>(create);
  static UpdateOutgoingRelationshipStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get relationshipId => $_getI64(0);
  @$pb.TagNumber(1)
  set relationshipId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRelationshipId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRelationshipId() => $_clearField(1);

  @$pb.TagNumber(2)
  RelationshipStatus get relationshipStatus => $_getN(1);
  @$pb.TagNumber(2)
  set relationshipStatus(RelationshipStatus value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasRelationshipStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearRelationshipStatus() => $_clearField(2);
}

class UpdateOutgoingRelationshipStatusResponse extends $pb.GeneratedMessage {
  factory UpdateOutgoingRelationshipStatusResponse({
    $core.Iterable<Relationship>? relationships,
  }) {
    final result = create();
    if (relationships != null) result.relationships.addAll(relationships);
    return result;
  }

  UpdateOutgoingRelationshipStatusResponse._();

  factory UpdateOutgoingRelationshipStatusResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateOutgoingRelationshipStatusResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateOutgoingRelationshipStatusResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'relationship.v1'),
      createEmptyInstance: create)
    ..pPM<Relationship>(1, _omitFieldNames ? '' : 'relationships',
        subBuilder: Relationship.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateOutgoingRelationshipStatusResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateOutgoingRelationshipStatusResponse copyWith(
          void Function(UpdateOutgoingRelationshipStatusResponse) updates) =>
      super.copyWith((message) =>
              updates(message as UpdateOutgoingRelationshipStatusResponse))
          as UpdateOutgoingRelationshipStatusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateOutgoingRelationshipStatusResponse create() =>
      UpdateOutgoingRelationshipStatusResponse._();
  @$core.override
  UpdateOutgoingRelationshipStatusResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateOutgoingRelationshipStatusResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          UpdateOutgoingRelationshipStatusResponse>(create);
  static UpdateOutgoingRelationshipStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Relationship> get relationships => $_getList(0);
}

class Relationship extends $pb.GeneratedMessage {
  factory Relationship({
    $fixnum.Int64? relationshipId,
    $2.User? user,
    RelationshipStatus? relationshipStatus,
  }) {
    final result = create();
    if (relationshipId != null) result.relationshipId = relationshipId;
    if (user != null) result.user = user;
    if (relationshipStatus != null)
      result.relationshipStatus = relationshipStatus;
    return result;
  }

  Relationship._();

  factory Relationship.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Relationship.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Relationship',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'relationship.v1'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'relationshipId')
    ..aOM<$2.User>(2, _omitFieldNames ? '' : 'user', subBuilder: $2.User.create)
    ..aE<RelationshipStatus>(3, _omitFieldNames ? '' : 'relationshipStatus',
        enumValues: RelationshipStatus.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Relationship clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Relationship copyWith(void Function(Relationship) updates) =>
      super.copyWith((message) => updates(message as Relationship))
          as Relationship;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Relationship create() => Relationship._();
  @$core.override
  Relationship createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Relationship getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Relationship>(create);
  static Relationship? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get relationshipId => $_getI64(0);
  @$pb.TagNumber(1)
  set relationshipId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRelationshipId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRelationshipId() => $_clearField(1);

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
  RelationshipStatus get relationshipStatus => $_getN(2);
  @$pb.TagNumber(3)
  set relationshipStatus(RelationshipStatus value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasRelationshipStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearRelationshipStatus() => $_clearField(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
