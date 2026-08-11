import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedCircleAvatar extends StatelessWidget {
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
      backgroundColor: backgroundColor,
      onBackgroundImageError: (e, st) {
        // print("Avatar Error: ${url!}");
        // print(e);
      },
      child: child,
    );
  }
}
