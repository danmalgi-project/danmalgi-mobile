import 'package:cached_network_image/cached_network_image.dart';
import 'package:danmalgi_mobile/core/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class CachedCircleAvatar extends StatelessWidget {
  static final _log = Logger('widget.CachedCircleAvatar');

  final String? url;
  final double? radius;
  final Color? backgroundColor;
  final Widget? child;

  const CachedCircleAvatar({
    super.key,
    this.url,
    this.radius,
    this.backgroundColor,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = url.nullIfEmpty;

    if (imageUrl == null) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor,
        child: child,
      );
    }

    return CircleAvatar(
      radius: radius,
      backgroundImage: CachedNetworkImageProvider(imageUrl),
      backgroundColor: Colors.transparent,
      onBackgroundImageError: (e, st) =>
          _log.fine('Failed to load backgroundImage', e, st),
      child: child,
    );
  }
}
