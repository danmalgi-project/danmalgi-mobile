// This is a generated file - do not edit.
//
// Generated from internalpb/internal_user.proto.

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

import 'internal_user.pb.dart' as $0;

export 'internal_user.pb.dart';

@$pb.GrpcServiceName('internalpb.InternalUserService')
class InternalUserServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  InternalUserServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.CacheUsersResponse> cacheUsers(
    $0.CacheUsersRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$cacheUsers, request, options: options);
  }

  // method descriptors

  static final _$cacheUsers =
      $grpc.ClientMethod<$0.CacheUsersRequest, $0.CacheUsersResponse>(
          '/internalpb.InternalUserService/CacheUsers',
          ($0.CacheUsersRequest value) => value.writeToBuffer(),
          $0.CacheUsersResponse.fromBuffer);
}

@$pb.GrpcServiceName('internalpb.InternalUserService')
abstract class InternalUserServiceBase extends $grpc.Service {
  $core.String get $name => 'internalpb.InternalUserService';

  InternalUserServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CacheUsersRequest, $0.CacheUsersResponse>(
        'CacheUsers',
        cacheUsers_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CacheUsersRequest.fromBuffer(value),
        ($0.CacheUsersResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.CacheUsersResponse> cacheUsers_Pre($grpc.ServiceCall $call,
      $async.Future<$0.CacheUsersRequest> $request) async {
    return cacheUsers($call, await $request);
  }

  $async.Future<$0.CacheUsersResponse> cacheUsers(
      $grpc.ServiceCall call, $0.CacheUsersRequest request);
}
