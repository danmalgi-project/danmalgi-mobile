import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavSvgIcon extends StatelessWidget {
  const BottomNavSvgIcon(this.assetPath, {super.key, this.size = 20});

  final String assetPath;
  final double size;

  @override
  Widget build(BuildContext context) {
    final iconTheme = IconTheme.of(context);

    return SvgPicture.asset(
      assetPath,
      width: iconTheme.size ?? size,
      height: iconTheme.size ?? size,
      colorFilter: ColorFilter.mode(
        iconTheme.color ?? Colors.grey,
        BlendMode.srcIn,
      ),
    );
  }
}
