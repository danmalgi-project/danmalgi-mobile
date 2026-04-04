// This is a generated file - do not edit.
//
// Generated from signaling/v1/signaling.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../user/v1/user.pb.dart' as $1;
import 'signaling.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'signaling.pbenum.dart';

/// 시그널링 요청
/// Signaling
class SignalingRequest extends $pb.GeneratedMessage {
  factory SignalingRequest({
    SignalingRequestInfo? signalingRequestInfo,
  }) {
    final result = create();
    if (signalingRequestInfo != null)
      result.signalingRequestInfo = signalingRequestInfo;
    return result;
  }

  SignalingRequest._();

  factory SignalingRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SignalingRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SignalingRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'signaling.v1'),
      createEmptyInstance: create)
    ..aOM<SignalingRequestInfo>(
        1, _omitFieldNames ? '' : 'signalingRequestInfo',
        subBuilder: SignalingRequestInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SignalingRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SignalingRequest copyWith(void Function(SignalingRequest) updates) =>
      super.copyWith((message) => updates(message as SignalingRequest))
          as SignalingRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SignalingRequest create() => SignalingRequest._();
  @$core.override
  SignalingRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SignalingRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SignalingRequest>(create);
  static SignalingRequest? _defaultInstance;

  @$pb.TagNumber(1)
  SignalingRequestInfo get signalingRequestInfo => $_getN(0);
  @$pb.TagNumber(1)
  set signalingRequestInfo(SignalingRequestInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSignalingRequestInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearSignalingRequestInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  SignalingRequestInfo ensureSignalingRequestInfo() => $_ensure(0);
}

/// 시그널링 응답
class SignalingResponse extends $pb.GeneratedMessage {
  factory SignalingResponse({
    SignalingResponseInfo? signalingResponseInfo,
  }) {
    final result = create();
    if (signalingResponseInfo != null)
      result.signalingResponseInfo = signalingResponseInfo;
    return result;
  }

  SignalingResponse._();

  factory SignalingResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SignalingResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SignalingResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'signaling.v1'),
      createEmptyInstance: create)
    ..aOM<SignalingResponseInfo>(
        1, _omitFieldNames ? '' : 'signalingResponseInfo',
        subBuilder: SignalingResponseInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SignalingResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SignalingResponse copyWith(void Function(SignalingResponse) updates) =>
      super.copyWith((message) => updates(message as SignalingResponse))
          as SignalingResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SignalingResponse create() => SignalingResponse._();
  @$core.override
  SignalingResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SignalingResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SignalingResponse>(create);
  static SignalingResponse? _defaultInstance;

  @$pb.TagNumber(1)
  SignalingResponseInfo get signalingResponseInfo => $_getN(0);
  @$pb.TagNumber(1)
  set signalingResponseInfo(SignalingResponseInfo value) =>
      $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSignalingResponseInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearSignalingResponseInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  SignalingResponseInfo ensureSignalingResponseInfo() => $_ensure(0);
}

enum SignalingRequestInfo_Message { answer, candidate, notSet }

/// 시그널링 요청 정보
class SignalingRequestInfo extends $pb.GeneratedMessage {
  factory SignalingRequestInfo({
    Answer? answer,
    Candidate? candidate,
  }) {
    final result = create();
    if (answer != null) result.answer = answer;
    if (candidate != null) result.candidate = candidate;
    return result;
  }

  SignalingRequestInfo._();

  factory SignalingRequestInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SignalingRequestInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, SignalingRequestInfo_Message>
      _SignalingRequestInfo_MessageByTag = {
    1: SignalingRequestInfo_Message.answer,
    2: SignalingRequestInfo_Message.candidate,
    0: SignalingRequestInfo_Message.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SignalingRequestInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'signaling.v1'),
      createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<Answer>(1, _omitFieldNames ? '' : 'answer', subBuilder: Answer.create)
    ..aOM<Candidate>(2, _omitFieldNames ? '' : 'candidate',
        subBuilder: Candidate.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SignalingRequestInfo clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SignalingRequestInfo copyWith(void Function(SignalingRequestInfo) updates) =>
      super.copyWith((message) => updates(message as SignalingRequestInfo))
          as SignalingRequestInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SignalingRequestInfo create() => SignalingRequestInfo._();
  @$core.override
  SignalingRequestInfo createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SignalingRequestInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SignalingRequestInfo>(create);
  static SignalingRequestInfo? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  SignalingRequestInfo_Message whichMessage() =>
      _SignalingRequestInfo_MessageByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField($_whichOneof(0));

  /// answer 메시지
  @$pb.TagNumber(1)
  Answer get answer => $_getN(0);
  @$pb.TagNumber(1)
  set answer(Answer value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasAnswer() => $_has(0);
  @$pb.TagNumber(1)
  void clearAnswer() => $_clearField(1);
  @$pb.TagNumber(1)
  Answer ensureAnswer() => $_ensure(0);

  /// candidate 메시지
  @$pb.TagNumber(2)
  Candidate get candidate => $_getN(1);
  @$pb.TagNumber(2)
  set candidate(Candidate value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasCandidate() => $_has(1);
  @$pb.TagNumber(2)
  void clearCandidate() => $_clearField(2);
  @$pb.TagNumber(2)
  Candidate ensureCandidate() => $_ensure(1);
}

enum SignalingResponseInfo_Message { offer, answer, candidate, notSet }

/// 시그널링 응답 정보
class SignalingResponseInfo extends $pb.GeneratedMessage {
  factory SignalingResponseInfo({
    Offer? offer,
    Answer? answer,
    Candidate? candidate,
  }) {
    final result = create();
    if (offer != null) result.offer = offer;
    if (answer != null) result.answer = answer;
    if (candidate != null) result.candidate = candidate;
    return result;
  }

  SignalingResponseInfo._();

  factory SignalingResponseInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SignalingResponseInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, SignalingResponseInfo_Message>
      _SignalingResponseInfo_MessageByTag = {
    1: SignalingResponseInfo_Message.offer,
    2: SignalingResponseInfo_Message.answer,
    3: SignalingResponseInfo_Message.candidate,
    0: SignalingResponseInfo_Message.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SignalingResponseInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'signaling.v1'),
      createEmptyInstance: create)
    ..oo(0, [1, 2, 3])
    ..aOM<Offer>(1, _omitFieldNames ? '' : 'offer', subBuilder: Offer.create)
    ..aOM<Answer>(2, _omitFieldNames ? '' : 'answer', subBuilder: Answer.create)
    ..aOM<Candidate>(3, _omitFieldNames ? '' : 'candidate',
        subBuilder: Candidate.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SignalingResponseInfo clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SignalingResponseInfo copyWith(
          void Function(SignalingResponseInfo) updates) =>
      super.copyWith((message) => updates(message as SignalingResponseInfo))
          as SignalingResponseInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SignalingResponseInfo create() => SignalingResponseInfo._();
  @$core.override
  SignalingResponseInfo createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SignalingResponseInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SignalingResponseInfo>(create);
  static SignalingResponseInfo? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  SignalingResponseInfo_Message whichMessage() =>
      _SignalingResponseInfo_MessageByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField($_whichOneof(0));

  /// offer 메시지
  @$pb.TagNumber(1)
  Offer get offer => $_getN(0);
  @$pb.TagNumber(1)
  set offer(Offer value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasOffer() => $_has(0);
  @$pb.TagNumber(1)
  void clearOffer() => $_clearField(1);
  @$pb.TagNumber(1)
  Offer ensureOffer() => $_ensure(0);

  /// answer 메시지
  @$pb.TagNumber(2)
  Answer get answer => $_getN(1);
  @$pb.TagNumber(2)
  set answer(Answer value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasAnswer() => $_has(1);
  @$pb.TagNumber(2)
  void clearAnswer() => $_clearField(2);
  @$pb.TagNumber(2)
  Answer ensureAnswer() => $_ensure(1);

  /// candidate 메시지
  @$pb.TagNumber(3)
  Candidate get candidate => $_getN(2);
  @$pb.TagNumber(3)
  set candidate(Candidate value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasCandidate() => $_has(2);
  @$pb.TagNumber(3)
  void clearCandidate() => $_clearField(3);
  @$pb.TagNumber(3)
  Candidate ensureCandidate() => $_ensure(2);
}

/// offer 메시지
class Offer extends $pb.GeneratedMessage {
  factory Offer({
    SessionDescription? sdp,
    UserTracks? joinedUserTracks,
  }) {
    final result = create();
    if (sdp != null) result.sdp = sdp;
    if (joinedUserTracks != null) result.joinedUserTracks = joinedUserTracks;
    return result;
  }

  Offer._();

  factory Offer.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Offer.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Offer',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'signaling.v1'),
      createEmptyInstance: create)
    ..aOM<SessionDescription>(1, _omitFieldNames ? '' : 'sdp',
        subBuilder: SessionDescription.create)
    ..aOM<UserTracks>(2, _omitFieldNames ? '' : 'joinedUserTracks',
        subBuilder: UserTracks.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Offer clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Offer copyWith(void Function(Offer) updates) =>
      super.copyWith((message) => updates(message as Offer)) as Offer;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Offer create() => Offer._();
  @$core.override
  Offer createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Offer getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Offer>(create);
  static Offer? _defaultInstance;

  @$pb.TagNumber(1)
  SessionDescription get sdp => $_getN(0);
  @$pb.TagNumber(1)
  set sdp(SessionDescription value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSdp() => $_has(0);
  @$pb.TagNumber(1)
  void clearSdp() => $_clearField(1);
  @$pb.TagNumber(1)
  SessionDescription ensureSdp() => $_ensure(0);

  /// 참여 사용자 트랙 정보
  @$pb.TagNumber(2)
  UserTracks get joinedUserTracks => $_getN(1);
  @$pb.TagNumber(2)
  set joinedUserTracks(UserTracks value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasJoinedUserTracks() => $_has(1);
  @$pb.TagNumber(2)
  void clearJoinedUserTracks() => $_clearField(2);
  @$pb.TagNumber(2)
  UserTracks ensureJoinedUserTracks() => $_ensure(1);
}

/// answer 메시지
class Answer extends $pb.GeneratedMessage {
  factory Answer({
    SessionDescription? sdp,
  }) {
    final result = create();
    if (sdp != null) result.sdp = sdp;
    return result;
  }

  Answer._();

  factory Answer.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Answer.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Answer',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'signaling.v1'),
      createEmptyInstance: create)
    ..aOM<SessionDescription>(1, _omitFieldNames ? '' : 'sdp',
        subBuilder: SessionDescription.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Answer clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Answer copyWith(void Function(Answer) updates) =>
      super.copyWith((message) => updates(message as Answer)) as Answer;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Answer create() => Answer._();
  @$core.override
  Answer createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Answer getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Answer>(create);
  static Answer? _defaultInstance;

  @$pb.TagNumber(1)
  SessionDescription get sdp => $_getN(0);
  @$pb.TagNumber(1)
  set sdp(SessionDescription value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSdp() => $_has(0);
  @$pb.TagNumber(1)
  void clearSdp() => $_clearField(1);
  @$pb.TagNumber(1)
  SessionDescription ensureSdp() => $_ensure(0);
}

class SessionDescription extends $pb.GeneratedMessage {
  factory SessionDescription({
    $core.String? sdpType,
    $core.String? sdpData,
  }) {
    final result = create();
    if (sdpType != null) result.sdpType = sdpType;
    if (sdpData != null) result.sdpData = sdpData;
    return result;
  }

  SessionDescription._();

  factory SessionDescription.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SessionDescription.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SessionDescription',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'signaling.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'sdpType')
    ..aOS(2, _omitFieldNames ? '' : 'sdpData')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SessionDescription clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SessionDescription copyWith(void Function(SessionDescription) updates) =>
      super.copyWith((message) => updates(message as SessionDescription))
          as SessionDescription;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SessionDescription create() => SessionDescription._();
  @$core.override
  SessionDescription createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SessionDescription getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SessionDescription>(create);
  static SessionDescription? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sdpType => $_getSZ(0);
  @$pb.TagNumber(1)
  set sdpType($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSdpType() => $_has(0);
  @$pb.TagNumber(1)
  void clearSdpType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get sdpData => $_getSZ(1);
  @$pb.TagNumber(2)
  set sdpData($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSdpData() => $_has(1);
  @$pb.TagNumber(2)
  void clearSdpData() => $_clearField(2);
}

/// candidate 메시지
class Candidate extends $pb.GeneratedMessage {
  factory Candidate({
    $core.String? candidate,
    $core.String? sdpMid,
    $core.int? sdpMlineIndex,
  }) {
    final result = create();
    if (candidate != null) result.candidate = candidate;
    if (sdpMid != null) result.sdpMid = sdpMid;
    if (sdpMlineIndex != null) result.sdpMlineIndex = sdpMlineIndex;
    return result;
  }

  Candidate._();

  factory Candidate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Candidate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Candidate',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'signaling.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'candidate')
    ..aOS(2, _omitFieldNames ? '' : 'sdpMid')
    ..aI(3, _omitFieldNames ? '' : 'sdpMlineIndex')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Candidate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Candidate copyWith(void Function(Candidate) updates) =>
      super.copyWith((message) => updates(message as Candidate)) as Candidate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Candidate create() => Candidate._();
  @$core.override
  Candidate createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Candidate getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Candidate>(create);
  static Candidate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get candidate => $_getSZ(0);
  @$pb.TagNumber(1)
  set candidate($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCandidate() => $_has(0);
  @$pb.TagNumber(1)
  void clearCandidate() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get sdpMid => $_getSZ(1);
  @$pb.TagNumber(2)
  set sdpMid($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSdpMid() => $_has(1);
  @$pb.TagNumber(2)
  void clearSdpMid() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get sdpMlineIndex => $_getIZ(2);
  @$pb.TagNumber(3)
  set sdpMlineIndex($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSdpMlineIndex() => $_has(2);
  @$pb.TagNumber(3)
  void clearSdpMlineIndex() => $_clearField(3);
}

/// 사용자 트랙 목록
class UserTracks extends $pb.GeneratedMessage {
  factory UserTracks({
    $core.Iterable<UserTrack>? userTracks,
  }) {
    final result = create();
    if (userTracks != null) result.userTracks.addAll(userTracks);
    return result;
  }

  UserTracks._();

  factory UserTracks.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserTracks.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserTracks',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'signaling.v1'),
      createEmptyInstance: create)
    ..pPM<UserTrack>(1, _omitFieldNames ? '' : 'userTracks',
        subBuilder: UserTrack.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserTracks clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserTracks copyWith(void Function(UserTracks) updates) =>
      super.copyWith((message) => updates(message as UserTracks)) as UserTracks;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserTracks create() => UserTracks._();
  @$core.override
  UserTracks createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UserTracks getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserTracks>(create);
  static UserTracks? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<UserTrack> get userTracks => $_getList(0);
}

/// 사용자 트랙 정보
class UserTrack extends $pb.GeneratedMessage {
  factory UserTrack({
    $1.User? user,
    $core.String? trackId,
    TrackType? trackType,
  }) {
    final result = create();
    if (user != null) result.user = user;
    if (trackId != null) result.trackId = trackId;
    if (trackType != null) result.trackType = trackType;
    return result;
  }

  UserTrack._();

  factory UserTrack.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserTrack.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserTrack',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'signaling.v1'),
      createEmptyInstance: create)
    ..aOM<$1.User>(1, _omitFieldNames ? '' : 'user', subBuilder: $1.User.create)
    ..aOS(2, _omitFieldNames ? '' : 'trackId')
    ..aE<TrackType>(3, _omitFieldNames ? '' : 'trackType',
        enumValues: TrackType.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserTrack clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserTrack copyWith(void Function(UserTrack) updates) =>
      super.copyWith((message) => updates(message as UserTrack)) as UserTrack;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserTrack create() => UserTrack._();
  @$core.override
  UserTrack createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UserTrack getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserTrack>(create);
  static UserTrack? _defaultInstance;

  /// int64     user_id    = 1;
  /// 사용자 정보
  @$pb.TagNumber(1)
  $1.User get user => $_getN(0);
  @$pb.TagNumber(1)
  set user($1.User value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.User ensureUser() => $_ensure(0);

  /// 트랙 ID
  @$pb.TagNumber(2)
  $core.String get trackId => $_getSZ(1);
  @$pb.TagNumber(2)
  set trackId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTrackId() => $_has(1);
  @$pb.TagNumber(2)
  void clearTrackId() => $_clearField(2);

  /// 트랙 타입
  @$pb.TagNumber(3)
  TrackType get trackType => $_getN(2);
  @$pb.TagNumber(3)
  set trackType(TrackType value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasTrackType() => $_has(2);
  @$pb.TagNumber(3)
  void clearTrackType() => $_clearField(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
