import 'dart:math';

import 'package:flutter/material.dart';

import 'package:danmalgi_mobile/features/voice/presentation/widgets/voice_pip_rect.dart';

Offset snapVoicePipToEdge({
  required Rect rect,
  required Size screenSize,
  required EdgeInsets padding,
}) {
  final center = rect.center;
  final toLeft = center.dx;
  final toRight = screenSize.width - center.dx;
  final toTop = center.dy - padding.top;
  final toBottom = screenSize.height - padding.bottom - center.dy;

  final nearest = [toLeft, toRight, toTop, toBottom].reduce(min);

  if (nearest == toLeft) return Offset(kVoicePipMargin, rect.top);
  if (nearest == toRight) {
    return Offset(screenSize.width - kVoicePipSize - kVoicePipMargin, rect.top);
  }
  if (nearest == toTop) return Offset(rect.left, padding.top + kVoicePipMargin);
  return Offset(
    rect.left,
    screenSize.height - padding.bottom - kVoicePipSize - kVoicePipMargin,
  );
}
