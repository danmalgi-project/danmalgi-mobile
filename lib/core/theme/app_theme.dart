// lib/core/theme/appAppColors.theme.dart 로 분리 권장
import 'package:danmalgi_mobile/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    fontFamily: 'Pretendard',
    brightness: Brightness.dark,

    colorScheme: const ColorScheme.dark(
      // 주요 색상 (버튼, 강조 요소)
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,

      // 보조 색상
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,

      // 배경
      surface: AppColors.surface, // 카드, BottomSheet
      onSurface: AppColors.onSurface, // surface 위 텍스트
      // surfaceContainerHighest: AppColors.midGray,

      // 앱 배경
      // scaffoldBackgroundColor는 별도 지정

      // 구분선
      // outline: AppColors.lineGray,
      // outlineVariant: AppColors.midGray,

      // 오류
      error: AppColors.error,
      onError: AppColors.onError,
    ),

    scaffoldBackgroundColor: AppColors.background,

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.onPrimary,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontFamily: 'Pretendard',
        fontWeight: FontWeight.w600,
        fontSize: 18,
        color: AppColors.textMain,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.6),
        disabledForegroundColor: AppColors.onPrimary.withValues(alpha: 0.4),
        overlayColor: AppColors.onPrimary.withValues(alpha: 0.05),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(vertical: 18),
      ),
    ),

    // dividerTheme: const DividerThemeData(
    //   color: AppColors.lineGray,
    //   thickness: 1,
    // ),
  );
}
