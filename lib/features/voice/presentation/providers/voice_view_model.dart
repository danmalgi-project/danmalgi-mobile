import 'dart:async';

import 'package:danmalgi_mobile/core/providers/app_user_provider.dart';
import 'package:danmalgi_mobile/features/user/domain/user.dart';
import 'package:danmalgi_mobile/features/voice/data/providers/voice_manager_provider.dart';
import 'package:danmalgi_mobile/features/voice/domain/voice_state.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'voice_view_model.g.dart';

@riverpod
class VoiceViewModel extends _$VoiceViewModel {
  StreamSubscription<VoiceState>? subscription;

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
      state = AsyncData(
        voiceState.copyWith(
          currentUser: currentUser,
          users: voiceState.users.where((u) => u.id != currentUser.id).toList(),
        ),
      );
    });

    ref.onDispose(() {
      subscription.cancel();
    });

    await repo.join();
    return const VoiceState();
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
