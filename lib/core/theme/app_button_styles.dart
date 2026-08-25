import 'package:danmalgi_mobile/core/theme/app_colors.dart';
import 'package:danmalgi_mobile/core/theme/app_dimens.dart';
import 'package:danmalgi_mobile/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

abstract final class AppButtonStyles {
  static final inverse = ElevatedButton.styleFrom(
    backgroundColor: AppColors.surfaceInverse,
    foregroundColor: AppColors.onSurfaceInverse,
    disabledBackgroundColor: AppColors.surfaceInverse.withValues(alpha: 0.6),
    disabledForegroundColor: AppColors.onSurfaceInverse.withValues(alpha: 0.6),
    overlayColor: AppColors.onSurfaceInverse.withValues(alpha: 0.05),
    elevation: 0,
    shape: const StadiumBorder(),
    textStyle: AppTypography.subhead,
    padding: const EdgeInsets.symmetric(vertical: AppSpacing.s24),
  );
}
