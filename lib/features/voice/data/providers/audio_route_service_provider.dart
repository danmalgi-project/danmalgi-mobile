import 'package:danmalgi_mobile/features/voice/data/services/audio_route_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'audio_route_service_provider.g.dart';

@Riverpod(keepAlive: true)
AudioRouteService audioRouteService(Ref ref) => AudioRouteService();
