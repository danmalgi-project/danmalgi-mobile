import 'package:cached_network_image/cached_network_image.dart';
import 'package:danmalgi_mobile/core/extensions/string_extensions.dart';
import 'package:danmalgi_mobile/core/theme/app_colors.dart';
import 'package:danmalgi_mobile/core/theme/app_dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logging/logging.dart';

class CachedCircleAvatar extends StatelessWidget {
  static final _log = Logger('widget.CachedCircleAvatar');

  final String? url;
  final double radius;
  final Color backgroundColor;
  final Widget? child;
  final int? seed;

  static const _defaults = [
    'assets/avatars/yellow.svg',
    'assets/avatars/blue.svg',
    'assets/avatars/green.svg',
    'assets/avatars/rose.svg',
    'assets/avatars/orange.svg',
    'assets/avatars/purple.svg',
  ];

  const CachedCircleAvatar({
    super.key,
    this.url,
    this.radius = AppAvatarSize.md,
    this.backgroundColor = AppColors.surfaceSecondary,
    this.child,
    this.seed,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = url.nullIfEmpty;

    if (imageUrl != null) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: CachedNetworkImageProvider(imageUrl),
        backgroundColor: Colors.transparent,
        onBackgroundImageError: (e, st) =>
            _log.fine('Failed to load backgroundImage', e, st),
        child: child,
      );
    }

    // TODO(server-default-avatar): 서버가 기본 프로필 URL을 주기 시작하면 삭제
    final seed = this.seed;
    if (seed != null) {
      return ClipOval(
        child: SvgPicture.asset(
          _defaults[seed.abs() % _defaults.length],
          width: radius * 2,
          height: radius * 2,
          fit: BoxFit.cover,
        ),
      );
    }

    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      child: child,
    );
  }
}
