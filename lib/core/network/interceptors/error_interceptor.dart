import 'dart:async';

import 'package:danmalgi_mobile/core/error/app_exception.dart';
import 'package:grpc/grpc.dart';
import 'package:grpc/service_api.dart';
import 'package:async/async.dart';

class ErrorInterceptor implements ClientInterceptor {
  final void Function() logout;
  final Duration timeout;

  ErrorInterceptor({
    required this.logout,
    this.timeout = const Duration(seconds: 5),
  });

  // TODO: Error Handling
  @override
  ResponseStream<R> interceptStreaming<Q, R>(
    ClientMethod<Q, R> method,
    Stream<Q> requests,
    CallOptions options,
    ClientStreamingInvoker<Q, R> invoker,
  ) {
    return invoker(method, requests, options);
  }

  @override
  ResponseFuture<R> interceptUnary<Q, R>(
    ClientMethod<Q, R> method,
    Q request,
    CallOptions options,
    ClientUnaryInvoker<Q, R> invoker,
  ) {
    final mergedOptions = options.mergedWith(CallOptions(timeout: timeout));

    return DelegatingResponseFuture<R>(
      invoker(method, request, mergedOptions),
    ).catchError((Object error) {
      if (error is GrpcError) {
        if (error.code == StatusCode.unauthenticated) {
          logout();
          throw const AppException.unauthenticated();
        }

        if (error.code == StatusCode.deadlineExceeded) {
          throw const AppException.timeout();
        }
      }

      throw const AppException.network();
    });
  }
}

class DelegatingResponseFuture<R> extends DelegatingFuture<R>
    implements ResponseFuture<R> {
  Response responseDelegate;

  DelegatingResponseFuture.split(
    this.responseDelegate,
    Future<R> futureDelegate,
  ) : super(futureDelegate);

  DelegatingResponseFuture(ResponseFuture<R> delegate)
    : this.split(delegate, delegate);

  // @override
  // ResponseStream<R> asStream() =>
  //     DelegatingResponseStream.split(responseDelegate, super.asStream());

  @override
  ResponseFuture<R> catchError(
    Function onError, {
    bool Function(Object error)? test,
  }) => DelegatingResponseFuture.split(
    responseDelegate,
    super.catchError(onError, test: test),
  );

  @override
  ResponseFuture<S> then<S>(
    FutureOr<S> Function(R) onValue, {
    Function? onError,
  }) => DelegatingResponseFuture.split(
    responseDelegate,
    super.then(onValue, onError: onError),
  );

  @override
  ResponseFuture<R> whenComplete(FutureOr Function() action) =>
      DelegatingResponseFuture.split(
        responseDelegate,
        super.whenComplete(action),
      );

  @override
  ResponseFuture<R> timeout(
    Duration timeLimit, {
    FutureOr<R> Function()? onTimeout,
  }) => DelegatingResponseFuture.split(
    responseDelegate,
    super.timeout(timeLimit, onTimeout: onTimeout),
  );

  @override
  Future<void> cancel() {
    return responseDelegate.cancel();
  }

  @override
  Future<Map<String, String>> get headers => responseDelegate.headers;

  @override
  Future<Map<String, String>> get trailers => responseDelegate.trailers;
}
