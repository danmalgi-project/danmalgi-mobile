import 'dart:async';

import 'package:danmalgi_mobile/core/providers/app_user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:danmalgi_mobile/features/voice/data/providers/voice_provider.dart';
import 'package:danmalgi_mobile/features/voice/data/repositories/voice_repository.dart';
import 'package:danmalgi_mobile/features/voice/domain/voice_state.dart';

final voiceViewModelProvider =
    AsyncNotifierProvider.autoDispose<VoiceViewModel, VoiceState>(
      VoiceViewModel.new,
    );

class VoiceViewModel extends AsyncNotifier<VoiceState> {
  late final VoiceRepository repository;

  @override
  FutureOr<VoiceState> build() async {
    ref.watch(currentUserProvider); // Bind lifecycle to auth state

    repository = ref.watch(voiceRepositoryProvider(5));

    ref.onDispose(() {
      print('🗑️ VoiceViewModel dispose (channel: 5)');
      // repository.dispose();
    });

    return VoiceState();
  }

  Future<void> connect() async {
    repository.setupPeerConnection();
  }

  Future<void> disconnect() async {
    final repository = ref.watch(voiceRepositoryProvider(5));
    repository.dispose();
  }
}
