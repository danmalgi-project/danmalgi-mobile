import 'package:flutter_webrtc/flutter_webrtc.dart';

enum AudioOutputKind { speaker, earpiece, bluetooth, wired, unknown }

typedef AudioOutput = ({String id, AudioOutputKind kind, String label});

/// 기기 단위 오디오 출력 제어 (Android: flutter_webrtc AudioSwitch 경유)
class AudioRouteService {
  Future<List<AudioOutput>> outputs() async {
    final devices = await Helper.audiooutputs;
    return [
      for (final d in devices)
        (id: d.deviceId, kind: _kindOf(d.deviceId), label: d.label),
    ];
  }

  Future<void> select(String id) => Helper.selectAudioOutput(id);

  static AudioOutputKind _kindOf(String id) => switch (id) {
    'speaker' => AudioOutputKind.speaker,
    'earpiece' => AudioOutputKind.earpiece,
    'bluetooth' => AudioOutputKind.bluetooth,
    'wired-headset' => AudioOutputKind.wired,
    _ => AudioOutputKind.unknown,
  };
}
