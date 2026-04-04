// This is a generated file - do not edit.
//
// Generated from dm/v1/dm.proto.

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
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart' as $0;

import 'dm.pb.dart' as $1;

export 'dm.pb.dart';

/// DirectMessageService provides services for managing direct message channels.
@$pb.GrpcServiceName('dm.v1.DirectMessageService')
class DirectMessageServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  DirectMessageServiceClient(super.channel,
      {super.options, super.interceptors});

  /// GetDirectMessageChannelList retrieves the list of direct message channels for the user.
  $grpc.ResponseFuture<$1.GetDirectMessageChannelListResponse>
      getDirectMessageChannelList(
    $0.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getDirectMessageChannelList, request,
        options: options);
  }

  /// CreateDirectMessageChannel creates a new direct message channel with specified friends.
  $grpc.ResponseFuture<$1.CreateDirectMessageChannelResponse>
      createDirectMessageChannel(
    $1.CreateDirectMessageChannelRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createDirectMessageChannel, request,
        options: options);
  }

  // method descriptors

  static final _$getDirectMessageChannelList =
      $grpc.ClientMethod<$0.Empty, $1.GetDirectMessageChannelListResponse>(
          '/dm.v1.DirectMessageService/GetDirectMessageChannelList',
          ($0.Empty value) => value.writeToBuffer(),
          $1.GetDirectMessageChannelListResponse.fromBuffer);
  static final _$createDirectMessageChannel = $grpc.ClientMethod<
          $1.CreateDirectMessageChannelRequest,
          $1.CreateDirectMessageChannelResponse>(
      '/dm.v1.DirectMessageService/CreateDirectMessageChannel',
      ($1.CreateDirectMessageChannelRequest value) => value.writeToBuffer(),
      $1.CreateDirectMessageChannelResponse.fromBuffer);
}

@$pb.GrpcServiceName('dm.v1.DirectMessageService')
abstract class DirectMessageServiceBase extends $grpc.Service {
  $core.String get $name => 'dm.v1.DirectMessageService';

  DirectMessageServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$0.Empty, $1.GetDirectMessageChannelListResponse>(
            'GetDirectMessageChannelList',
            getDirectMessageChannelList_Pre,
            false,
            false,
            ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
            ($1.GetDirectMessageChannelListResponse value) =>
                value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.CreateDirectMessageChannelRequest,
            $1.CreateDirectMessageChannelResponse>(
        'CreateDirectMessageChannel',
        createDirectMessageChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.CreateDirectMessageChannelRequest.fromBuffer(value),
        ($1.CreateDirectMessageChannelResponse value) =>
            value.writeToBuffer()));
  }

  $async.Future<$1.GetDirectMessageChannelListResponse>
      getDirectMessageChannelList_Pre(
          $grpc.ServiceCall $call, $async.Future<$0.Empty> $request) async {
    return getDirectMessageChannelList($call, await $request);
  }

  $async.Future<$1.GetDirectMessageChannelListResponse>
      getDirectMessageChannelList($grpc.ServiceCall call, $0.Empty request);

  $async.Future<$1.CreateDirectMessageChannelResponse>
      createDirectMessageChannel_Pre($grpc.ServiceCall $call,
          $async.Future<$1.CreateDirectMessageChannelRequest> $request) async {
    return createDirectMessageChannel($call, await $request);
  }

  $async.Future<$1.CreateDirectMessageChannelResponse>
      createDirectMessageChannel(
          $grpc.ServiceCall call, $1.CreateDirectMessageChannelRequest request);
}
