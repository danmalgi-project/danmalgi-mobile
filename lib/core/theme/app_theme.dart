import 'package:flutter/material.dart';
import 'package:danmalgi_mobile/core/theme/app_colors.dart';
import 'package:danmalgi_mobile/core/theme/app_dimens.dart';
import 'package:danmalgi_mobile/core/theme/app_typography.dart';

abstract final class AppTheme {
  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: AppTypography.fontFamily,
    scaffoldBackgroundColor: AppColors.canvas,

    colorScheme: const ColorScheme.dark(
      primary: AppColors.accent, // 단일 액센트
      onPrimary: AppColors.onAccent,
      secondary: AppColors.surfaceSecondary,
      onSecondary: AppColors.textPrimary,
      surface: AppColors.surfacePrimary, // 카드/시트
      onSurface: AppColors.textPrimary,
      surfaceContainerHighest: AppColors.surfaceInput,
      outline: AppColors.divider,
      outlineVariant: AppColors.borderInactive,
      error: AppColors.danger,
      onError: AppColors.textPrimary,
      scrim: AppColors.scrim,
    ),

    // Material 위젯이 자동으로 집어가는 매핑
    textTheme:
        const TextTheme(
          displayLarge: AppTypography.display,
          headlineLarge: AppTypography.headline,
          titleLarge: AppTypography.titleLg,
          titleMedium: AppTypography.title,
          titleSmall: AppTypography.titleSm,
          bodyLarge: AppTypography.subhead,
          bodyMedium: AppTypography.body, // 기본 본문
          bodySmall: AppTypography.caption,
          labelLarge: AppTypography.label,
          labelMedium: AppTypography.badge,
          labelSmall: AppTypography.tab,
        ).apply(
          bodyColor: AppColors.textPrimary,
          displayColor: AppColors.textPrimary,
        ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.canvas,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleTextStyle: AppTypography.title,
    ),

    dividerTheme: const DividerThemeData(
      color: AppColors.divider,
      thickness: AppStroke.divider,
      space: AppStroke.divider,
    ),

    iconTheme: const IconThemeData(color: AppColors.textPrimary, size: 24),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.onAccent,
        disabledBackgroundColor: AppColors.accent.withValues(alpha: 0.4),
        disabledForegroundColor: AppColors.onAccent.withValues(alpha: 0.4),
        elevation: 0,
        shadowColor: Colors.transparent,
        textStyle: AppTypography.titleSm,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.brPill),
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.s16),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surfaceInput,
      contentPadding: AppPadding.inputBar,
      hintStyle: AppTypography.body.copyWith(color: AppColors.textSecondary),
      border: const OutlineInputBorder(
        borderRadius: AppRadius.brPill,
        borderSide: BorderSide(
          color: AppColors.divider,
          width: AppStroke.divider,
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: AppRadius.brPill,
        borderSide: BorderSide(
          color: AppColors.divider,
          width: AppStroke.divider,
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: AppRadius.brPill,
        borderSide: BorderSide(
          color: AppColors.borderActive,
          width: AppStroke.ring,
        ),
      ),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.surfaceNav,
      selectedItemColor: AppColors.accent,
      unselectedItemColor: AppColors.iconInactive,
      selectedLabelStyle: AppTypography.tab,
      unselectedLabelStyle: AppTypography.tab,
      elevation: 0,
    ),
  );
}
