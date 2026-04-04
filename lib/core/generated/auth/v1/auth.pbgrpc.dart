// This is a generated file - do not edit.
//
// Generated from auth/v1/auth.proto.

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
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart' as $1;

import 'auth.pb.dart' as $0;

export 'auth.pb.dart';

/// AuthService provides services for user authentication and registration.
@$pb.GrpcServiceName('auth.v1.AuthService')
class AuthServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  AuthServiceClient(super.channel, {super.options, super.interceptors});

  /// Authorization handles user login via OAuth.
  /// It returns whether the user is new, user information, and an access token.
  $grpc.ResponseFuture<$0.AuthorizationResponse> authorization(
    $0.AuthorizationRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$authorization, request, options: options);
  }

  ///   {
  ///     option (non_require_auth) = true;
  ///   };
  ///  Register completes the registration for a new user.
  $grpc.ResponseFuture<$0.RegisterResponse> register(
    $0.RegisterRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$register, request, options: options);
  }

  /// Upserts (creates or updates) a user's FCM token.
  $grpc.ResponseFuture<$1.Empty> upsertFcmToken(
    $0.UpsertFcmTokenRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$upsertFcmToken, request, options: options);
  }

  // method descriptors

  static final _$authorization =
      $grpc.ClientMethod<$0.AuthorizationRequest, $0.AuthorizationResponse>(
          '/auth.v1.AuthService/Authorization',
          ($0.AuthorizationRequest value) => value.writeToBuffer(),
          $0.AuthorizationResponse.fromBuffer);
  static final _$register =
      $grpc.ClientMethod<$0.RegisterRequest, $0.RegisterResponse>(
          '/auth.v1.AuthService/Register',
          ($0.RegisterRequest value) => value.writeToBuffer(),
          $0.RegisterResponse.fromBuffer);
  static final _$upsertFcmToken =
      $grpc.ClientMethod<$0.UpsertFcmTokenRequest, $1.Empty>(
          '/auth.v1.AuthService/UpsertFcmToken',
          ($0.UpsertFcmTokenRequest value) => value.writeToBuffer(),
          $1.Empty.fromBuffer);
}

@$pb.GrpcServiceName('auth.v1.AuthService')
abstract class AuthServiceBase extends $grpc.Service {
  $core.String get $name => 'auth.v1.AuthService';

  AuthServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$0.AuthorizationRequest, $0.AuthorizationResponse>(
            'Authorization',
            authorization_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.AuthorizationRequest.fromBuffer(value),
            ($0.AuthorizationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RegisterRequest, $0.RegisterResponse>(
        'Register',
        register_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RegisterRequest.fromBuffer(value),
        ($0.RegisterResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpsertFcmTokenRequest, $1.Empty>(
        'UpsertFcmToken',
        upsertFcmToken_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpsertFcmTokenRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$0.AuthorizationResponse> authorization_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.AuthorizationRequest> $request) async {
    return authorization($call, await $request);
  }

  $async.Future<$0.AuthorizationResponse> authorization(
      $grpc.ServiceCall call, $0.AuthorizationRequest request);

  $async.Future<$0.RegisterResponse> register_Pre($grpc.ServiceCall $call,
      $async.Future<$0.RegisterRequest> $request) async {
    return register($call, await $request);
  }

  $async.Future<$0.RegisterResponse> register(
      $grpc.ServiceCall call, $0.RegisterRequest request);

  $async.Future<$1.Empty> upsertFcmToken_Pre($grpc.ServiceCall $call,
      $async.Future<$0.UpsertFcmTokenRequest> $request) async {
    return upsertFcmToken($call, await $request);
  }

  $async.Future<$1.Empty> upsertFcmToken(
      $grpc.ServiceCall call, $0.UpsertFcmTokenRequest request);
}
