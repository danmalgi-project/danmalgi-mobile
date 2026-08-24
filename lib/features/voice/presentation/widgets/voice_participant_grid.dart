import 'package:danmalgi_mobile/core/theme/app_colors.dart';
import 'package:danmalgi_mobile/features/voice/domain/voice_state.dart';
import 'package:danmalgi_mobile/features/voice/presentation/providers/voice_view_model.dart';
import 'package:danmalgi_mobile/features/voice/presentation/widgets/voice_participant_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VoiceParticipantGrid extends ConsumerWidget {
  const VoiceParticipantGrid({super.key, required this.channelId});
  final int channelId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final voiceAsync = ref.watch(voiceViewModelProvider(channelId: channelId));

    return switch (voiceAsync) {
      AsyncLoading() => const Center(child: CircularProgressIndicator()),
      AsyncError(:final error) => Center(child: Text('연결 실패: $error')),
      AsyncData(:final value) => _Grid(state: value),
    };
  }
}

class _Grid extends StatelessWidget {
  const _Grid({required this.state});
  final VoiceState state;

  static const _spacing = 16.0;
  static const _horizontalPadding = 20.0;
  static const _columns = 2;

  @override
  Widget build(BuildContext context) {
    final participants = state.participants;

    return LayoutBuilder(
      builder: (context, constraints) {
        final available = constraints.maxWidth - _horizontalPadding * 2;
        final itemSize = (available - _spacing * (_columns - 1)) / _columns;

        return Container(
          color: const Color(0xFF1C1C1E),
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: _horizontalPadding,
          ),
          child: Wrap(
            spacing: _spacing,
            runSpacing: _spacing,
            children: [
              for (final (index, user) in participants.indexed)
                SizedBox(
                  width: _slotWidth(index, participants.length, itemSize),
                  height: itemSize,
                  child: VoiceParticipantTile(
                    user: user,
                    isMuted: state.isMuted && user.id == state.currentUser?.id,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  /// 참가자 수가 홀수면 마지막 타일이 한 줄을 다 쓴다.
  double _slotWidth(int index, int count, double itemSize) =>
      count.isOdd && index == count - 1 ? itemSize * 2 + _spacing : itemSize;
}
