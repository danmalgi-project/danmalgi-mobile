import 'package:danmalgi_mobile/core/theme/app_dimens.dart';
import 'package:flutter/material.dart';

class AppListItem extends StatelessWidget {
  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final EdgeInsetsGeometry padding;

  const AppListItem({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.padding = const EdgeInsets.all(AppSpacing.s12),
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      borderRadius: AppRadius.brMd,
      child: Padding(
        padding: padding,
        child: Row(
          spacing: AppSpacing.s12,
          children: [
            ?leading,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                spacing: AppSpacing.s4,
                children: [title, ?subtitle],
              ),
            ),
            ?trailing,
          ],
        ),
      ),
    );
  }
}
