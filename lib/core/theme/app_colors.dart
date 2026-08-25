import 'package:flutter/material.dart';

/// Primitive
abstract final class _P {
  static const black = Color(0xFF000000);
  static const white = Color(0xFFFFFFFF);

  // Surface 6단계 (밝을수록 앞)
  static const gray111112 = Color(0xFF111112);
  static const gray161618 = Color(0xFF161618);
  static const gray1C1C1E = Color(0xFF1C1C1E);
  static const gray272729 = Color(0xFF272729);
  static const gray2C2C2E = Color(0xFF2C2C2E);

  // Text / Icon
  static const gray9A9A9F = Color(0xFF9A9A9F);
  static const gray8E8E93 = Color(0xFF8E8E93);

  // Brand & Status
  static const yellow = Color(0xFFFBD53C);
  static const blue = Color(0xFF2997FF);
  static const pink = Color(0xFFFF2D78);
  static const green = Color(0xFF30D158);
  static const red = Color(0xFFFF3B30);
}

/// Semantic
abstract final class AppColors {
  // ── Surface ─────────────────────────
  static const canvas = _P.black; // 스크린 기본 배경
  static const surfaceNav = _P.gray111112; // 탭바, 홈 인디케이터
  static const surfaceTertiary = _P.gray161618; // 알림 아이콘, 상태 표시
  static const surfacePrimary = _P.gray1C1C1E; // 카드 배경, 컨테이너
  static const surfaceSecondary = _P.gray272729; // 미팅 카드, 소스 필
  static const surfaceInput = _P.gray2C2C2E; // 입력 필드, 첨부 버튼

  // ── Inverse (밝은 서피스) ────────
  static const surfaceInverse = _P.white;
  static const onSurfaceInverse = _P.black;

  // ── Brand & Accent ─────────────────────────────
  static const accent = _P.yellow; // 유일한 액센트: 활성/CTA/하이라이트
  static const onAccent = _P.black; // 옐로우 위 텍스트·아이콘
  static const link = _P.blue;
  static const cta = _P.pink; // 라이브 배지, 참여 CTA

  // ── Text & Icon ────────────────────────────────
  static const textPrimary = _P.white;
  static const textSecondary = _P.gray9A9A9F; // 본문 장문에는 비권장
  static const iconInactive = _P.gray8E8E93; // 비활성 탭, 체크박스 테두리

  // ── Status ─────────────────────────────────────
  static const success = _P.green; // 연결 양호, 온라인
  static const danger = _P.red; // 녹화, 음소거, 나가기
  static const scrim = Color(0x80000000); // rgba(0,0,0,0.5)

  // ── Border ─────────────────────────────────────
  static const divider = _P.gray2C2C2E;
  static const borderActive = _P.yellow; // 활성 링/입력 필드
  static const borderInactive = _P.gray272729; // 비활성 아바타 링
}
