import 'package:grpc/grpc.dart';
import 'package:logging/logging.dart';

class GrpcLoggingInterceptor implements ClientInterceptor {
  static final _log = Logger('grpc');

  @override
  ResponseStream<R> interceptStreaming<Q, R>(
    ClientMethod<Q, R> method,
    Stream<Q> requests,
    CallOptions options,
    ClientStreamingInvoker<Q, R> invoker,
  ) {
    _log.fine('${method.path} 스트림 시작');
    return invoker(method, requests, options);
  }

  @override
  ResponseFuture<R> interceptUnary<Q, R>(
    ClientMethod<Q, R> method,
    Q request,
    CallOptions options,
    ClientUnaryInvoker<Q, R> invoker,
  ) {
    final sw = Stopwatch()..start();
    final response = invoker(method, request, options);

    response.then(
      (_) => _log.fine('${method.path} ${sw.elapsedMilliseconds}ms'),
      onError: (Object e, StackTrace st) =>
          _log.warning('${method.path} 실패 ${sw.elapsedMilliseconds}ms', e),
    );

    return response;
  }
}
