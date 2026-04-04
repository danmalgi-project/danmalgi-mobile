// This is a generated file - do not edit.
//
// Generated from etc/room.proto.

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

import 'room.pb.dart' as $0;

export 'room.pb.dart';

/// RoomService provides services for managing chat rooms.
@$pb.GrpcServiceName('pb.RoomService')
class RoomServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  RoomServiceClient(super.channel, {super.options, super.interceptors});

  /// CreateRoom creates a new chat room.
  $grpc.ResponseFuture<$0.CreateRoomResponse> createRoom(
    $0.CreateRoomRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createRoom, request, options: options);
  }

  /// GetRoomList retrieves a list of all chat rooms.
  $grpc.ResponseFuture<$0.GetRoomListResponse> getRoomList(
    $0.GetRoomListRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getRoomList, request, options: options);
  }

  /// GetRoom retrieves detailed information about a specific chat room.
  $grpc.ResponseFuture<$0.GetRoomResponse> getRoom(
    $0.GetRoomRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getRoom, request, options: options);
  }

  // method descriptors

  static final _$createRoom =
      $grpc.ClientMethod<$0.CreateRoomRequest, $0.CreateRoomResponse>(
          '/pb.RoomService/CreateRoom',
          ($0.CreateRoomRequest value) => value.writeToBuffer(),
          $0.CreateRoomResponse.fromBuffer);
  static final _$getRoomList =
      $grpc.ClientMethod<$0.GetRoomListRequest, $0.GetRoomListResponse>(
          '/pb.RoomService/GetRoomList',
          ($0.GetRoomListRequest value) => value.writeToBuffer(),
          $0.GetRoomListResponse.fromBuffer);
  static final _$getRoom =
      $grpc.ClientMethod<$0.GetRoomRequest, $0.GetRoomResponse>(
          '/pb.RoomService/GetRoom',
          ($0.GetRoomRequest value) => value.writeToBuffer(),
          $0.GetRoomResponse.fromBuffer);
}

@$pb.GrpcServiceName('pb.RoomService')
abstract class RoomServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.RoomService';

  RoomServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreateRoomRequest, $0.CreateRoomResponse>(
        'CreateRoom',
        createRoom_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateRoomRequest.fromBuffer(value),
        ($0.CreateRoomResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetRoomListRequest, $0.GetRoomListResponse>(
            'GetRoomList',
            getRoomList_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetRoomListRequest.fromBuffer(value),
            ($0.GetRoomListResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetRoomRequest, $0.GetRoomResponse>(
        'GetRoom',
        getRoom_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetRoomRequest.fromBuffer(value),
        ($0.GetRoomResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.CreateRoomResponse> createRoom_Pre($grpc.ServiceCall $call,
      $async.Future<$0.CreateRoomRequest> $request) async {
    return createRoom($call, await $request);
  }

  $async.Future<$0.CreateRoomResponse> createRoom(
      $grpc.ServiceCall call, $0.CreateRoomRequest request);

  $async.Future<$0.GetRoomListResponse> getRoomList_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetRoomListRequest> $request) async {
    return getRoomList($call, await $request);
  }

  $async.Future<$0.GetRoomListResponse> getRoomList(
      $grpc.ServiceCall call, $0.GetRoomListRequest request);

  $async.Future<$0.GetRoomResponse> getRoom_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetRoomRequest> $request) async {
    return getRoom($call, await $request);
  }

  $async.Future<$0.GetRoomResponse> getRoom(
      $grpc.ServiceCall call, $0.GetRoomRequest request);
}
