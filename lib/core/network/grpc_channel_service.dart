import 'package:grpc/grpc.dart';

class GrpcChannelService {
  final String host;
  final int port;
  final ClientKeepAliveOptions? keepAlive;

  late ClientChannel _channel;

  GrpcChannelService({required this.host, required this.port, this.keepAlive}) {
    _channel = ClientChannel(
      host,
      port: port,
      options: ChannelOptions(
        // credentials: ChannelCredentials.insecure(),
        credentials: const ChannelCredentials.secure(),
        connectionTimeout: const Duration(seconds: 5),
        keepAlive: keepAlive ?? const ClientKeepAliveOptions(),
      ),
    );
  }

  ClientChannel get channel => _channel;

  Future<void> shutdown() async {
    await _channel.shutdown();
    print('client shut down.');
  }
}
