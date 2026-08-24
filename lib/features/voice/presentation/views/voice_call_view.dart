import 'dart:ui' as ui;

import 'package:danmalgi_mobile/core/widgets/cached_circle_avatar.dart';
import 'package:danmalgi_mobile/features/directmessage/data/providers/direct_message_channel_provider.dart';
import 'package:danmalgi_mobile/features/voice/data/providers/active_voice_session_provider.dart';
import 'package:danmalgi_mobile/features/voice/domain/voice_state.dart';
import 'package:danmalgi_mobile/features/voice/presentation/providers/voice_pip_offset_provider.dart';
import 'package:danmalgi_mobile/features/voice/presentation/providers/voice_view_model.dart';
import 'package:danmalgi_mobile/features/voice/presentation/widgets/voice_pip_bubble.dart';
import 'package:danmalgi_mobile/features/voice/presentation/widgets/voice_pip_rect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const kVoiceHeaderHeight = 72.0;
const kVoiceControlsHeight = 84.0;

const _chromeFadeDistance = 80.0;

const _crossfadeFraction = 0.5;

const _keepOpenThreshold = 0.7;
const _settleDuration = Duration(milliseconds: 280);
const _settleCurve = Curves.easeOutCubic;

class VoiceCallView extends ConsumerStatefulWidget {
  const VoiceCallView({super.key, required this.channelId});

  final int channelId;

  @override
  ConsumerState<VoiceCallView> createState() => _VoiceCallViewState();
}

class _VoiceCallViewState extends ConsumerState<VoiceCallView> {
  ModalRoute<void>? _route;

  bool _sliding = false;
  Rect? _morphAnchor; // null이면 fullBodyRect
  double _morphAnchorT = 1.0;
  double _morphAnchorChrome = 1.0;

  AnimationController get _controller => _route!.controller!;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _route = ModalRoute.of(context) as ModalRoute<void>?;
  }

  ({Rect fullBody, double travel}) _metrics(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final padding = MediaQuery.paddingOf(context);
    final top = padding.top + kVoiceHeaderHeight;
    final bottom = padding.bottom + kVoiceControlsHeight;

    return (
      fullBody: Rect.fromLTWH(
        0,
        top,
        screenSize.width,
        screenSize.height - top - bottom,
      ),
      travel: screenSize.height - top,
    );
  }

  double _chromeOpacityFor(double dy) =>
      (1 - dy / _chromeFadeDistance).clamp(0.0, 1.0);

  void _onDragStart(DragStartDetails details) {
    Navigator.of(context).didStartUserGesture();
    setState(() => _sliding = true);
  }

  void _onDragUpdate(DragUpdateDetails details) {
    _controller.value -= details.primaryDelta! / _metrics(context).travel;
  }

  void _onDragEnd(DragEndDetails details) {
    final velocity =
        -details.velocity.pixelsPerSecond.dy / _metrics(context).travel;
    _settle(
      keepOpen: velocity.abs() >= 1.0
          ? velocity > 0
          : _controller.value > _keepOpenThreshold,
    );
  }

  void _onDragCancel() {
    _settle(keepOpen: _controller.value > _keepOpenThreshold);
  }

  void _resetMorph() {
    _sliding = false;
    _morphAnchor = null;
    _morphAnchorT = 1.0;
    _morphAnchorChrome = 1.0;
  }

  void _settle({required bool keepOpen}) {
    final navigator = Navigator.of(context);

    if (keepOpen) {
      _controller
          .animateTo(1.0, duration: _settleDuration, curve: _settleCurve)
          .whenCompleteOrCancel(() {
            if (!mounted || _controller.value != 1.0) return;
            setState(_resetMorph);
          });
    } else {
      final metrics = _metrics(context);
      final value = _controller.value;
      final anchor = metrics.fullBody.translate(
        0,
        (1 - value) * metrics.travel,
      );

      setState(() {
        _sliding = false;
        _morphAnchor = anchor;
        _morphAnchorT = value;
        _morphAnchorChrome = _chromeOpacityFor(
          anchor.top - metrics.fullBody.top,
        );
      });

      if (_route?.isCurrent ?? false) navigator.pop();
      if (_controller.isAnimating) {
        _controller.animateBack(
          0.0,
          duration: _settleDuration,
          curve: _settleCurve,
        );
      }
    }

    if (_controller.isAnimating) {
      late final AnimationStatusListener callback;
      callback = (_) {
        navigator.didStopUserGesture();
        _controller.removeStatusListener(callback);
      };
      _controller.addStatusListener(callback);
    } else {
      navigator.didStopUserGesture();
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

    final activeChannelId = ref.watch(activeVoiceSessionProvider);
    if (activeChannelId != widget.channelId) return const SizedBox.shrink();

    final screenSize = MediaQuery.sizeOf(context);
    final padding = MediaQuery.paddingOf(context);
    final metrics = _metrics(context);
    final fullBodyRect = metrics.fullBody;

    final pipRect = voicePipRect(
      screenSize: screenSize,
      padding: padding,
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
              : _settleCurve.transform(raw);

          final Rect bodyRect;
          final double chromeOpacity;
          final double avatarOpacity;

          if (_sliding) {
            bodyRect = fullBodyRect.translate(0, (1 - t) * metrics.travel);
            chromeOpacity = _chromeOpacityFor(bodyRect.top - fullBodyRect.top);
            avatarOpacity = 0.0;
          } else {
            final anchor = _morphAnchor ?? fullBodyRect;
            final k = _morphAnchorT <= 0
                ? 1.0
                : (t / _morphAnchorT).clamp(0.0, 1.0);

            bodyRect = Rect.lerp(pipRect, anchor, k)!;
            avatarOpacity = ((1 - k) / _crossfadeFraction).clamp(0.0, 1.0);
            chromeOpacity =
                _morphAnchorChrome *
                ((k - (1 - _crossfadeFraction)) / _crossfadeFraction).clamp(
                  0.0,
                  1.0,
                );
          }

          final gridOpacity = 1 - avatarOpacity;
          final radius = ui.lerpDouble(0.0, 20.0, avatarOpacity)!;
          final chromeIgnoring = chromeOpacity < 0.5;
          final interactive = raw == 1.0 || navigator.userGestureInProgress;

          return Stack(
            children: [
              IgnorePointer(
                child: Opacity(
                  opacity: chromeOpacity,
                  child: Container(color: const Color(0xFF1C1C1E)),
                ),
              ),

              Positioned.fromRect(
                rect: bodyRect,
                child: IgnorePointer(
                  ignoring: !interactive,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onVerticalDragStart: _onDragStart,
                    onVerticalDragUpdate: _onDragUpdate,
                    onVerticalDragEnd: _onDragEnd,
                    onVerticalDragCancel: _onDragCancel,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(radius),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          if (gridOpacity > 0)
                            Opacity(
                              opacity: gridOpacity,
                              child: IgnorePointer(
                                child: OverflowBox(
                                  alignment: Alignment.topCenter,
                                  minWidth: fullBodyRect.width,
                                  maxWidth: fullBodyRect.width,
                                  minHeight: fullBodyRect.height,
                                  maxHeight: fullBodyRect.height,
                                  child: _VoiceBodyOf(
                                    channelId: widget.channelId,
                                  ),
                                ),
                              ),
                            ),
                          if (avatarOpacity > 0)
                            IgnorePointer(
                              child: Opacity(
                                opacity: avatarOpacity,
                                child: const VoicePipBubble(),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: IgnorePointer(
                  ignoring: chromeIgnoring,
                  child: Opacity(
                    opacity: chromeOpacity,
                    child: Transform.translate(
                      offset: Offset(0, -20 * (1 - chromeOpacity)),
                      child: _VoiceHeader(channelId: widget.channelId),
                    ),
                  ),
                ),
              ),

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: IgnorePointer(
                  ignoring: chromeIgnoring,
                  child: Opacity(
                    opacity: chromeOpacity,
                    child: Transform.translate(
                      offset: Offset(0, -20 * (1 - chromeOpacity)),
                      child: _VoiceControlsSection(channelId: widget.channelId),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _VoiceHeader extends ConsumerWidget {
  const _VoiceHeader({required this.channelId});
  final int channelId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final channelAsync = ref.watch(
      directMessageChannelProvider(channelId: channelId),
    );
    final voiceAsync = ref.watch(voiceViewModelProvider(channelId: channelId));

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 12.0, 12.0, 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    channelAsync.value?.channelName ?? '',
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
              ),
            ),
            _StatusBanner(voiceAsync: voiceAsync),
          ],
        ),
      ),
    );
  }
}

class _VoiceControlsSection extends ConsumerWidget {
  const _VoiceControlsSection({required this.channelId});
  final int channelId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final voiceAsync = ref.watch(voiceViewModelProvider(channelId: channelId));
    final notifier = ref.read(
      voiceViewModelProvider(channelId: channelId).notifier,
    );

    return SafeArea(
      top: false,
      child: _VoiceControls(voiceAsync: voiceAsync, notifier: notifier),
    );
  }
}

class _VoiceBodyOf extends ConsumerWidget {
  const _VoiceBodyOf({required this.channelId});
  final int channelId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final voiceAsync = ref.watch(voiceViewModelProvider(channelId: channelId));

    return switch (voiceAsync) {
      AsyncLoading() => const Center(child: CircularProgressIndicator()),
      AsyncError(:final error) => Center(child: Text('연결 실패: $error')),
      AsyncData(:final value) => _VoiceBody(state: value, channelId: channelId),
    };
  }
}

class _VoiceBody extends ConsumerWidget {
  const _VoiceBody({required this.state, required this.channelId});
  final VoiceState state;
  final int channelId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allUsers = [
      if (state.currentUser != null) state.currentUser!,
      ...state.users,
    ];

    return Container(
      color: Colors.transparent,
      child: LayoutBuilder(
        builder: (context, constraints) {
          const spacing = 16.0;
          const crossAxisCount = 2;
          const horizontalPadding = 20.0;

          final availableWidth = constraints.maxWidth - horizontalPadding * 2;
          final itemSize =
              (availableWidth - spacing * (crossAxisCount - 1)) /
              crossAxisCount;

          final itemProfileSize = itemSize * 0.25;

          return Container(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: horizontalPadding,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color(0xFF1C1C1E),
            ),
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: spacing,
              runSpacing: spacing,
              children: [
                for (var i = 0; i < allUsers.length; i++)
                  SizedBox(
                    width: (allUsers.length.isOdd && i == allUsers.length - 1)
                        ? itemSize * 2 + spacing
                        : itemSize,
                    height: itemSize,
                    child: Material(
                      color: const Color(0xFF161618),
                      borderRadius: BorderRadius.circular(18.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              CachedCircleAvatar(
                                url: allUsers[i].imageUrl,
                                radius: itemProfileSize,
                                backgroundColor: Colors.transparent,
                              ),
                              if (state.isMuted)
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Material(
                                    clipBehavior: Clip.antiAlias,
                                    shape: CircleBorder(),
                                    color: Colors.red,
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Icon(
                                        Icons.mic_off_outlined,
                                        size: itemSize * 0.075,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            allUsers[i].name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _StatusBanner extends StatelessWidget {
  const _StatusBanner({required this.voiceAsync});
  final AsyncValue voiceAsync;

  @override
  Widget build(BuildContext context) {
    return switch (voiceAsync) {
      AsyncLoading() => _banner(VoiceConnectionStatus.connecting),
      AsyncError() => _banner(VoiceConnectionStatus.failed),
      AsyncData(:final value) => _banner(value.status),
    };
  }

  Widget _banner(VoiceConnectionStatus status) {
    final (label, color) = switch (status) {
      VoiceConnectionStatus.connecting => ('연결 중', Colors.grey),
      VoiceConnectionStatus.connected => ('연결 양호', Color(0xFF30D158)),
      VoiceConnectionStatus.unstable => ('연결 불안정', Colors.orange),
      VoiceConnectionStatus.failed => ('연결 실패', Colors.red),
    };

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color(0xFF161618),
      ),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Text(label, style: TextStyle(color: color)),
    );
  }
}

class _VoiceControls extends ConsumerWidget {
  const _VoiceControls({required this.voiceAsync, required this.notifier});

  final AsyncValue<VoiceState> voiceAsync;
  final VoiceViewModel notifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isReady = voiceAsync is AsyncData<VoiceState>;
    final isMuted = voiceAsync.value?.isMuted ?? false;

    return Container(
      color: Color(0xFF111112),
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 52,
            height: 52,
            child: Material(
              color: Color(0xFF272729),
              shape: CircleBorder(),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: isReady ? notifier.toggleMicMute : null,
                child: Icon(
                  isMuted ? Icons.mic_off : Icons.mic_none_rounded,
                  color: isMuted ? Colors.red : Colors.white,
                  size: 20.0,
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          SizedBox(
            width: 52,
            height: 52,
            child: Material(
              color: Color(0xFF272729),
              shape: CircleBorder(),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: isReady ? () {} : null,
                child: Icon(Icons.videocam_outlined, size: 20.0),
              ),
            ),
          ),
          SizedBox(width: 12),
          SizedBox(
            width: 52,
            height: 52,
            child: Material(
              color: Color(0xFF272729),
              shape: CircleBorder(),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: isReady ? () {} : null,
                child: Icon(Icons.monitor, size: 20.0),
              ),
            ),
          ),
          SizedBox(width: 12),
          SizedBox(
            width: 52,
            height: 52,
            child: Material(
              color: Color(0xFF272729),
              shape: CircleBorder(),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                // TODO: 화면공유 구현 시 원래 monitor 버튼으로 되돌리기
                onTap: isReady
                    ? () => _showAudioOutputPicker(context, notifier)
                    : null,
                child: Icon(Icons.speaker_group_outlined, size: 20.0),
              ),
            ),
          ),
          SizedBox(width: 12),
          SizedBox(
            width: 52,
            height: 52,
            child: Material(
              color: Color(0xFFFF2121),
              shape: CircleBorder(),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: isReady
                    ? () {
                        ref.read(activeVoiceSessionProvider.notifier).end();
                      }
                    : null,
                child: Icon(Icons.phone_disabled_outlined, size: 20.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _showAudioOutputPicker(
  BuildContext context,
  VoiceViewModel notifier,
) async {
  final devices = await notifier.getAudioOutputs();
  if (!context.mounted) return;

  showModalBottomSheet(
    context: context,
    backgroundColor: const Color(0xFF1C1C1E),
    builder: (sheetContext) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final device in devices)
            ListTile(
              leading: const Icon(Icons.volume_up, color: Colors.white70),
              title: Text(
                device.label,
                style: const TextStyle(color: Colors.white),
              ),
              onTap: () {
                notifier.selectAudioOutput(device.deviceId);
                Navigator.pop(sheetContext);
              },
            ),
        ],
      ),
    ),
  );
}
