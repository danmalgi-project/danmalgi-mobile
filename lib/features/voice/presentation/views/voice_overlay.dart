import 'dart:ui' as ui;

import 'package:danmalgi_mobile/core/providers/app_user_provider.dart';
import 'package:danmalgi_mobile/core/widgets/cached_circle_avatar.dart';
import 'package:danmalgi_mobile/features/directmessage/data/providers/direct_message_channel_provider.dart';
import 'package:danmalgi_mobile/features/voice/data/providers/active_voice_session_provider.dart';
import 'package:danmalgi_mobile/features/voice/domain/voice_state.dart';
import 'package:danmalgi_mobile/features/voice/presentation/providers/voice_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VoiceOverlay extends ConsumerStatefulWidget {
  const VoiceOverlay({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VoiceOverlayState();
}

class _VoiceOverlayState extends ConsumerState<VoiceOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  static const _bubbleSize = 108.0;
  static const _bubbleMargin = 16.0;

  static const _commitDuration = Duration(milliseconds: 280);
  static const _collapseDistanceFactor = 0.3;
  static const _chromeFadeDistance = 80.0;

  bool _isOpen = true;
  bool _isCollapseDragging = false;
  double _dragTranslateY = 0.0;

  Animation<Rect?>? _commitRectAnim;
  bool _commitToOpen = true;

  Offset _bubbleDragOffset = Offset.zero;
  bool _isPipDrag = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onCollapseDragStart() {
    _isCollapseDragging = true;
    _dragTranslateY = 0.0;
  }

  void _onCollapseDragUpdate(DragUpdateDetails details, Size screenSize) {
    setState(() {
      _dragTranslateY = (_dragTranslateY + details.delta.dy).clamp(
        0.0,
        screenSize.height,
      );
    });
  }

  void _onCollapseDragEnd(
    DragEndDetails details,
    Size screenSize,
    Rect fullBodyRect,
    Rect effectiveBubbleRect,
  ) {
    final collapseDistance = screenSize.height * _collapseDistanceFactor;
    final toOpen = _dragTranslateY < collapseDistance;
    final currentRect = fullBodyRect.translate(0, _dragTranslateY);

    setState(() => _isCollapseDragging = false);
    _commitTo(toOpen, currentRect, fullBodyRect, effectiveBubbleRect);
  }

  void _commitTo(bool toOpen, Rect currentRect, Rect openRect, Rect pipRect) {
    final tween = RectTween(
      begin: currentRect,
      end: toOpen ? openRect : pipRect,
    );

    setState(() {
      _commitToOpen = toOpen;
      _commitRectAnim = tween.animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
      );
    });

    _controller
      ..value = 0.0
      ..animateTo(1.0, duration: _commitDuration).then((_) {
        if (!mounted) return;
        setState(() {
          _isOpen = toOpen;
          _commitRectAnim = null;
        });
      });
  }

  void _onBubblePanUpdate(
    DragUpdateDetails details,
    Rect bubbleRect,
    Size screenSize,
    EdgeInsets padding,
  ) {
    setState(() {
      final next = _bubbleDragOffset + details.delta;
      final minDx = _bubbleMargin - bubbleRect.left;
      final maxDx =
          screenSize.width - _bubbleMargin - _bubbleSize - bubbleRect.left;
      final minDy = padding.top + _bubbleMargin - bubbleRect.top;
      final maxDy =
          screenSize.height -
          padding.bottom -
          _bubbleMargin -
          _bubbleSize -
          bubbleRect.top;

      _bubbleDragOffset = Offset(
        next.dx.clamp(minDx, maxDx),
        next.dy.clamp(minDy, maxDy),
      );
    });
  }

  void _onBubblePanEnd(Rect bubbleRect, Size screenSize, EdgeInsets padding) {
    final current = bubbleRect.shift(_bubbleDragOffset);
    final centerX = current.left + _bubbleSize / 2;
    final centerY = current.top + _bubbleSize / 2;

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

    setState(() {
      double newLeft = current.left;
      double newTop = current.top;
      if (minDist == distLeft) {
        newLeft = _bubbleMargin;
      } else if (minDist == distRight) {
        newLeft = screenSize.width - _bubbleSize - _bubbleMargin;
      } else if (minDist == distTop) {
        newTop = padding.top + _bubbleMargin;
      } else {
        newTop =
            screenSize.height - padding.bottom - _bubbleSize - _bubbleMargin;
      }

      _bubbleDragOffset = Offset(
        newLeft - bubbleRect.left,
        newTop - bubbleRect.top,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final channelId = ref.watch(activeVoiceSessionProvider);
    if (channelId == null) return const SizedBox.shrink();

    final screenSize = MediaQuery.sizeOf(context);
    final padding = MediaQuery.paddingOf(context);

    // 헤더/컨트롤 실제 높이 근사치 (Rect 계산용)
    final headerHeight = padding.top + 72.0;
    final controlsHeight = padding.bottom + 84.0;

    // 풀스크린일 때 바디(그리드)가 차지하는 영역
    final fullBodyRect = Rect.fromLTWH(
      0,
      headerHeight,
      screenSize.width,
      screenSize.height - headerHeight - controlsHeight,
    );

    // PiP 목표 위치 — 디스코드처럼 우상단 작은 정사각형
    final bubbleRect = Rect.fromLTWH(
      screenSize.width - _bubbleSize - _bubbleMargin,
      padding.top + _bubbleMargin,
      _bubbleSize,
      _bubbleSize,
    );
    final effectiveBubbleRect = bubbleRect.shift(_bubbleDragOffset);
    return Material(
      type: MaterialType.transparency,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final Rect bodyRect;
          final double collapseFade;
          final double chromeOpacity;

          if (_isCollapseDragging) {
            bodyRect = fullBodyRect.translate(0, _dragTranslateY);
            collapseFade = 0.0;
            chromeOpacity = (1 - _dragTranslateY / _chromeFadeDistance).clamp(
              0.0,
              1.0,
            );
          } else if (_commitRectAnim?.value != null) {
            final rect = _commitRectAnim!.value!;
            bodyRect = rect;
            if (_commitToOpen) {
              collapseFade = 0.0;
              final translateY = (rect.top - fullBodyRect.top).clamp(
                0.0,
                double.infinity,
              );
              chromeOpacity = (1 - translateY / _chromeFadeDistance).clamp(
                0.0,
                1.0,
              );
            } else {
              collapseFade = (_controller.value / 0.3).clamp(
                0.0,
                1.0,
              ); // 축소 애니메이션 초반 30%에서만 빠르게 크로스페이드
              chromeOpacity = 0.0;
            }
          } else {
            bodyRect = _isOpen ? fullBodyRect : effectiveBubbleRect;
            collapseFade = _isOpen ? 0.0 : 1.0;
            chromeOpacity = _isOpen ? 1.0 : 0.0;
          }

          final chromeIgnoring = chromeOpacity < 0.5;
          final gridOpacity = 1 - collapseFade;
          final avatarOpacity = collapseFade;
          final radius = ui.lerpDouble(0.0, 20.0, collapseFade)!;

          return Stack(
            children: [
              IgnorePointer(
                child: Opacity(
                  opacity: chromeOpacity,
                  child: Container(color: const Color(0xFF1C1C1E)),
                ),
              ),

              // 바디 — 헤더/카드/버블 전 구간을 관통하는 단일 Rect + 제스처
              Positioned.fromRect(
                rect: bodyRect,
                child: IgnorePointer(
                  ignoring: _commitRectAnim != null,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onPanStart: (_) {
                      if (_isOpen) {
                        _isPipDrag = false;
                        _onCollapseDragStart();
                      } else {
                        _isPipDrag = true;
                      }
                    },
                    onPanUpdate: (d) {
                      if (_isPipDrag) {
                        _onBubblePanUpdate(d, bubbleRect, screenSize, padding);
                      } else {
                        _onCollapseDragUpdate(d, screenSize);
                      }
                    },
                    onPanEnd: (d) {
                      if (_isPipDrag) {
                        _onBubblePanEnd(bubbleRect, screenSize, padding);
                      } else {
                        _onCollapseDragEnd(
                          d,
                          screenSize,
                          fullBodyRect,
                          effectiveBubbleRect,
                        );
                      }
                    },
                    onPanCancel: () {
                      if (!_isPipDrag && _isCollapseDragging) {
                        setState(() => _isCollapseDragging = false);
                        _commitTo(
                          true,
                          fullBodyRect.translate(0, _dragTranslateY),
                          fullBodyRect,
                          effectiveBubbleRect,
                        );
                      }
                    },
                    onTap: !_isOpen
                        ? () => _commitTo(
                            true,
                            effectiveBubbleRect,
                            fullBodyRect,
                            effectiveBubbleRect,
                          )
                        : null,
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
                                child: _VoiceBodyOf(channelId: channelId),
                              ),
                            ),
                          ),
                        if (avatarOpacity > 0)
                          Opacity(
                            opacity: avatarOpacity,
                            child: IgnorePointer(
                              child: Center(
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(radius),
                                    child: _AvatarBubbleCard(
                                      channelId: channelId,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),

              // 헤더 — 고정 위치에서 페이드/슬라이드만
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
                      child: SafeArea(
                        bottom: false,
                        child: _VoiceHeader(channelId: channelId),
                      ),
                    ),
                  ),
                ),
              ),

              // 컨트롤 바 — 고정 위치에서 페이드/슬라이드만
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: IgnorePointer(
                  ignoring: chromeIgnoring,
                  child: Opacity(
                    opacity: chromeOpacity,
                    child: Transform.translate(
                      offset: Offset(0, 20 * (1 - chromeOpacity)),
                      child: SafeArea(
                        top: false,
                        child: _VoiceControlsSection(channelId: channelId),
                      ),
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

class _AvatarBubbleCard extends ConsumerWidget {
  const _AvatarBubbleCard({required this.channelId});
  final int channelId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);

    return Container(
      color: const Color(0xFF1C1C1E),
      child: Center(
        child: CachedCircleAvatar(
          url: currentUser?.imageUrl,
          radius: 36,
          backgroundColor: Colors.transparent,
        ),
      ),
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
                onTap: isReady ? () {} : null,
                child: Icon(Icons.emoji_emotions_outlined, size: 20.0),
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
