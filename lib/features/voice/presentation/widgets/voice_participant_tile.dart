import 'package:danmalgi_mobile/core/theme/app_colors.dart';
import 'package:danmalgi_mobile/core/widgets/cached_circle_avatar.dart';
import 'package:danmalgi_mobile/features/user/domain/user.dart';
import 'package:flutter/material.dart';

class VoiceParticipantTile extends StatelessWidget {
  const VoiceParticipantTile({
    super.key,
    required this.user,
    required this.isMuted,
  });

  final User user;
  final bool isMuted;

  /// 타일 높이 대비 비율 — 슬롯이 가로로 2배여도 아바타 크기는 유지된다.
  static const _avatarRatio = 0.25;
  static const _muteIconRatio = 0.075;

  @override
  Widget build(BuildContext context) {
    return Material(
      // color: VoiceColors.tile,
      color: const Color(0xFF161618),
      borderRadius: BorderRadius.circular(18),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final unit = constraints.maxHeight;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  CachedCircleAvatar(
                    url: user.imageUrl,
                    radius: unit * _avatarRatio,
                    backgroundColor: Colors.transparent,
                  ),
                  if (isMuted)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: _MuteBadge(size: unit * _muteIconRatio),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                user.name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppColors.textMain,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _MuteBadge extends StatelessWidget {
  const _MuteBadge({required this.size});
  final double size;

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      shape: const CircleBorder(),
      // color: VoiceColors.hangup,
      color: Colors.red,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Icon(
          Icons.mic_off_outlined,
          size: size,
          color: AppColors.textMain,
        ),
      ),
    );
  }
}
