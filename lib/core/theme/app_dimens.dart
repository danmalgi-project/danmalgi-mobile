import 'package:flutter/widgets.dart';

abstract final class AppSpacing {
  static const s2 = 2.0;
  static const s4 = 4.0;
  static const s6 = 6.0;
  static const s8 = 8.0;
  static const s12 = 12.0;
  static const s16 = 16.0;
  static const s20 = 20.0;
  static const s24 = 24.0;
  static const s28 = 28.0;
  static const s36 = 36.0;
  static const s48 = 48.0;
}

abstract final class AppRadius {
  static const none = 0.0;
  static const xs = 4.0; // 펄스, 체크박스
  static const sm = 6.0; // RSVP 필, 소형 태그
  static const md = 16.0; // 뒤로가기, 할일 카드
  static const lg = 18.0; // 카드, 배지, 아이콘 컨테이너
  static const xl = 26.0; // 미디어 컨트롤 버튼
  static const xxl = 40.0; // 스크린 외곽
  static const pill = 9999.0;

  static const brSm = BorderRadius.all(Radius.circular(sm));
  static const brMd = BorderRadius.all(Radius.circular(md));
  static const brLg = BorderRadius.all(Radius.circular(lg));
  static const brPill = BorderRadius.all(Radius.circular(pill));
}

abstract final class AppStroke {
  static const divider = 1.0; // 구분선, 비활성 입력 필드
  static const ring = 1.5; // 아바타 링, 체크박스, 활성 입력 필드
  static const icon = 2.0; // 모든 벡터 아이콘
  static const onlineRing = 4.0;
}

/// 반복되는 패딩 조합
abstract final class AppPadding {
  static const cardNormal = EdgeInsets.symmetric(vertical: 12, horizontal: 20);
  static const cardActive = EdgeInsets.all(20);
  static const chatBubble = EdgeInsets.symmetric(vertical: 10, horizontal: 14);
  static const statusBar = EdgeInsets.symmetric(vertical: 16, horizontal: 24);
  static const rsvpPill = EdgeInsets.symmetric(vertical: 4, horizontal: 8);
  static const todoItem = EdgeInsets.all(14);
  static const inputBar = EdgeInsets.symmetric(vertical: 10, horizontal: 16);
}
