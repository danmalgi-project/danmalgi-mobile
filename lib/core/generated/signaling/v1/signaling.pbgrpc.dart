// This is a generated file - do not edit.
//
// Generated from signaling/v1/signaling.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'signaling.pb.dart' as $0;

export 'signaling.pb.dart';

/// WebRTC 연결을 설정하기 위한 시그널링 기능을 제공합니다.
/// WebrtcService provides signaling capabilities for establishing WebRTC connections.
@$pb.GrpcServiceName('signaling.v1.SignalingService')
class SignalingServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  SignalingServiceClient(super.channel, {super.options, super.interceptors});

  /// 피어 간에 WebRTC 시그널링 메시지 (offer, answer, candidate)를 교환하기 위한 양방향 스트림을 설정합니다.
  /// Signaling establishes a bidirectional stream for exchanging WebRTC signaling messages
  /// (offers, answers, candidates) between peers.
  $grpc.ResponseStream<$0.SignalingResponse> signaling(
    $async.Stream<$0.SignalingRequest> request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(_$signaling, request, options: options);
  }

  // method descriptors

  static final _$signaling =
      $grpc.ClientMethod<$0.SignalingRequest, $0.SignalingResponse>(
          '/signaling.v1.SignalingService/Signaling',
          ($0.SignalingRequest value) => value.writeToBuffer(),
          $0.SignalingResponse.fromBuffer);
}

@$pb.GrpcServiceName('signaling.v1.SignalingService')
abstract class SignalingServiceBase extends $grpc.Service {
  $core.String get $name => 'signaling.v1.SignalingService';

  SignalingServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.SignalingRequest, $0.SignalingResponse>(
        'Signaling',
        signaling,
        true,
        true,
        ($core.List<$core.int> value) => $0.SignalingRequest.fromBuffer(value),
        ($0.SignalingResponse value) => value.writeToBuffer()));
  }

  $async.Stream<$0.SignalingResponse> signaling(
      $grpc.ServiceCall call, $async.Stream<$0.SignalingRequest> request);
}
