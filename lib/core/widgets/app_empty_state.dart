import 'package:danmalgi_mobile/core/theme/app_colors.dart';
import 'package:danmalgi_mobile/core/theme/app_dimens.dart';
import 'package:danmalgi_mobile/core/theme/app_typography.dart';
import 'package:flutter/widgets.dart';

class AppEmptyState extends StatelessWidget {
  final Widget? icon;
  final String title;
  final String? message;
  final List<Widget> actions;

  const AppEmptyState({
    super.key,
    this.icon,
    required this.title,
    this.message,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    final icon = this.icon;
    final message = this.message;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[icon, const SizedBox(height: AppSpacing.s32)],
          Text(
            title,
            style: AppTypography.titleLg,
            textAlign: TextAlign.center,
          ),
          if (message != null) ...[
            const SizedBox(height: AppSpacing.s8),
            Text(
              message,
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
          if (actions.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.s32),
            Column(spacing: AppSpacing.s12, children: actions),
          ],
        ],
      ),
    );
  }
}
