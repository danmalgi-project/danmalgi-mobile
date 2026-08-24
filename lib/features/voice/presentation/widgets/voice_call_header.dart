import 'package:danmalgi_mobile/features/directmessage/data/providers/direct_message_channel_provider.dart';
import 'package:danmalgi_mobile/features/voice/domain/voice_state.dart';
import 'package:danmalgi_mobile/features/voice/presentation/providers/voice_view_model.dart';
import 'package:danmalgi_mobile/features/voice/presentation/widgets/voice_connection_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VoiceCallHeader extends ConsumerWidget {
  const VoiceCallHeader({super.key, required this.channelId});
  final int channelId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final channelName = ref.watch(
      directMessageChannelProvider(
        channelId: channelId,
      ).select((async) => async.value?.channelName ?? ''),
    );
    final status = ref.watch(
      voiceViewModelProvider(channelId: channelId).select(
        (async) => switch (async) {
          AsyncLoading() => VoiceConnectionStatus.connecting,
          AsyncError() => VoiceConnectionStatus.failed,
          AsyncData(:final value) => value.status,
        },
      ),
    );

    return SafeArea(
      bottom: false,
      child: Container(
        color: Color(0xFF1C1C1E),
        padding: const EdgeInsets.fromLTRB(20, 12, 12, 12),
        child: Row(
          children: [
            Expanded(child: _TitleBlock(channelName: channelName)),
            VoiceConnectionBadge(status: status),
          ],
        ),
      ),
    );
  }
}

class _TitleBlock extends StatelessWidget {
  final String channelName;

  const _TitleBlock({required this.channelName});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          channelName,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
              width: 8,
              height: 8,
            ),
            const SizedBox(width: 6),
            const Text(
              "REC · 12:34",
              style: TextStyle(
                color: Color(0xFF8E8E93),
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
