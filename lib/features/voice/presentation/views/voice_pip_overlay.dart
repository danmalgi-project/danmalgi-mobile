import 'package:danmalgi_mobile/features/voice/data/providers/active_voice_session_provider.dart';
import 'package:danmalgi_mobile/features/voice/presentation/geometry/voice_pip_geometry.dart';
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

  void _onPanStart(Rect rect) {
    _dragOffset = rect.topLeft;
  }

  void _onPanUpdate(DragUpdateDetails details) {
    final current = _dragOffset;
    if (current == null) return;
    setState(() => _dragOffset = current + details.delta);
  }

  void _onPanEnd(Size screenSize, EdgeInsets padding) {
    final dragged = _dragOffset;
    if (dragged == null) return;

    final rect = voicePipRect(
      screenSize: screenSize,
      padding: padding,
      offset: dragged,
    );

    ref
        .read(voicePipOffsetProvider.notifier)
        .update(
          snapVoicePipToEdge(
            rect: rect,
            screenSize: screenSize,
            padding: padding,
          ),
        );
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
            onPanStart: (_) => _onPanStart(rect),
            onPanUpdate: _onPanUpdate,
            onPanEnd: (_) => _onPanEnd(screenSize, padding),
            onPanCancel: () => _onPanEnd(screenSize, padding),
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
