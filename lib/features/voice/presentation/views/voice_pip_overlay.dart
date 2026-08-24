import 'package:danmalgi_mobile/features/voice/data/providers/active_voice_session_provider.dart';
import 'package:danmalgi_mobile/features/voice/presentation/providers/voice_call_animation_provider.dart';
import 'package:danmalgi_mobile/features/voice/presentation/providers/voice_pip_offset_provider.dart';
import 'package:danmalgi_mobile/features/voice/presentation/routes/voice_call_route.dart';
import 'package:danmalgi_mobile/features/voice/presentation/widgets/voice_pip_bubble.dart';
import 'package:danmalgi_mobile/features/voice/presentation/widgets/voice_pip_rect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VoicePipOverlay extends ConsumerStatefulWidget {
  const VoicePipOverlay({super.key});

  @override
  ConsumerState<VoicePipOverlay> createState() => _VoicePipOverlayState();
}

class _VoicePipOverlayState extends ConsumerState<VoicePipOverlay> {
  Offset? _dragOffset;

  void _onPanUpdate(DragUpdateDetails details, Rect rect) {
    setState(() => _dragOffset = rect.topLeft + details.delta);
  }

  void _onPanEnd(Size screenSize, EdgeInsets padding, Rect rect) {
    final current = rect.topLeft;
    final centerX = current.dx + kVoicePipSize / 2;
    final centerY = current.dy + kVoicePipSize / 2;

    final distLeft = centerX;
    final distRight = screenSize.width - centerX;
    final distTop = centerY - padding.top;
    final distBottom = screenSize.height - padding.bottom - centerY;

    final minDist = [
      distLeft,
      distRight,
      distTop,
      distBottom,
    ].reduce((a, b) => a < b ? a : b);

    final Offset snapped;
    if (minDist == distLeft) {
      snapped = Offset(kVoicePipMargin, current.dy);
    } else if (minDist == distRight) {
      snapped = Offset(
        screenSize.width - kVoicePipSize - kVoicePipMargin,
        current.dy,
      );
    } else if (minDist == distTop) {
      snapped = Offset(current.dx, padding.top + kVoicePipMargin);
    } else {
      snapped = Offset(
        current.dx,
        screenSize.height - padding.bottom - kVoicePipSize - kVoicePipMargin,
      );
    }

    ref.read(voicePipOffsetProvider.notifier).update(snapped);
    setState(() => _dragOffset = null);
  }

  @override
  Widget build(BuildContext context) {
    final channelId = ref.watch(activeVoiceSessionProvider);
    if (channelId == null) return const SizedBox.shrink();

    final screenSize = MediaQuery.sizeOf(context);
    final padding = MediaQuery.paddingOf(context);
    final callAnimation = ref.watch(voiceCallAnimationProvider);
    final savedOffset = ref.watch(voicePipOffsetProvider);

    final rect = voicePipRect(
      screenSize: screenSize,
      padding: padding,
      offset: _dragOffset ?? savedOffset,
    );

    return AnimatedBuilder(
      animation: callAnimation ?? kAlwaysDismissedAnimation,
      builder: (context, _) {
        if ((callAnimation?.value ?? 0.0) > 0.0) return const SizedBox.shrink();

        return Positioned.fromRect(
          rect: rect,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => openVoiceCall(ref, channelId),
            onPanUpdate: (d) => _onPanUpdate(d, rect),
            onPanEnd: (_) => _onPanEnd(screenSize, padding, rect),
            onPanCancel: () => _onPanEnd(screenSize, padding, rect),
            child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(20),
              clipBehavior: Clip.antiAlias,
              color: const Color(0xFF1C1C1E),
              child: const VoicePipBubble(),
            ),
          ),
        );
      },
    );
  }
}
