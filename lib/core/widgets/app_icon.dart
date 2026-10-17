import 'package:flutter/material.dart';

enum AppIconType { addFriend, add, search, more, close }

class AppIcon extends StatelessWidget {
  const AppIcon(this.type, {super.key, this.size, this.color});

  final AppIconType type;
  final double? size;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Icon(_iconOf(type), size: size, color: color);
  }

  static IconData _iconOf(AppIconType type) => switch (type) {
    AppIconType.addFriend => Icons.person_add_alt_1_outlined,
    AppIconType.add => Icons.add_rounded,
    AppIconType.search => Icons.search_rounded,
    AppIconType.more => Icons.more_horiz_rounded,
    AppIconType.close => Icons.close_rounded,
  };
}
