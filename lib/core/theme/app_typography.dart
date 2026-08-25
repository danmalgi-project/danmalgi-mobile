import 'package:flutter/material.dart';

abstract final class AppTypography {
  static const fontFamily = 'Pretendard';

  static const display = TextStyle(fontSize: 40, fontWeight: FontWeight.w700);
  static const headline = TextStyle(fontSize: 32, fontWeight: FontWeight.w700);
  static const titleLg = TextStyle(fontSize: 20, fontWeight: FontWeight.w800);
  static const title = TextStyle(fontSize: 18, fontWeight: FontWeight.w700);
  static const titleSm = TextStyle(fontSize: 16, fontWeight: FontWeight.w700);
  static const subhead = TextStyle(fontSize: 15, fontWeight: FontWeight.w500);
  static const body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  ); // 최다 사용
  static const caption = TextStyle(fontSize: 13, fontWeight: FontWeight.w500);
  static const label = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    letterSpacing: 1,
  );
  static const badge = TextStyle(fontSize: 11, fontWeight: FontWeight.w700);
  static const tab = TextStyle(fontSize: 10, fontWeight: FontWeight.w500);

  /// 상태바 시간 (시트 2 Font Notes)
  static const statusTime = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.22,
  );
}
