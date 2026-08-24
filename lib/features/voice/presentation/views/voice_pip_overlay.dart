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

class _VoicePipOverlayState extends ConsumerState<VoicePipOverlay>
    with SingleTickerProviderStateMixin {
  static const _snapDuration = Duration(milliseconds: 260);
  static const _snapCurve = Curves.easeOutCubic;

  late final AnimationController _snap = AnimationController(
    vsync: this,
    duration: _snapDuration,
  );

  Offset? _dragOffset;
  Animation<Offset>? _snapAnimation;

  @override
  void initState() {
    super.initState();
    _snap.addListener(() {
      final animation = _snapAnimation;
      if (animation == null) return;
      setState(() => _dragOffset = animation.value);
    });
  }

  @override
  void dispose() {
    _snap.dispose();
    super.dispose();
  }

  void _onPanStart(Rect rect) {
    _snap.stop();
    _snapAnimation = null;
    _dragOffset = rect.topLeft;
  }

  void _onPanUpdate(DragUpdateDetails details) {
    final current = _dragOffset;
    if (current == null) return;
    setState(() => _dragOffset = current + details.delta);
  }

  void _settle(
    Size screenSize,
    EdgeInsets padding, {
    Offset velocity = Offset.zero,
  }) {
    final dragged = _dragOffset;
    if (dragged == null) return;

    final from = voicePipRect(
      screenSize: screenSize,
      padding: padding,
      offset: dragged,
    ).topLeft;

    final target = snapVoicePipToEdge(
      rect: Rect.fromLTWH(from.dx, from.dy, kVoicePipSize, kVoicePipSize),
      screenSize: screenSize,
      padding: padding,
      velocity: velocity,
    );

    // 최종 위치는 먼저 확정. _dragOffset이 화면상으로만 따라간다.
    ref.read(voicePipOffsetProvider.notifier).update(target);

    final animation = Tween(
      begin: from,
      end: target,
    ).animate(CurvedAnimation(parent: _snap, curve: _snapCurve));
    _snapAnimation = animation;

    _snap.forward(from: 0.0).whenCompleteOrCancel(() {
      // 새 드래그가 끼어들어 취소된 경우엔 그쪽 상태를 건드리지 않는다.
      if (!mounted || _snapAnimation != animation) return;
      setState(() {
        _dragOffset = null;
        _snapAnimation = null;
      });
    });
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
            onPanEnd: (d) => _settle(
              screenSize,
              padding,
              velocity: d.velocity.pixelsPerSecond,
            ),
            onPanCancel: () => _settle(screenSize, padding),
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
