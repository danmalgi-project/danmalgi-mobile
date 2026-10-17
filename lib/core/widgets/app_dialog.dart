import 'package:danmalgi_mobile/core/theme/app_colors.dart';
import 'package:danmalgi_mobile/core/theme/app_dimens.dart';
import 'package:danmalgi_mobile/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

Future<bool> showAppConfirmDialog({
  required BuildContext context,
  required String title,
  required String confirmLabel,
  String? message,
  String cancelLabel = '취소',
  bool destructive = false,
}) async {
  final result = await showDialog(
    context: context,
    barrierColor: AppColors.scrimStrong,
    builder: (dialogContext) => Dialog(
      backgroundColor: AppColors.surfacePrimary,
      surfaceTintColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.s24),
      shape: const RoundedRectangleBorder(borderRadius: AppRadius.brLg),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.s24,
          AppSpacing.s24,
          AppSpacing.s24,
          AppSpacing.s28,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title, style: AppTypography.title),
            if (message != null) ...[
              const SizedBox(height: AppSpacing.s12),
              Text(
                message,
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.s36),
            Row(
              spacing: AppSpacing.s12,
              children: [
                Expanded(
                  child: _DialogButton(
                    label: cancelLabel,
                    onTap: () => Navigator.of(dialogContext).pop(false),
                  ),
                ),
                Expanded(
                  child: _DialogButton(
                    label: confirmLabel,
                    color: destructive
                        ? AppColors.danger
                        : AppColors.textPrimary,
                    onTap: () => Navigator.of(dialogContext).pop(true),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );

  return result ?? false;
}

class _DialogButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _DialogButton({
    required this.label,
    required this.onTap,
    this.color = AppColors.textPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfaceInput,
      shape: const StadiumBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 44,
          child: Center(
            child: Text(
              label,
              style: AppTypography.body.copyWith(
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
