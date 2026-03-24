import 'dart:async';

import 'package:grpc/grpc.dart';

// TODO: 필요할 떄 활성화 예정
// const Set<String> publicRoutes = {'/pb.AuthService/Authorization', '/pb.UserService/GetUserByToken'};

class AuthInterceptor implements ClientInterceptor {
  final String? Function() getToken;
  AuthInterceptor({required this.getToken});

  @override
  ResponseStream<R> interceptStreaming<Q, R>(
    ClientMethod<Q, R> method,
    Stream<Q> requests,
    CallOptions options,
    ClientStreamingInvoker<Q, R> invoker,
  ) {
    final String? token = getToken();
    
    if (token != null && token.isNotEmpty) {
      options = options.mergedWith(
        CallOptions(metadata: {'authorization': 'Bearer $token'}),
      );
    }

    return invoker(method, requests, options);
  }

  @override
  ResponseFuture<R> interceptUnary<Q, R>(
    ClientMethod<Q, R> method,
    Q request,
    CallOptions options,
    ClientUnaryInvoker<Q, R> invoker,
  ) {
    final String? token = getToken();
    
    if (token != null && token.isNotEmpty) {
      options = options.mergedWith(
        CallOptions(metadata: {'authorization': 'Bearer $token'}),
      );
    }
    
    return invoker(method, request, options);
  }
}
