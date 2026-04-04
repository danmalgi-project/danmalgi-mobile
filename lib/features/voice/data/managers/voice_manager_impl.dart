// data/repositories/voice_repository_impl.dart

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:danmalgi_mobile/core/generated/signaling/v1/signaling.pbgrpc.dart';
import 'package:danmalgi_mobile/features/user/domain/user.dart';
import 'package:danmalgi_mobile/features/voice/domain/voice_manager.dart';
import 'package:danmalgi_mobile/features/voice/domain/voice_state.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class VoiceManagerImpl implements VoiceManager {
  final SignalingServiceClient _client;
  final int channelId;

  // StreamController가 하나로 줄어듦
  final _stateController = StreamController<VoiceState>.broadcast();
  final _requestController = StreamController<SignalingRequest>();

  VoiceState _currentState = const VoiceState();

  StreamSubscription<SignalingResponse>? _subscription;
  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;

  Timer? _audioLevelTimer;
  static const double _speakingThreshold = 0.02;

  @override
  Stream<VoiceState> get stateStream => _stateController.stream;

  VoiceManagerImpl(this._client, {required this.channelId});

  // 상태 업데이트 헬퍼 — 항상 이걸 통해서만 상태 변경
  void _emit(VoiceState Function(VoiceState current) updater) {
    _currentState = updater(_currentState);
    _stateController.add(_currentState);
  }

  @override
  Future<void> join() async {
    _localStream = await _getLocalAudioStream();
    await _setupPeerConnection();

    _subscription = _client
        .signaling(_requestController.stream)
        .listen(_handleSignalingResponse, onError: _handleError);
  }

  @override
  Future<void> toggleMicMute(bool mute) async {
    _localStream?.getAudioTracks().forEach((track) {
      track.enabled = !mute; // false = 음소거
    });
  }

  Future<void> _setupPeerConnection() async {
    _peerConnection = await createPeerConnection({
      'iceServers': [
        {
          'urls': ['stun:stun.l.google.com:19302'],
        },
      ],
      'sdpSemantics': 'unified-plan',
    });

    _localStream?.getTracks().forEach((track) {
      _peerConnection!.addTrack(track, _localStream!);
    });

    _peerConnection!.onIceCandidate = _handleIceCandidate;
    _peerConnection!.onTrack = _handleOnTrack;
    _peerConnection!.onConnectionState = _handleConnectionState;
    _peerConnection!.onIceConnectionState = _handleIceConnectionState;
  }

  void _handleIceCandidate(RTCIceCandidate candidate) {
    _requestController.add(
      SignalingRequest(
        signalingRequestInfo: SignalingRequestInfo(
          candidate: Candidate(
            candidate: candidate.candidate,
            sdpMid: candidate.sdpMid,
            sdpMlineIndex: candidate.sdpMLineIndex,
          ),
        ),
      ),
    );
  }

  void _handleOnTrack(RTCTrackEvent event) {
    final trackId = event.track.id;
    final user = _currentState.trackUserMap[trackId];
    print('🔊 트랙 수신: $trackId → ${user?.name ?? "알 수 없음"}');
  }

  void _handleConnectionState(RTCPeerConnectionState state) {
    _emit(
      (s) => s.copyWith(
        statusMessage: state.name,
        isConnected:
            state == RTCPeerConnectionState.RTCPeerConnectionStateConnected,
      ),
    );

    if (state == RTCPeerConnectionState.RTCPeerConnectionStateConnected) {
      _startVAD(); // ← 연결 완료 시점에 시작
    }
  }

  void _startVAD() {
    _audioLevelTimer?.cancel();
    _audioLevelTimer = Timer.periodic(
      const Duration(milliseconds: 250),
      (_) => _checkAudioLevels(),
    );
  }

  Future<void> _checkAudioLevels() async {
    if (_peerConnection == null) return;

    try {
      final speakingIds = <int>{};

      // 1. 내 목소리 — sender의 media-source stats
      await _checkLocalAudioLevel(speakingIds);

      // 2. 상대방 목소리 — inbound-rtp stats
      await _checkRemoteAudioLevels(speakingIds);

      // 변경됐을 때만 emit
      if (!_setEquals(speakingIds, _currentState.speakingUserIds)) {
        _emit((s) => s.copyWith(speakingUserIds: speakingIds));
      }
    } catch (e) {
      print('VAD 오류: $e');
    }
  }

  Future<void> _checkLocalAudioLevel(Set<int> speakingIds) async {
    if (_currentState.isMuted) return;

    final senders = await _peerConnection!.getSenders();
    final audioSender = senders.firstWhereOrNull(
      (s) => s.track?.kind == 'audio',
    );
    if (audioSender == null) return;

    final stats = await audioSender.getStats();
    for (final report in stats) {
      if (report.type == 'media-source') {
        final level = (report.values['audioLevel'] as num?)?.toDouble() ?? 0.0;
        // print('🎙 내 오디오 레벨: $level');

        final isSpeaking = level > _speakingThreshold;

        // 상태 바뀔 때만 emit
        if (isSpeaking != _currentState.isSpeaking) {
          _emit((s) => s.copyWith(isSpeaking: isSpeaking));
        }
        break;
      }
    }
  }

  Future<void> _checkRemoteAudioLevels(Set<int> speakingIds) async {
    final stats = await _peerConnection!.getStats();

    for (StatsReport report in stats) {
      if (report.type == 'inbound-rtp') {
        final level = (report.values['audioLevel'] as num?)?.toDouble();
        final trackId = report.values['trackIdentifier'] as String?;

        // print('📥 상대방 오디오 레벨: $level, trackId: $trackId');

        if (level == null || trackId == null) return;
        if (level <= _speakingThreshold) return;

        final user = _currentState.trackUserMap[trackId];
        if (user != null) {
          speakingIds.add(user.id);
        }
      }
    }
  }

  bool _setEquals(Set<int> a, Set<int> b) {
    if (a.length != b.length) return false;
    return a.containsAll(b);
  }

  void _handleIceConnectionState(RTCIceConnectionState state) {
    switch (state) {
      case RTCIceConnectionState.RTCIceConnectionStateConnected:
        _emit((s) => s.copyWith(statusMessage: '✅ WebRTC 연결 완료'));
        break;
      case RTCIceConnectionState.RTCIceConnectionStateFailed:
        _emit((s) => s.copyWith(statusMessage: '❌ 연결 실패', isConnected: false));
        break;
      case RTCIceConnectionState.RTCIceConnectionStateDisconnected:
        _emit((s) => s.copyWith(statusMessage: '⚠️ 연결 끊김', isConnected: false));
        break;
      default:
        break;
    }
  }

  Future<void> _handleSignalingResponse(SignalingResponse response) async {
    final info = response.signalingResponseInfo;

    switch (info.whichMessage()) {
      case SignalingResponseInfo_Message.offer:
        await _handleOffer(info.offer);
        break;
      case SignalingResponseInfo_Message.candidate:
        await _handleCandidate(info.candidate);
        break;
      case SignalingResponseInfo_Message.answer:
        // SFU에서는 클라이언트가 Answer를 받는 케이스는 없음
        break;
      case SignalingResponseInfo_Message.notSet:
        break;
    }
  }

  Future<void> _handleOffer(Offer offer) async {
    // trackUserMap 업데이트
    if (offer.hasJoinedUserTracks()) {
      final updatedMap = Map<String, User>.from(_currentState.trackUserMap);
      final users = <User>[];

      for (final userTrack in offer.joinedUserTracks.userTracks) {
        final user = User.fromProto(userTrack.user);
        updatedMap[userTrack.trackId] = user;
        users.add(user);
      }

      _emit(
        (s) => s.copyWith(
          trackUserMap: updatedMap,
          users: users,
          statusMessage: '👥 참여자 업데이트: ${users.length}명',
        ),
      );
    }

    await _peerConnection!.setRemoteDescription(
      RTCSessionDescription(offer.sdp.sdpData, offer.sdp.sdpType),
    );

    final answer = await _peerConnection!.createAnswer();
    await _peerConnection!.setLocalDescription(answer);

    _requestController.add(
      SignalingRequest(
        signalingRequestInfo: SignalingRequestInfo(
          answer: Answer(
            sdp: SessionDescription(sdpType: answer.type, sdpData: answer.sdp),
          ),
        ),
      ),
    );

    _emit((s) => s.copyWith(statusMessage: '📤 Answer 전송 완료'));
  }

  Future<void> _handleCandidate(Candidate candidateData) async {
    await _peerConnection!.addCandidate(
      RTCIceCandidate(
        candidateData.candidate,
        candidateData.sdpMid,
        candidateData.sdpMlineIndex,
      ),
    );
    _emit((s) => s.copyWith(statusMessage: '📥 ICE Candidate 수신'));
  }

  void _handleError(dynamic error) {
    _emit((s) => s.copyWith(statusMessage: '❌ 오류: $error', isConnected: false));
  }

  Future<MediaStream> _getLocalAudioStream() async {
    return navigator.mediaDevices.getUserMedia({
      'audio': {
        'echoCancellation': true,
        'noiseSuppression': false,
        'autoGainControl': false,
        'channelCount': 2,
      },
      'video': false,
    });
  }

  @override
  Future<void> dispose() async {
    _audioLevelTimer?.cancel();
    _audioLevelTimer = null;

    await _subscription?.cancel();
    _subscription = null;
    await _requestController.close();

    _localStream?.getTracks().forEach((t) => t.stop());
    await _localStream?.dispose();
    _localStream = null;

    await _peerConnection?.close();
    _peerConnection?.dispose();
    _peerConnection = null;

    await _stateController.close();
  }
}
