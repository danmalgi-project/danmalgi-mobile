import 'package:danmalgi_mobile/core/providers/app_user_provider.dart';
import 'package:danmalgi_mobile/core/router/route_paths.dart';
import 'package:danmalgi_mobile/core/router/router.dart';
import 'package:danmalgi_mobile/core/widgets/cached_circle_avatar.dart';
import 'package:danmalgi_mobile/features/voice/data/providers/active_voice_session_provider.dart';
import 'package:danmalgi_mobile/features/voice/data/providers/voice_screen_visible_provider.dart';
import 'package:danmalgi_mobile/features/voice/domain/voice_state.dart';
import 'package:danmalgi_mobile/features/voice/presentation/providers/voice_view_model.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VoiceMiniBar extends ConsumerStatefulWidget {
  const VoiceMiniBar({super.key});

  @override
  ConsumerState<VoiceMiniBar> createState() => _VoiceMiniBarState();
}

class _VoiceMiniBarState extends ConsumerState<VoiceMiniBar> {
  static const _bubbleSize = 108.0;
  static const _margin = 8.0;

  double? _left;
  double? _top;
  bool _isDragging = false;

  // @override
  // void initState() {
  //   super.initState();
  //   setState(() async {
  //     ref.read()
  //     final scheme = await ColorScheme.fromImageProvider(
  //       provider: NetworkImage(currentUser.imageUrl),
  //       brightness: Brightness.dark,
  //     );
  //     final dominant = scheme.primary;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final channelId = ref.watch(activeVoiceSessionProvider);
    if (channelId == null) return const SizedBox.shrink();

    final currentUser = ref.watch(currentUserProvider);
    final router = ref.watch(routerProvider);

    final isVoiceScreenVisible = ref.watch(voiceScreenVisibleProvider);
    if (isVoiceScreenVisible) return const SizedBox.shrink();

    final size = MediaQuery.sizeOf(context);
    final padding = MediaQuery.paddingOf(context);

    _left ??= size.width - _bubbleSize - 16;
    _top ??= size.height - padding.bottom - _bubbleSize - 96;

    final status = ref
        .watch(voiceViewModelProvider(channelId: channelId))
        .value
        ?.status;

    final color = switch (status) {
      VoiceConnectionStatus.connected => const Color(0xFF30D158),
      VoiceConnectionStatus.unstable => Colors.orange,
      VoiceConnectionStatus.failed => Colors.red,
      _ => Colors.grey,
    };

    return AnimatedPositioned(
      duration: _isDragging ? Duration.zero : const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      left: _left,
      top: _top,
      child: GestureDetector(
        onTap: () => router.push(RoutePaths.voice(Int64(channelId))),
        onPanStart: (_) => setState(() => _isDragging = true),
        onPanUpdate: (details) {
          setState(() {
            _left = (_left! + details.delta.dx).clamp(
              _margin,
              size.width - _bubbleSize - _margin,
            );
            _top = (_top! + details.delta.dy).clamp(
              padding.top + _margin,
              size.height - padding.bottom - _bubbleSize - _margin,
            );
          });
        },
        onPanEnd: (_) {
          setState(() => _isDragging = false);
          _snapToEdge(size, padding);
        },
        child: Container(
          width: _bubbleSize,
          height: _bubbleSize,
          decoration: BoxDecoration(
            color: const Color(0xFF161618),
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: Center(
            child: CachedCircleAvatar(
              url: currentUser?.imageUrl,
              radius: _bubbleSize * 0.3,
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }

  void _snapToEdge(Size size, EdgeInsets padding) {
    final centerX = _left! + _bubbleSize / 2;
    final centerY = _top! + _bubbleSize / 2;

    final distLeft = centerX;
    final distRight = size.width - centerX;
    final distTop = centerY - padding.top;
    final distBottom = size.height - padding.bottom - centerY;

    final minDist = [
      distLeft,
      distRight,
      distTop,
      distBottom,
    ].reduce((a, b) => a < b ? a : b);

    setState(() {
      if (minDist == distLeft) {
        _left = _margin;
      } else if (minDist == distRight) {
        _left = size.width - _bubbleSize - _margin;
      } else if (minDist == distTop) {
        _top = padding.top + _margin;
      } else {
        _top = size.height - padding.bottom - _bubbleSize - _margin;
      }

      _left = _left!.clamp(_margin, size.width - _bubbleSize - _margin);
      _top = _top!.clamp(
        padding.top + _margin,
        size.height - padding.bottom - _bubbleSize - _margin,
      );
    });
  }
}
