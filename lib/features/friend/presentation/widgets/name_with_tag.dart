import 'package:danmalgi_mobile/core/theme/app_colors.dart';
import 'package:danmalgi_mobile/core/theme/app_dimens.dart';
import 'package:danmalgi_mobile/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class NameWithTag extends StatelessWidget {
  final String name;
  final String tag;

  const NameWithTag({super.key, required this.name, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSpacing.s8,
      children: [
        Flexible(
          child: Text(
            name,
            style: AppTypography.titleSm,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          '#$tag',
          style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }

  static Widget stacked({required String name, required String tag}) {
    return Column(
      spacing: AppSpacing.s4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: AppTypography.titleSm,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          '#$tag',
          style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
