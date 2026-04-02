import 'package:danmalgi_mobile/core/generated/signaling.pbgrpc.dart';
import 'package:danmalgi_mobile/core/network/interceptors/error_interceptor.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:danmalgi_mobile/core/generated/auth.pbgrpc.dart';
import 'package:danmalgi_mobile/core/generated/chat.pbgrpc.dart';
import 'package:danmalgi_mobile/core/generated/direct_message.pbgrpc.dart';
import 'package:danmalgi_mobile/core/generated/friend.pbgrpc.dart';
import 'package:danmalgi_mobile/core/generated/relationship.pbgrpc.dart';
import 'package:danmalgi_mobile/core/generated/user.pbgrpc.dart';
import 'package:danmalgi_mobile/core/network/grpc_channel_service.dart';
import 'package:danmalgi_mobile/core/network/interceptors/auth_interceptor.dart';
import 'package:danmalgi_mobile/features/auth/data/providers/auth_notifier.dart';
import 'package:grpc/service_api.dart';

/// gRPC Clients
final apiClientProvider = Provider<GrpcChannelService>((ref) {
  final String host = dotenv.get("DANMALGI_API_HOST");
  final int port = int.parse(dotenv.get("DANMALGI_API_PORT"));

  return GrpcChannelService(host: host, port: port);
});

final chatClientProvider = Provider<GrpcChannelService>((ref) {
  final String host = dotenv.get("DANMALGI_CHAT_HOST");
  final int port = int.parse(dotenv.get("DANMALGI_CHAT_PORT"));

  return GrpcChannelService(host: host, port: port);
});

final signalingClientProvider = Provider<GrpcChannelService>((ref) {
  final String host = dotenv.get("DANMALGI_VOICE_HOST");
  final int port = int.parse(dotenv.get("DANMALGI_VOICE_PORT"));

  return GrpcChannelService(host: host, port: port);
});

/// feature: Auth
// final authInterceptorProvider = Provider<AuthInterceptor>((ref) => AuthInterceptor(token: ref.watch(tokenProvider)!.accessToken));
final authInterceptorProvider = Provider<AuthInterceptor>(
  (ref) => AuthInterceptor(
    getToken: () => ref.read(authNotifierProvider).value?.accessToken,
  ),
);
// final authInterceptorProvider = Provider<AuthInterceptor>((ref) => AuthInterceptor(ref));

final errorInterceptorProvider = Provider<ErrorInterceptor>(
  (ref) => ErrorInterceptor(
    logout: () => ref.read(authNotifierProvider.notifier).logout(),
  ),
);

final authServiceClientProvider = Provider<AuthServiceClient>((ref) {
  final channel = ref.watch(apiClientProvider).channel;
  final errorInterceptor = ref.watch(errorInterceptorProvider);

  return AuthServiceClient(channel, interceptors: [errorInterceptor]);
});

/// feature: Chat
final chatServiceClientProvider = Provider<ChatServiceClient>((ref) {
  final channel = ref.watch(chatClientProvider).channel;
  final authInterceptor = ref.watch(authInterceptorProvider);

  return ChatServiceClient(channel, interceptors: [authInterceptor]);
});

/// feature: DM Channel
final directMessageServiceClientProvider = Provider<DirectMessageServiceClient>(
  (ref) {
    final channel = ref.watch(apiClientProvider).channel;
    final authInterceptor = ref.watch(authInterceptorProvider);
    final errorInterceptor = ref.watch(errorInterceptorProvider);

    return DirectMessageServiceClient(
      channel,
      interceptors: [authInterceptor, errorInterceptor],
      options: CallOptions(timeout: Duration(seconds: 5)),
    );
  },
);

/// feature: User
final userServiceClientProvider = Provider<UserServiceClient>((ref) {
  final channel = ref.watch(apiClientProvider).channel;
  final authInterceptor = ref.watch(authInterceptorProvider);
  final errorInterceptor = ref.watch(errorInterceptorProvider);

  return UserServiceClient(
    channel,
    interceptors: [authInterceptor, errorInterceptor],
  );
});

final userAuthServiceClientProvider = Provider<AuthServiceClient>((ref) {
  final channel = ref.watch(apiClientProvider).channel;
  final authInterceptor = ref.watch(authInterceptorProvider);
  final errorInterceptor = ref.watch(errorInterceptorProvider);

  return AuthServiceClient(
    channel,
    interceptors: [authInterceptor, errorInterceptor],
  );
});

/// feature: Friend
final friendServiceClientProvider = Provider<FriendServiceClient>((ref) {
  final channel = ref.watch(apiClientProvider).channel;
  final authInterceptor = ref.watch(authInterceptorProvider);
  final errorInterceptor = ref.watch(errorInterceptorProvider);

  return FriendServiceClient(
    channel,
    interceptors: [authInterceptor, errorInterceptor],
  );
});

/// feature: Relationship
final relationshipServiceClientProvider = Provider<RelationshipServiceClient>((
  ref,
) {
  final channel = ref.watch(apiClientProvider).channel;
  final authInterceptor = ref.watch(authInterceptorProvider);
  final errorInterceptor = ref.watch(errorInterceptorProvider);

  return RelationshipServiceClient(
    channel,
    interceptors: [authInterceptor, errorInterceptor],
  );
});

/// feature: Voice
final signalingServiceClientProvider =
    Provider.family<SignalingServiceClient, int>((ref, channelId) {
      final channel = ref.watch(signalingClientProvider).channel;
      final authInterceptor = ref.watch(authInterceptorProvider);

      final CallOptions options = CallOptions(
        metadata: {"channel_id": channelId.toString()},
      );

      ref.onDispose(() => channel.shutdown());

      return SignalingServiceClient(
        channel,
        options: options,
        interceptors: [authInterceptor],
      );
    });
