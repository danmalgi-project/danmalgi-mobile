import 'package:danmalgi_mobile/features/voice/domain/voice_state.dart';

abstract interface class VoiceManager {
  Future<void> join();

  Future<void> toggleMicMute(bool mute);

  Stream<VoiceState> get stateStream;

  Future<void> dispose();
}
