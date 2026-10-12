// This is a generated file - do not edit.
//
// Generated from user/v1/user.proto.

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

import 'user.pb.dart' as $1;

export 'user.pb.dart';

/// UserService provides services for managing user accounts.
@$pb.GrpcServiceName('user.v1.UserService')
class UserServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  UserServiceClient(super.channel, {super.options, super.interceptors});

  /// GetUserByToken retrieves user information based on the authentication token.
  $grpc.ResponseFuture<$1.GetUserByTokenResponse> getUserByToken(
    $0.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getUserByToken, request, options: options);
  }

  /// VerifyNameAndTag checks if a combination of user name and tag is available.
  $grpc.ResponseFuture<$0.Empty> verifyNameAndTag(
    $1.VerifyNameAndTagRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$verifyNameAndTag, request, options: options);
  }

  /// rpc ChangeUserTag() returns();
  $grpc.ResponseFuture<$1.UploadProfileResponse> uploadProfile(
    $1.UploadProfileRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$uploadProfile, request, options: options);
  }

  /// SearchUser looks up users by exact name+tag match.
  /// 지금은 완전 일치라 결과가 0건 또는 1건이지만, 이름만으로 찾는 확장을 염두에 두고
  /// 응답은 처음부터 list 로 둔다. 없으면 빈 list 다.
  $grpc.ResponseFuture<$1.SearchUserResponse> searchUser(
    $1.SearchUserRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$searchUser, request, options: options);
  }

  // method descriptors

  static final _$getUserByToken =
      $grpc.ClientMethod<$0.Empty, $1.GetUserByTokenResponse>(
          '/user.v1.UserService/GetUserByToken',
          ($0.Empty value) => value.writeToBuffer(),
          $1.GetUserByTokenResponse.fromBuffer);
  static final _$verifyNameAndTag =
      $grpc.ClientMethod<$1.VerifyNameAndTagRequest, $0.Empty>(
          '/user.v1.UserService/VerifyNameAndTag',
          ($1.VerifyNameAndTagRequest value) => value.writeToBuffer(),
          $0.Empty.fromBuffer);
  static final _$uploadProfile =
      $grpc.ClientMethod<$1.UploadProfileRequest, $1.UploadProfileResponse>(
          '/user.v1.UserService/UploadProfile',
          ($1.UploadProfileRequest value) => value.writeToBuffer(),
          $1.UploadProfileResponse.fromBuffer);
  static final _$searchUser =
      $grpc.ClientMethod<$1.SearchUserRequest, $1.SearchUserResponse>(
          '/user.v1.UserService/SearchUser',
          ($1.SearchUserRequest value) => value.writeToBuffer(),
          $1.SearchUserResponse.fromBuffer);
}

@$pb.GrpcServiceName('user.v1.UserService')
abstract class UserServiceBase extends $grpc.Service {
  $core.String get $name => 'user.v1.UserService';

  UserServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Empty, $1.GetUserByTokenResponse>(
        'GetUserByToken',
        getUserByToken_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($1.GetUserByTokenResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.VerifyNameAndTagRequest, $0.Empty>(
        'VerifyNameAndTag',
        verifyNameAndTag_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.VerifyNameAndTagRequest.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$1.UploadProfileRequest, $1.UploadProfileResponse>(
            'UploadProfile',
            uploadProfile_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $1.UploadProfileRequest.fromBuffer(value),
            ($1.UploadProfileResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.SearchUserRequest, $1.SearchUserResponse>(
        'SearchUser',
        searchUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.SearchUserRequest.fromBuffer(value),
        ($1.SearchUserResponse value) => value.writeToBuffer()));
  }

  $async.Future<$1.GetUserByTokenResponse> getUserByToken_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.Empty> $request) async {
    return getUserByToken($call, await $request);
  }

  $async.Future<$1.GetUserByTokenResponse> getUserByToken(
      $grpc.ServiceCall call, $0.Empty request);

  $async.Future<$0.Empty> verifyNameAndTag_Pre($grpc.ServiceCall $call,
      $async.Future<$1.VerifyNameAndTagRequest> $request) async {
    return verifyNameAndTag($call, await $request);
  }

  $async.Future<$0.Empty> verifyNameAndTag(
      $grpc.ServiceCall call, $1.VerifyNameAndTagRequest request);

  $async.Future<$1.UploadProfileResponse> uploadProfile_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$1.UploadProfileRequest> $request) async {
    return uploadProfile($call, await $request);
  }

  $async.Future<$1.UploadProfileResponse> uploadProfile(
      $grpc.ServiceCall call, $1.UploadProfileRequest request);

  $async.Future<$1.SearchUserResponse> searchUser_Pre($grpc.ServiceCall $call,
      $async.Future<$1.SearchUserRequest> $request) async {
    return searchUser($call, await $request);
  }

  $async.Future<$1.SearchUserResponse> searchUser(
      $grpc.ServiceCall call, $1.SearchUserRequest request);
}
