import 'package:grpc/grpc.dart';

class GrpcChannelService {
  final String host;
  final int port;

  late ClientChannel _channel;

  GrpcChannelService({required this.host, required this.port}) {
    _channel = ClientChannel(
      host,
      port: port,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
        connectionTimeout: Duration(seconds: 5),
        // keepAlive: ClientKeepAliveOptions(),
      ),
    );
  }

  ClientChannel get channel => _channel;

  Future<void> shutdown() async {
    await _channel.shutdown();
    print('client shut down.');
  }
}
