// This is a generated file - do not edit.
//
// Generated from chat.proto.

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

import 'chat.pb.dart' as $0;

export 'chat.pb.dart';

/// ChatService provides services for real-time chat functionalities.
@$pb.GrpcServiceName('pb.ChatService')
class ChatServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  ChatServiceClient(super.channel, {super.options, super.interceptors});

  /// GetPreviousMessages retrieves previous messages in a channel.
  $grpc.ResponseFuture<$0.GetPreviousMessagesResponse> getPreviousMessages(
    $0.GetPreviousMessagesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getPreviousMessages, request, options: options);
  }

  /// ModifyMessage modifies an existing message.
  $grpc.ResponseFuture<$1.Empty> modifyMessage(
    $0.ModifyMessageRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$modifyMessage, request, options: options);
  }

  /// DeleteMessage deletes a message.
  $grpc.ResponseFuture<$1.Empty> deleteMessage(
    $0.DeleteMessageRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$deleteMessage, request, options: options);
  }

  /// SendMessage sends a message to the current chat room.
  $grpc.ResponseFuture<$1.Empty> sendMessage(
    $0.SendMessageRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$sendMessage, request, options: options);
  }

  /// ReceiveMessage establishes a stream to receive messages from the current chat room.
  $grpc.ResponseStream<$0.ReceiveMessageResponse> receiveMessage(
    $0.ReceiveMessageRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(
        _$receiveMessage, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$1.Empty> sendHeartBeat(
    $0.SendHeartBeatRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$sendHeartBeat, request, options: options);
  }

  // method descriptors

  static final _$getPreviousMessages = $grpc.ClientMethod<
          $0.GetPreviousMessagesRequest, $0.GetPreviousMessagesResponse>(
      '/pb.ChatService/GetPreviousMessages',
      ($0.GetPreviousMessagesRequest value) => value.writeToBuffer(),
      $0.GetPreviousMessagesResponse.fromBuffer);
  static final _$modifyMessage =
      $grpc.ClientMethod<$0.ModifyMessageRequest, $1.Empty>(
          '/pb.ChatService/ModifyMessage',
          ($0.ModifyMessageRequest value) => value.writeToBuffer(),
          $1.Empty.fromBuffer);
  static final _$deleteMessage =
      $grpc.ClientMethod<$0.DeleteMessageRequest, $1.Empty>(
          '/pb.ChatService/DeleteMessage',
          ($0.DeleteMessageRequest value) => value.writeToBuffer(),
          $1.Empty.fromBuffer);
  static final _$sendMessage =
      $grpc.ClientMethod<$0.SendMessageRequest, $1.Empty>(
          '/pb.ChatService/SendMessage',
          ($0.SendMessageRequest value) => value.writeToBuffer(),
          $1.Empty.fromBuffer);
  static final _$receiveMessage =
      $grpc.ClientMethod<$0.ReceiveMessageRequest, $0.ReceiveMessageResponse>(
          '/pb.ChatService/ReceiveMessage',
          ($0.ReceiveMessageRequest value) => value.writeToBuffer(),
          $0.ReceiveMessageResponse.fromBuffer);
  static final _$sendHeartBeat =
      $grpc.ClientMethod<$0.SendHeartBeatRequest, $1.Empty>(
          '/pb.ChatService/SendHeartBeat',
          ($0.SendHeartBeatRequest value) => value.writeToBuffer(),
          $1.Empty.fromBuffer);
}

@$pb.GrpcServiceName('pb.ChatService')
abstract class ChatServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.ChatService';

  ChatServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetPreviousMessagesRequest,
            $0.GetPreviousMessagesResponse>(
        'GetPreviousMessages',
        getPreviousMessages_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetPreviousMessagesRequest.fromBuffer(value),
        ($0.GetPreviousMessagesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ModifyMessageRequest, $1.Empty>(
        'ModifyMessage',
        modifyMessage_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ModifyMessageRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteMessageRequest, $1.Empty>(
        'DeleteMessage',
        deleteMessage_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeleteMessageRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SendMessageRequest, $1.Empty>(
        'SendMessage',
        sendMessage_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SendMessageRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ReceiveMessageRequest,
            $0.ReceiveMessageResponse>(
        'ReceiveMessage',
        receiveMessage_Pre,
        false,
        true,
        ($core.List<$core.int> value) =>
            $0.ReceiveMessageRequest.fromBuffer(value),
        ($0.ReceiveMessageResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SendHeartBeatRequest, $1.Empty>(
        'SendHeartBeat',
        sendHeartBeat_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SendHeartBeatRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetPreviousMessagesResponse> getPreviousMessages_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetPreviousMessagesRequest> $request) async {
    return getPreviousMessages($call, await $request);
  }

  $async.Future<$0.GetPreviousMessagesResponse> getPreviousMessages(
      $grpc.ServiceCall call, $0.GetPreviousMessagesRequest request);

  $async.Future<$1.Empty> modifyMessage_Pre($grpc.ServiceCall $call,
      $async.Future<$0.ModifyMessageRequest> $request) async {
    return modifyMessage($call, await $request);
  }

  $async.Future<$1.Empty> modifyMessage(
      $grpc.ServiceCall call, $0.ModifyMessageRequest request);

  $async.Future<$1.Empty> deleteMessage_Pre($grpc.ServiceCall $call,
      $async.Future<$0.DeleteMessageRequest> $request) async {
    return deleteMessage($call, await $request);
  }

  $async.Future<$1.Empty> deleteMessage(
      $grpc.ServiceCall call, $0.DeleteMessageRequest request);

  $async.Future<$1.Empty> sendMessage_Pre($grpc.ServiceCall $call,
      $async.Future<$0.SendMessageRequest> $request) async {
    return sendMessage($call, await $request);
  }

  $async.Future<$1.Empty> sendMessage(
      $grpc.ServiceCall call, $0.SendMessageRequest request);

  $async.Stream<$0.ReceiveMessageResponse> receiveMessage_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ReceiveMessageRequest> $request) async* {
    yield* receiveMessage($call, await $request);
  }

  $async.Stream<$0.ReceiveMessageResponse> receiveMessage(
      $grpc.ServiceCall call, $0.ReceiveMessageRequest request);

  $async.Future<$1.Empty> sendHeartBeat_Pre($grpc.ServiceCall $call,
      $async.Future<$0.SendHeartBeatRequest> $request) async {
    return sendHeartBeat($call, await $request);
  }

  $async.Future<$1.Empty> sendHeartBeat(
      $grpc.ServiceCall call, $0.SendHeartBeatRequest request);
}
