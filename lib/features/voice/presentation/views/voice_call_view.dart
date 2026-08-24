import 'package:danmalgi_mobile/features/voice/data/providers/active_voice_session_provider.dart';
import 'package:danmalgi_mobile/features/voice/presentation/geometry/voice_call_metrics.dart';
import 'package:danmalgi_mobile/features/voice/presentation/geometry/voice_call_morph.dart';
import 'package:danmalgi_mobile/features/voice/presentation/providers/voice_pip_offset_provider.dart';
import 'package:danmalgi_mobile/features/voice/presentation/widgets/voice_call_controls.dart';
import 'package:danmalgi_mobile/features/voice/presentation/widgets/voice_call_header.dart';
import 'package:danmalgi_mobile/features/voice/presentation/widgets/voice_participant_grid.dart';
import 'package:danmalgi_mobile/features/voice/presentation/widgets/voice_pip_bubble.dart';
import 'package:danmalgi_mobile/features/voice/presentation/widgets/voice_pip_rect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const kVoiceHeaderHeight = 72.0;
const kVoiceControlsHeight = 84.0;

class VoiceCallView extends ConsumerStatefulWidget {
  const VoiceCallView({super.key, required this.channelId});

  final int channelId;

  @override
  ConsumerState<VoiceCallView> createState() => _VoiceCallViewState();
}

class _VoiceCallViewState extends ConsumerState<VoiceCallView> {
  ModalRoute<void>? _route;
  VoiceCallMorph _morph = const VoiceCallMorph.open();

  NavigatorState? _gestureNavigator;
  AnimationStatusListener? _settleListener;

  AnimationController get _controller => _route!.controller!;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _route = ModalRoute.of(context) as ModalRoute<void>?;
  }

  @override
  void dispose() {
    // settle 애니메이션 도중에 라우트가 제거되면 리스너가 발화하지 못하므로
    // 여기서 제스처를 직접 닫아준다.
    _endUserGesture();
    super.dispose();
  }

  void _beginUserGesture() {
    final navigator = Navigator.of(context);
    _gestureNavigator = navigator;
    navigator.didStartUserGesture();
  }

  /// 멱등. 대기 중인 리스너를 떼고 didStopUserGesture를 정확히 한 번 부른다.
  void _endUserGesture() {
    final navigator = _gestureNavigator;
    if (navigator == null) return;
    _gestureNavigator = null;

    final listener = _settleListener;
    if (listener != null) {
      _settleListener = null;
      _route?.controller?.removeStatusListener(listener);
    }

    navigator.didStopUserGesture();
  }

  void _onDragStart(DragStartDetails details) {
    _beginUserGesture();
    setState(() => _morph = const VoiceCallMorph.sliding());
  }

  void _onDragUpdate(DragUpdateDetails details) {
    _controller.value -=
        details.primaryDelta! / VoiceCallMetrics.of(context).travel;
  }

  void _onDragEnd(DragEndDetails details) {
    final travel = VoiceCallMetrics.of(context).travel;
    final velocity = -details.velocity.pixelsPerSecond.dy / travel;

    _settle(
      keepOpen: velocity.abs() >= 1.0
          ? velocity > 0
          : _controller.value > kVoiceKeepOpenThreshold,
    );
  }

  void _onDragCancel() {
    _settle(keepOpen: _controller.value > kVoiceKeepOpenThreshold);
  }

  void _settle({required bool keepOpen}) {
    if (keepOpen) {
      _animateOpen();
    } else {
      _anchorAndClose();
    }

    if (_controller.isAnimating) {
      _settleListener = (_) => _endUserGesture();
      _controller.addStatusListener(_settleListener!);
    } else {
      _endUserGesture();
    }
  }

  void _animateOpen() {
    _controller
        .animateTo(
          1.0,
          duration: kVoiceSettleDuration,
          curve: kVoiceSettleCurve,
        )
        .whenCompleteOrCancel(() {
          if (!mounted || _controller.value != 1.0) return;
          setState(() => _morph = const VoiceCallMorph.open());
        });
  }

  void _anchorAndClose() {
    final metrics = VoiceCallMetrics.of(context);
    final value = _controller.value;

    final anchor = metrics.fullBody.translate(0, (1 - value) * metrics.travel);

    setState(() {
      _morph = VoiceCallMorph.anchored(
        anchor: anchor,
        t: value,
        chrome: metrics.chromeOpacityAt(anchor),
      );
    });

    if (_route?.isCurrent ?? false) Navigator.of(context).pop();

    if (_controller.isAnimating) {
      _controller.animateBack(
        0.0,
        duration: kVoiceSettleDuration,
        curve: kVoiceSettleCurve,
      );
    }
  }

  void _closeImmediately() {
    final route = _route;
    if (route == null || !route.isActive) return;

    final navigator = Navigator.of(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!route.isActive) return;
      navigator.popUntil((r) => r == route);
      navigator.removeRoute(route);
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(activeVoiceSessionProvider, (_, next) {
      if (next != widget.channelId) _closeImmediately();
    });
    if (ref.watch(activeVoiceSessionProvider) != widget.channelId) {
      return const SizedBox.shrink();
    }

    final metrics = VoiceCallMetrics.of(context);
    final pipRect = voicePipRect(
      screenSize: MediaQuery.sizeOf(context),
      padding: MediaQuery.paddingOf(context),
      offset: ref.watch(voicePipOffsetProvider),
    );

    final navigator = Navigator.of(context);
    final animation = _route!.animation!;

    return Material(
      type: MaterialType.transparency,
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, _) {
          final raw = animation.value;
          final t = navigator.userGestureInProgress
              ? raw
              : kVoiceSettleCurve.transform(raw);

          final frame = _morph.resolve(
            t: t,
            metrics: metrics,
            pipRect: pipRect,
          );

          return Stack(
            children: [
              IgnorePointer(
                child: Opacity(
                  opacity: frame.chromeOpacity,
                  child: const ColoredBox(color: Color(0xFF1C1C1E)),
                ),
              ),
              _buildMorphingBody(
                frame: frame,
                fullBody: metrics.fullBody,
                interactive: raw == 1.0 || navigator.userGestureInProgress,
              ),
              _ChromeSlot(
                frame: frame,
                edge: VoiceChromeEdge.top,
                child: VoiceCallHeader(channelId: widget.channelId),
              ),
              _ChromeSlot(
                frame: frame,
                edge: VoiceChromeEdge.bottom,
                child: VoiceCallControls(channelId: widget.channelId),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMorphingBody({
    required VoiceCallFrame frame,
    required Rect fullBody,
    required bool interactive,
  }) {
    return Positioned.fromRect(
      rect: frame.body,
      child: IgnorePointer(
        ignoring: !interactive,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onVerticalDragStart: _onDragStart,
          onVerticalDragUpdate: _onDragUpdate,
          onVerticalDragEnd: _onDragEnd,
          onVerticalDragCancel: _onDragCancel,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(frame.cornerRadius),
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (frame.gridOpacity > 0)
                  IgnorePointer(
                    child: Opacity(
                      opacity: frame.gridOpacity,
                      // 축소 중에도 그리드는 원래 크기로 그린 뒤 잘라낸다
                      child: OverflowBox(
                        alignment: Alignment.topCenter,
                        minWidth: fullBody.width,
                        maxWidth: fullBody.width,
                        minHeight: fullBody.height,
                        maxHeight: fullBody.height,
                        child: VoiceParticipantGrid(
                          channelId: widget.channelId,
                        ),
                      ),
                    ),
                  ),
                if (frame.avatarOpacity > 0)
                  IgnorePointer(
                    child: Opacity(
                      opacity: frame.avatarOpacity,
                      child: const VoicePipBubble(),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum VoiceChromeEdge { top, bottom }

class _ChromeSlot extends StatelessWidget {
  const _ChromeSlot({
    required this.frame,
    required this.edge,
    required this.child,
  });

  final VoiceCallFrame frame;
  final VoiceChromeEdge edge;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isTop = edge == VoiceChromeEdge.top;

    // 헤더는 위로, 컨트롤 바는 아래로 — 각자 가장 가까운 화면 밖으로 빠진다.
    final dy = isTop ? -frame.chromeSlide : frame.chromeSlide;

    return Positioned(
      top: isTop ? 0 : null,
      bottom: isTop ? null : 0,
      left: 0,
      right: 0,
      child: IgnorePointer(
        ignoring: !frame.chromeInteractive,
        child: Opacity(
          opacity: frame.chromeOpacity,
          child: Transform.translate(offset: Offset(0, dy), child: child),
        ),
      ),
    );
  }
}
