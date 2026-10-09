import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:logging/logging.dart';

class IceCandidateBuffer {
  static final _log = Logger('voice.IceCandidateBuffer');

  final List<RTCIceCandidate> _pending = [];
  bool _hasRemoteDescription = false;

  List<RTCIceCandidate> add(RTCIceCandidate candidate) {
    if (_hasRemoteDescription) {
      return [candidate];
    }
    _pending.add(candidate);
    _log.fine('⏳ candidate 대기 (remoteDescription 아직 없음)');
    return [];
  }

  List<RTCIceCandidate> onRemoteDescriptionSet() {
    if (_pending.isNotEmpty) {
      _log.fine('🚀 대기 중이던 candidate ${_pending.length}개 반영');
    }

    _hasRemoteDescription = true;

    final candidates = List<RTCIceCandidate>.from(_pending);
    _pending.clear();

    return candidates;
  }
}
