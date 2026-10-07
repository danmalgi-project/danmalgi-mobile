import 'package:danmalgi_mobile/features/voice/domain/voice_state.dart';
import 'package:danmalgi_mobile/features/voice/presentation/providers/voice_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'active_voice_session_provider.g.dart';

@Riverpod(keepAlive: true)
class ActiveVoiceSession extends _$ActiveVoiceSession {
  ProviderSubscription<AsyncValue<VoiceState>>? _subscription;

  @override
  int? build() => null;

  void start(int channelId) {
    if (state == channelId) return;

    end();

    print("Voice Started !");
    _subscription = ref.listen(
      voiceViewModelProvider(channelId: channelId),
      (_, _) {},
    );

    state = channelId;
  }

  void end() {
    print("Voice Ended !");
    _subscription?.close();
    _subscription = null;
    state = null;
  }
}
