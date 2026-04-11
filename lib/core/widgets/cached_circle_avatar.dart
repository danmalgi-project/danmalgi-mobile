import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedCircleAvatar extends StatelessWidget {
  final String? url;
  final double? radius;

  const CachedCircleAvatar({super.key, this.url, this.radius});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: (url == null) ? null : CachedNetworkImageProvider(url!),
      onBackgroundImageError: (_, __) {},
      child: null,
    );
  }
}
