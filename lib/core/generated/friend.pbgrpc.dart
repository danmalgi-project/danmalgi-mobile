// This is a generated file - do not edit.
//
// Generated from friend.proto.

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

import 'friend.pb.dart' as $1;

export 'friend.pb.dart';

/// FriendService provides services for managing user's friends.
@$pb.GrpcServiceName('pb.FriendService')
class FriendServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  FriendServiceClient(super.channel, {super.options, super.interceptors});

  /// GetFriendList retrieves the user's friend list.
  $grpc.ResponseFuture<$1.GetFriendListResponse> getFriendList(
    $0.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getFriendList, request, options: options);
  }

  /// UpdateFriendStatus changes the status of a friend (e.g., block, unfriend).
  $grpc.ResponseFuture<$1.UpdateFriendStatusResponse> updateFriendStatus(
    $1.UpdateFriendStatusRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateFriendStatus, request, options: options);
  }

  // method descriptors

  static final _$getFriendList =
      $grpc.ClientMethod<$0.Empty, $1.GetFriendListResponse>(
          '/pb.FriendService/GetFriendList',
          ($0.Empty value) => value.writeToBuffer(),
          $1.GetFriendListResponse.fromBuffer);
  static final _$updateFriendStatus = $grpc.ClientMethod<
          $1.UpdateFriendStatusRequest, $1.UpdateFriendStatusResponse>(
      '/pb.FriendService/UpdateFriendStatus',
      ($1.UpdateFriendStatusRequest value) => value.writeToBuffer(),
      $1.UpdateFriendStatusResponse.fromBuffer);
}

@$pb.GrpcServiceName('pb.FriendService')
abstract class FriendServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.FriendService';

  FriendServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Empty, $1.GetFriendListResponse>(
        'GetFriendList',
        getFriendList_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($1.GetFriendListResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UpdateFriendStatusRequest,
            $1.UpdateFriendStatusResponse>(
        'UpdateFriendStatus',
        updateFriendStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.UpdateFriendStatusRequest.fromBuffer(value),
        ($1.UpdateFriendStatusResponse value) => value.writeToBuffer()));
  }

  $async.Future<$1.GetFriendListResponse> getFriendList_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.Empty> $request) async {
    return getFriendList($call, await $request);
  }

  $async.Future<$1.GetFriendListResponse> getFriendList(
      $grpc.ServiceCall call, $0.Empty request);

  $async.Future<$1.UpdateFriendStatusResponse> updateFriendStatus_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$1.UpdateFriendStatusRequest> $request) async {
    return updateFriendStatus($call, await $request);
  }

  $async.Future<$1.UpdateFriendStatusResponse> updateFriendStatus(
      $grpc.ServiceCall call, $1.UpdateFriendStatusRequest request);
}
