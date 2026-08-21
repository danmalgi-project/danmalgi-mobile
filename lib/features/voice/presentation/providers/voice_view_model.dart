import 'dart:async';

import 'package:danmalgi_mobile/core/providers/app_user_provider.dart';
import 'package:danmalgi_mobile/features/user/domain/user.dart';
import 'package:danmalgi_mobile/features/voice/data/providers/voice_manager_provider.dart';
import 'package:danmalgi_mobile/features/voice/domain/voice_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'voice_view_model.g.dart';

@riverpod
class VoiceViewModel extends _$VoiceViewModel {
  StreamSubscription<VoiceState>? subscription;
  Timer? _gracePeriodTimer;

  static const _gracePeriod = Duration(seconds: 8);

  @override
  FutureOr<VoiceState> build({required int channelId}) async {
    final currentUser = ref.watch(currentUserProvider);
    final repo = ref.watch(voiceManagerProvider(channelId: channelId));

    // 로그아웃 시 채널 자동 퇴장
    if (currentUser == null) {
      return const VoiceState();
    }

    // stream 구독
    final subscription = repo.stateStream.listen((voiceState) {
      _handleStatusChange(voiceState.status);
      state = AsyncData(
        voiceState.copyWith(
          currentUser: currentUser,
          users: voiceState.users.where((u) => u.id != currentUser.id).toList(),
        ),
      );
    });

    ref.onDispose(() {
      subscription.cancel();
      _gracePeriodTimer?.cancel();
    });

    await repo.join();
    return const VoiceState();
  }

  Future<List<MediaDeviceInfo>> getAudioOutputs() {
    final repo = ref.read(voiceManagerProvider(channelId: channelId));
    return repo.getAudioOutputs();
  }

  Future<void> selectAudioOutput(String deviceId) {
    final repo = ref.read(voiceManagerProvider(channelId: channelId));
    return repo.selectAudioOutput(deviceId);
  }

  void _handleStatusChange(VoiceConnectionStatus status) {
    final isBad =
        status == VoiceConnectionStatus.unstable ||
        status == VoiceConnectionStatus.failed;

    if (!isBad) {
      _gracePeriodTimer?.cancel();
      _gracePeriodTimer = null;
      return;
    }

    _gracePeriodTimer ??= Timer(_gracePeriod, () {
      final current = state.value;
      if (current == null) return;
      state = AsyncData(current.copyWith(terminated: true));
    });
  }

  Future<void> toggleMicMute() async {
    final currentState = state.requireValue;
    final isMuted = !currentState.isMuted;

    // 1. 실제 마이크 on/off
    final repo = ref.read(voiceManagerProvider(channelId: channelId));
    await repo.toggleMicMute(isMuted);

    // 2. 상태 반영
    state = AsyncData(currentState.copyWith(isMuted: isMuted));
  }
}
