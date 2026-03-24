import 'dart:async';

import 'package:collection/collection.dart';
import 'package:danmalgi_mobile/features/user/domain/user.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'package:danmalgi_mobile/core/generated/signaling.pbgrpc.dart';

class VoiceRepository {
  final SignalingServiceClient client;

  final int channelId;

  final Map<String, dynamic> configuration = {
    'iceServers': [
      {
        'urls': ['stun:stun.l.google.com:19302'],
      },
    ],
    'sdpSemantics': 'unified-plan',
    'bundlePolicy': 'max-bundle',
    'rtcpMuxPolicy': 'require',
  };

  final Map<String, dynamic> audioConstraints = {
    'audio': {
      'echoCancellation': true,
      'noiseSuppression': false,
      'autoGainControl': false,
      // 'sampleRate': 48000,
      // 'sampleSize': 16,
      'channelCount': 2,
      'latency': 0.01,
    },
  };

  final localRenderer = RTCVideoRenderer();

  RTCPeerConnection? peerConnection;
  StreamSubscription<SignalingResponse>? responseStreamSubscription;
  StreamController<SignalingRequest> requestStreamController =
      StreamController.broadcast();

  StreamController<String> statusStreamController =
      StreamController.broadcast();

  StreamController<List<User>> userStreamController =
      StreamController.broadcast();

  double lastTimestamp = 0;
  int lastBytes = 0;

  VoiceRepository(this.client, {required this.channelId});

  Future<void> printWebRTCStats() async {
    try {
      final statsReport = await peerConnection!.getStats();

      // statsReport.forEachIndexed((id, stats) {
      //   if (stats.type == "inbound-rtp") {
      //     if (lastTimestamp != 0) {
      //       final bitrate =
      //           (8 * (stats.values['bytesReceived'] - lastBytes)) /
      //           (stats.timestamp - lastTimestamp) *
      //           1000;
      //       print('--- Stats Report for ID: $id (Type: ${stats.type}) ---');
      //       print('Timestamp: ${stats.timestamp}');
      //       print('Original Bytes: ${stats.values['bytesReceived']}');
      //       print('Audio bitrate: ${bitrate.toStringAsFixed(2)} kbps');
      //       // stats.values.forEach((key, value) {
      //       //   print('$key: $value');
      //       // });
      //       print('----------------------------------------------------');
      //     }
      //     lastBytes = stats.values['bytesReceived'];
      //     lastTimestamp = stats.timestamp;
      //   }
      // });

      statsReport.forEachIndexed((id, stats) {
        if (stats.type == "inbound-rtp") {
          print('--- Stats Report for ID: $id (Type: ${stats.type}) ---');
          print('Timestamp: ${stats.timestamp}');
          print('Original Bytes: ${stats.values['bytesReceived']}');
          stats.values.forEach((key, value) {
            print('$key: $value');
          });
          print('----------------------------------------------------');
        }
      });
    } catch (e) {
      print('Error fetching WebRTC stats: $e');
    }
  }

  Future<void> setupPeerConnection() async {
    peerConnection = await createPeerConnection(configuration);

    await setupUserAudio();

    peerConnection!.onIceCandidate = (candidate) =>
        _handleOnIcdeCandidate(candidate);
    peerConnection!.onConnectionState = (state) =>
        _handleOnConnectionState(state);
    peerConnection!.onIceGatheringState = (state) =>
        _handleOnIceGatheringState(state);
    peerConnection!.onIceConnectionState = (state) =>
        _handleOnIceConnectionState(state);
    peerConnection!.onRemoveStream = (stream) => _handleOnRemoveStream;

    // Transceiver 설정으로 비트레이트 제어
    final transceivers = await peerConnection!.getTransceivers();
    for (var transceiver in transceivers) {
      if (transceiver.sender.track?.kind == 'audio') {
        final parameters = transceiver.sender.parameters;

        // 비트레이트 설정
        if (parameters.encodings!.isNotEmpty) {
          parameters.encodings![0].maxBitrate = 128000; // 128 kbps
          parameters.encodings![0].minBitrate = 64000; // 최소 64 kbps
        }

        await transceiver.sender.setParameters(parameters);
      }
    }

    responseStreamSubscription = client
        .signaling(requestStreamController.stream)
        .listen(
          _handleOnSignalListen,
          onDone: () {
            print("OnDone");
          },
          onError: (e) {
            print("Error $e");
          },
        );
  }

  Future<void> setupUserAudio() async {
    await localRenderer.initialize();

    // final localStream = await navigator.mediaDevices.getUserMedia({
    //   'audio': true,
    //   'video': false,
    // });
    final localStream = await navigator.mediaDevices.getUserMedia(
      audioConstraints,
    );
    localRenderer.srcObject = localStream;

    localStream.getTracks().forEach((track) async {
      await peerConnection!.addTrack(track, localStream);
    });
  }

  void _handleOnIcdeCandidate(RTCIceCandidate candidate) {
    final Candidate candidateData = Candidate(
      candidate: candidate.candidate,
      sdpMid: candidate.sdpMid,
      sdpMlineIndex: candidate.sdpMLineIndex,
    );

    final SignalingRequest request = SignalingRequest(
      signalingRequestInfo: SignalingRequestInfo(candidate: candidateData),
    );

    requestStreamController.add(request);
    print('Signal Sent: ${request.signalingRequestInfo}');
  }

  void _handleOnConnectionState(RTCPeerConnectionState state) {
    print('Peer Connection State: $state');

    if (state == RTCPeerConnectionState.RTCPeerConnectionStateConnected) {
      statusStreamController.add('✅ Peer 연결 완료!');
      print('✅ Peer 연결 완료!');
    }
  }

  void _handleOnIceGatheringState(RTCIceGatheringState state) {
    print('ICE Gathering State: $state');
  }

  void _handleOnIceConnectionState(RTCIceConnectionState state) {
    print('ICE Connection State: $state');

    switch (state) {
      case RTCIceConnectionState.RTCIceConnectionStateConnected:
        statusStreamController.add('✅ WebRTC 연결 완료!');
        print('✅ WebRTC 연결 완료!');
        // UI 업데이트 또는 연결 완료 처리
        break;
      case RTCIceConnectionState.RTCIceConnectionStateCompleted:
        statusStreamController.add('✅ WebRTC 연결 완전히 완료!');
        print('✅ WebRTC 연결 완전히 완료!');
        break;
      case RTCIceConnectionState.RTCIceConnectionStateFailed:
        statusStreamController.add('❌ 연결 실패');
        print('❌ 연결 실패');
        break;
      case RTCIceConnectionState.RTCIceConnectionStateDisconnected:
        statusStreamController.add('⚠️ 연결 끊김');
        print('⚠️ 연결 끊김');
        break;
      default:
        break;
    }
  }

  void _handleOnRemoveStream(MediaStream stream) {
    print(stream.id);
  }

  Future<void> _handleOnSignalListen(SignalingResponse response) async {
    final info = response.signalingResponseInfo;
    // print('Signal Received: ${data.signalingType}');
    // final parsed = jsonDecode(data.value);

    switch (info.whichMessage()) {
      case SignalingResponseInfo_Message.candidate:
        print('📥 Candidate 수신');
        statusStreamController.add('📥 Candidate 수신');

        final Candidate candidateData = info.candidate;

        final candidate = RTCIceCandidate(
          candidateData.candidate,
          candidateData.sdpMid,
          candidateData.sdpMlineIndex,
        );

        await peerConnection!.addCandidate(candidate);
        break;

      case SignalingResponseInfo_Message.answer:
        break;

      case SignalingResponseInfo_Message.offer:
        final Offer offer = info.offer;

        // print("Offer 수신: $offerData");

        if (offer.hasJoinedUserTracks()) {
          // TODO: 추후 track 처리 필요 (현재는 user 정보만 사용)
          final List<UserTrack> userTracks = offer.joinedUserTracks.userTracks
              .toList();

          final List<User> users = userTracks
              .map((userTrack) => User.fromProto(userTrack.user))
              .toList();
          userStreamController.add(users);
          print('사용자 참여: ${users}');
        }

        // List<String> lines = offerData.sdp.split('\r\n');
        // List<String> newLines = [];

        // for (var line in lines) {
        //   newLines.add(line);

        //   if (line.contains('a=rtpmap:') && line.contains('opus')) {
        //     final payloadType = line.split(':')[1].split(' ')[0];

        //     newLines.add('a=ptime:10');
        //     newLines.add('a=maxptime:10');

        //     final fmtpLine =
        //         'a=fmtp:$payloadType '
        //         'minptime=10;'
        //         'maxptime=10;'
        //         'useinbandfec=1;'
        //         'usedtx=0';

        //     newLines = newLines
        //         .where((l) => !l.contains('a=fmtp:$payloadType'))
        //         .toList();

        //     newLines.add(fmtpLine);
        //   }
        // }

        // final sdp = newLines.join('\r\n');

        await peerConnection!.setRemoteDescription(
          RTCSessionDescription(offer.sdp.sdpData, offer.sdp.sdpType),
        );

        RTCSessionDescription answer = await peerConnection!.createAnswer();

        // RTCSessionDescription optimizedAnswer = RTCSessionDescription(
        //   optimizedAnswerSdp,
        //   answer.type,
        // );

        await peerConnection!.setLocalDescription(answer);

        requestStreamController.add(
          SignalingRequest(
            signalingRequestInfo: SignalingRequestInfo(
              answer: Answer(
                sdp: SessionDescription(
                  sdpType: answer.type,
                  sdpData: answer.sdp,
                ),
              ),
            ),
          ),
        );
        break;

      case SignalingResponseInfo_Message.notSet:
        break;
    }
  }

  void dispose() {
    localRenderer.srcObject = null;
    localRenderer.dispose();

    peerConnection!.close();
    peerConnection!.dispose();

    requestStreamController.close();

    responseStreamSubscription?.cancel();
    responseStreamSubscription = null;

    statusStreamController.close();
    userStreamController.close();
  }
}
