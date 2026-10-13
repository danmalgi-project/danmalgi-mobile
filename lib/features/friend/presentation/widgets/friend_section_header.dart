import 'package:danmalgi_mobile/core/theme/app_colors.dart';
import 'package:danmalgi_mobile/core/theme/app_dimens.dart';
import 'package:danmalgi_mobile/core/theme/app_typography.dart';
import 'package:flutter/widgets.dart';

class FriendSectionHeader extends StatelessWidget {
  final String title;
  final int count;
  final Widget? trailing;

  const FriendSectionHeader({
    super.key,
    required this.title,
    required this.count,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSpacing.s8,
      children: [
        Text(title, style: AppTypography.title),
        Text(
          '$count',
          style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
        ),
        const Spacer(),
        ?trailing,
      ],
    );
  }
}
