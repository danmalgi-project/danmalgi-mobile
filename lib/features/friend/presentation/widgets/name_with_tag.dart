import 'package:danmalgi_mobile/core/theme/app_colors.dart';
import 'package:danmalgi_mobile/core/theme/app_dimens.dart';
import 'package:danmalgi_mobile/core/theme/app_typography.dart';
import 'package:danmalgi_mobile/features/user/domain/user.dart';
import 'package:flutter/material.dart';

class NameWithTag extends StatelessWidget {
  final User user;

  const NameWithTag({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSpacing.s8,
      children: [
        Flexible(
          child: Text(
            user.name,
            style: AppTypography.titleSm,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          '#${user.tag}',
          style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
