import 'package:danmalgi_mobile/core/theme/app_colors.dart';
import 'package:danmalgi_mobile/features/voice/data/providers/active_voice_session_provider.dart';
import 'package:danmalgi_mobile/features/voice/domain/voice_state.dart';
import 'package:danmalgi_mobile/features/voice/presentation/providers/voice_view_model.dart';
import 'package:danmalgi_mobile/features/voice/presentation/widgets/audio_output_sheet.dart';
import 'package:danmalgi_mobile/features/voice/presentation/widgets/voice_control_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VoiceCallControls extends ConsumerWidget {
  const VoiceCallControls({super.key, required this.channelId});
  final int channelId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = voiceViewModelProvider(channelId: channelId);
    final isReady = ref.watch(
      provider.select((a) => a is AsyncData<VoiceState>),
    );
    final isMuted = ref.watch(
      provider.select((a) => a.value?.isMuted ?? false),
    );
    final notifier = ref.read(provider.notifier);

    return SafeArea(
      top: false,
      child: Container(
        // color: VoiceColors.controlBar,
        color: Color(0xFF111112),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 12,
          children: [
            VoiceControlButton(
              icon: isMuted ? Icons.mic_off : Icons.mic_none_rounded,
              foreground: isMuted ? AppColors.danger : AppColors.textPrimary,
              onTap: isReady ? notifier.toggleMicMute : null,
            ),
            VoiceControlButton(
              icon: Icons.videocam_outlined,
              onTap: isReady ? () {} : null,
            ),
            VoiceControlButton(
              icon: Icons.speaker_group_outlined,
              onTap: isReady
                  ? () => showAudioOutputSheet(context, ref, channelId)
                  : null,
            ),
            VoiceControlButton(
              icon: Icons.phone_disabled_outlined,
              background: Color(0xFFFF2121),
              onTap: isReady
                  ? () => ref.read(activeVoiceSessionProvider.notifier).end()
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
