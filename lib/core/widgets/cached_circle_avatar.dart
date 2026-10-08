import 'package:cached_network_image/cached_network_image.dart';
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
    return CircleAvatar(
      radius: radius,
      backgroundImage: (url == null) ? null : CachedNetworkImageProvider(url!),
      backgroundColor: (url == null) ? backgroundColor : Colors.transparent,
      onBackgroundImageError: (e, st) =>
          _log.fine("Failed to load backgroundImage", e, st),
      child: child,
    );
  }
}
