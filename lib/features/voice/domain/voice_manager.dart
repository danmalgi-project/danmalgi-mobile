import 'package:danmalgi_mobile/features/voice/domain/voice_state.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

abstract interface class VoiceManager {
  Future<void> join();

  Future<void> toggleMicMute(bool mute);

  Future<List<MediaDeviceInfo>> getAudioOutputs();

  Future<void> selectAudioOutput(String deviceId);

  Stream<VoiceState> get stateStream;

  Future<void> dispose();
}
