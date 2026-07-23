// app_colors.dart
import 'package:flutter/material.dart';

abstract class AppPrimitiveColors {
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF121212); // 현재 값 유지
  static const gray100 = Color(0xFFE5E5E5);
  static const gray400 = Color(0xFF8A8A8A);
  static const gray600 = Color(0xFF555555);
  static const gray700 = Color(0xFF373737); // 현재 primary 값
  static const gray800 = Color(0xFF2C2C2C);
}

abstract class AppColors {
  // 배경
  static const background = AppPrimitiveColors.black;
  static const surface = AppPrimitiveColors.gray800; // 카드/시트는 배경보다 밝게

  // 주요 액션 (흰 버튼 기반)
  static const primary = AppPrimitiveColors.black;
  static const onPrimary = AppPrimitiveColors.white;

  // 보조 액션 (아직 미정이면 명시적으로 표시)
  // 예: 외곽선만 있는 버튼, 덜 강조되는 버튼
  static const secondary = AppPrimitiveColors.gray700;
  static const onSecondary = AppPrimitiveColors.white;

  // 텍스트
  static const textMain = AppPrimitiveColors.white;
  static const textSub = AppPrimitiveColors.gray400;
  static const onSurface = AppPrimitiveColors.white;

  // 구분선 (미정이면 일단 gray700)
  static const outline = AppPrimitiveColors.gray700;

  // 오류
  static const error = Color(0xFFFF5C5C);
  static const onError = AppPrimitiveColors.white;
}
