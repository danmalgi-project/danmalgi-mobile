// This is a generated file - do not edit.
//
// Generated from internalpb/internal_chat.proto.

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

import 'internal_chat.pb.dart' as $0;

export 'internal_chat.pb.dart';

@$pb.GrpcServiceName('internalpb.InternalChatService')
class InternalChatServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  InternalChatServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.GetChannelDevicesResponse> getChannelDevices(
    $0.GetChannelDevicesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getChannelDevices, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetDevicesResponse> getDevices(
    $0.GetDevicesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getDevices, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetChannelNamesResponse> getChannelNames(
    $0.GetChannelNamesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getChannelNames, request, options: options);
  }

  // method descriptors

  static final _$getChannelDevices = $grpc.ClientMethod<
          $0.GetChannelDevicesRequest, $0.GetChannelDevicesResponse>(
      '/internalpb.InternalChatService/GetChannelDevices',
      ($0.GetChannelDevicesRequest value) => value.writeToBuffer(),
      $0.GetChannelDevicesResponse.fromBuffer);
  static final _$getDevices =
      $grpc.ClientMethod<$0.GetDevicesRequest, $0.GetDevicesResponse>(
          '/internalpb.InternalChatService/GetDevices',
          ($0.GetDevicesRequest value) => value.writeToBuffer(),
          $0.GetDevicesResponse.fromBuffer);
  static final _$getChannelNames =
      $grpc.ClientMethod<$0.GetChannelNamesRequest, $0.GetChannelNamesResponse>(
          '/internalpb.InternalChatService/GetChannelNames',
          ($0.GetChannelNamesRequest value) => value.writeToBuffer(),
          $0.GetChannelNamesResponse.fromBuffer);
}

@$pb.GrpcServiceName('internalpb.InternalChatService')
abstract class InternalChatServiceBase extends $grpc.Service {
  $core.String get $name => 'internalpb.InternalChatService';

  InternalChatServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetChannelDevicesRequest,
            $0.GetChannelDevicesResponse>(
        'GetChannelDevices',
        getChannelDevices_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetChannelDevicesRequest.fromBuffer(value),
        ($0.GetChannelDevicesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetDevicesRequest, $0.GetDevicesResponse>(
        'GetDevices',
        getDevices_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetDevicesRequest.fromBuffer(value),
        ($0.GetDevicesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetChannelNamesRequest,
            $0.GetChannelNamesResponse>(
        'GetChannelNames',
        getChannelNames_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetChannelNamesRequest.fromBuffer(value),
        ($0.GetChannelNamesResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetChannelDevicesResponse> getChannelDevices_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetChannelDevicesRequest> $request) async {
    return getChannelDevices($call, await $request);
  }

  $async.Future<$0.GetChannelDevicesResponse> getChannelDevices(
      $grpc.ServiceCall call, $0.GetChannelDevicesRequest request);

  $async.Future<$0.GetDevicesResponse> getDevices_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetDevicesRequest> $request) async {
    return getDevices($call, await $request);
  }

  $async.Future<$0.GetDevicesResponse> getDevices(
      $grpc.ServiceCall call, $0.GetDevicesRequest request);

  $async.Future<$0.GetChannelNamesResponse> getChannelNames_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetChannelNamesRequest> $request) async {
    return getChannelNames($call, await $request);
  }

  $async.Future<$0.GetChannelNamesResponse> getChannelNames(
      $grpc.ServiceCall call, $0.GetChannelNamesRequest request);
}
