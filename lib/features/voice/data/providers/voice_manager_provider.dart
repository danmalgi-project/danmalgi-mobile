import 'package:danmalgi_mobile/core/providers/app_user_provider.dart';
import 'package:danmalgi_mobile/features/voice/data/managers/voice_manager_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:danmalgi_mobile/core/providers/network_provider.dart';
import 'package:danmalgi_mobile/features/voice/domain/voice_manager.dart';

part 'voice_manager_provider.g.dart';

@riverpod
VoiceManager voiceManager(Ref ref, {required int channelId}) {
  final client = ref.watch(signalingServiceClientProvider(channelId));
  final repo = VoiceManagerImpl(client, channelId: channelId);
  ref.onDispose(() => repo.dispose());
  return repo;
}
