import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:danmalgi_mobile/core/providers/network_provider.dart';
import 'package:danmalgi_mobile/features/voice/data/repositories/voice_repository.dart';

final voiceRepositoryProvider = Provider.autoDispose
    .family<VoiceRepository, int>((ref, channelId) {
      final client = ref.read(voiceServiceClientProvider(channelId));
      final repository = VoiceRepository(client, channelId: channelId);

      ref.onDispose(() {
        print('🗑️ VoiceRepository dispose (channelId: $channelId)');
        repository.dispose();
      });

      return repository;
    });
