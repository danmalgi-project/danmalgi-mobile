// This is a generated file - do not edit.
//
// Generated from relationship.proto.

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

import 'relationship.pb.dart' as $1;

export 'relationship.pb.dart';

/// RelationshipService provides services for managing friend requests and relationships.
@$pb.GrpcServiceName('pb.RelationshipService')
class RelationshipServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  RelationshipServiceClient(super.channel, {super.options, super.interceptors});

  /// GetOutgoingRelationshipList retrieves the list of friend requests sent by the user.
  $grpc.ResponseFuture<$1.GetOutgoingRelationshipListResponse>
      getOutgoingRelationshipList(
    $0.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getOutgoingRelationshipList, request,
        options: options);
  }

  /// GetIncomingRelationshipList retrieves the list of friend requests received by the user.
  $grpc.ResponseFuture<$1.GetIncomingRelationshipListResponse>
      getIncomingRelationshipList(
    $0.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getIncomingRelationshipList, request,
        options: options);
  }

  /// AddRelationship sends a new friend request.
  $grpc.ResponseFuture<$1.AddRelationshipResponse> addRelationship(
    $1.AddRelationshipRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$addRelationship, request, options: options);
  }

  /// UpdateIncomingRelationshipStatus updates the status of a received friend request (e.g., accept, reject).
  $grpc.ResponseFuture<$1.UpdateIncomingRelationshipStatusResponse>
      updateIncomingRelationshipStatus(
    $1.UpdateIncomingRelationshipStatusRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateIncomingRelationshipStatus, request,
        options: options);
  }

  /// UpdateOutgoingRelationshipStatus updates the status of a sent friend request (e.g., cancel).
  $grpc.ResponseFuture<$1.UpdateOutgoingRelationshipStatusResponse>
      updateOutgoingRelationshipStatus(
    $1.UpdateOutgoingRelationshipStatusRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateOutgoingRelationshipStatus, request,
        options: options);
  }

  // method descriptors

  static final _$getOutgoingRelationshipList =
      $grpc.ClientMethod<$0.Empty, $1.GetOutgoingRelationshipListResponse>(
          '/pb.RelationshipService/GetOutgoingRelationshipList',
          ($0.Empty value) => value.writeToBuffer(),
          $1.GetOutgoingRelationshipListResponse.fromBuffer);
  static final _$getIncomingRelationshipList =
      $grpc.ClientMethod<$0.Empty, $1.GetIncomingRelationshipListResponse>(
          '/pb.RelationshipService/GetIncomingRelationshipList',
          ($0.Empty value) => value.writeToBuffer(),
          $1.GetIncomingRelationshipListResponse.fromBuffer);
  static final _$addRelationship =
      $grpc.ClientMethod<$1.AddRelationshipRequest, $1.AddRelationshipResponse>(
          '/pb.RelationshipService/AddRelationship',
          ($1.AddRelationshipRequest value) => value.writeToBuffer(),
          $1.AddRelationshipResponse.fromBuffer);
  static final _$updateIncomingRelationshipStatus = $grpc.ClientMethod<
          $1.UpdateIncomingRelationshipStatusRequest,
          $1.UpdateIncomingRelationshipStatusResponse>(
      '/pb.RelationshipService/UpdateIncomingRelationshipStatus',
      ($1.UpdateIncomingRelationshipStatusRequest value) =>
          value.writeToBuffer(),
      $1.UpdateIncomingRelationshipStatusResponse.fromBuffer);
  static final _$updateOutgoingRelationshipStatus = $grpc.ClientMethod<
          $1.UpdateOutgoingRelationshipStatusRequest,
          $1.UpdateOutgoingRelationshipStatusResponse>(
      '/pb.RelationshipService/UpdateOutgoingRelationshipStatus',
      ($1.UpdateOutgoingRelationshipStatusRequest value) =>
          value.writeToBuffer(),
      $1.UpdateOutgoingRelationshipStatusResponse.fromBuffer);
}

@$pb.GrpcServiceName('pb.RelationshipService')
abstract class RelationshipServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.RelationshipService';

  RelationshipServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$0.Empty, $1.GetOutgoingRelationshipListResponse>(
            'GetOutgoingRelationshipList',
            getOutgoingRelationshipList_Pre,
            false,
            false,
            ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
            ($1.GetOutgoingRelationshipListResponse value) =>
                value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.Empty, $1.GetIncomingRelationshipListResponse>(
            'GetIncomingRelationshipList',
            getIncomingRelationshipList_Pre,
            false,
            false,
            ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
            ($1.GetIncomingRelationshipListResponse value) =>
                value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.AddRelationshipRequest,
            $1.AddRelationshipResponse>(
        'AddRelationship',
        addRelationship_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.AddRelationshipRequest.fromBuffer(value),
        ($1.AddRelationshipResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UpdateIncomingRelationshipStatusRequest,
            $1.UpdateIncomingRelationshipStatusResponse>(
        'UpdateIncomingRelationshipStatus',
        updateIncomingRelationshipStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.UpdateIncomingRelationshipStatusRequest.fromBuffer(value),
        ($1.UpdateIncomingRelationshipStatusResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UpdateOutgoingRelationshipStatusRequest,
            $1.UpdateOutgoingRelationshipStatusResponse>(
        'UpdateOutgoingRelationshipStatus',
        updateOutgoingRelationshipStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.UpdateOutgoingRelationshipStatusRequest.fromBuffer(value),
        ($1.UpdateOutgoingRelationshipStatusResponse value) =>
            value.writeToBuffer()));
  }

  $async.Future<$1.GetOutgoingRelationshipListResponse>
      getOutgoingRelationshipList_Pre(
          $grpc.ServiceCall $call, $async.Future<$0.Empty> $request) async {
    return getOutgoingRelationshipList($call, await $request);
  }

  $async.Future<$1.GetOutgoingRelationshipListResponse>
      getOutgoingRelationshipList($grpc.ServiceCall call, $0.Empty request);

  $async.Future<$1.GetIncomingRelationshipListResponse>
      getIncomingRelationshipList_Pre(
          $grpc.ServiceCall $call, $async.Future<$0.Empty> $request) async {
    return getIncomingRelationshipList($call, await $request);
  }

  $async.Future<$1.GetIncomingRelationshipListResponse>
      getIncomingRelationshipList($grpc.ServiceCall call, $0.Empty request);

  $async.Future<$1.AddRelationshipResponse> addRelationship_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$1.AddRelationshipRequest> $request) async {
    return addRelationship($call, await $request);
  }

  $async.Future<$1.AddRelationshipResponse> addRelationship(
      $grpc.ServiceCall call, $1.AddRelationshipRequest request);

  $async.Future<$1.UpdateIncomingRelationshipStatusResponse>
      updateIncomingRelationshipStatus_Pre(
          $grpc.ServiceCall $call,
          $async.Future<$1.UpdateIncomingRelationshipStatusRequest>
              $request) async {
    return updateIncomingRelationshipStatus($call, await $request);
  }

  $async.Future<$1.UpdateIncomingRelationshipStatusResponse>
      updateIncomingRelationshipStatus($grpc.ServiceCall call,
          $1.UpdateIncomingRelationshipStatusRequest request);

  $async.Future<$1.UpdateOutgoingRelationshipStatusResponse>
      updateOutgoingRelationshipStatus_Pre(
          $grpc.ServiceCall $call,
          $async.Future<$1.UpdateOutgoingRelationshipStatusRequest>
              $request) async {
    return updateOutgoingRelationshipStatus($call, await $request);
  }

  $async.Future<$1.UpdateOutgoingRelationshipStatusResponse>
      updateOutgoingRelationshipStatus($grpc.ServiceCall call,
          $1.UpdateOutgoingRelationshipStatusRequest request);
}
