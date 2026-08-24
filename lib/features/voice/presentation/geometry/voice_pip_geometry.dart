import 'dart:math';

import 'package:flutter/material.dart';

import 'package:danmalgi_mobile/features/voice/presentation/widgets/voice_pip_rect.dart';

const _kFlingProjection = 0.15;

Offset snapVoicePipToEdge({
  required Rect rect,
  required Size screenSize,
  required EdgeInsets padding,
  Offset velocity = Offset.zero,
}) {
  final minX = kVoicePipMargin;
  final maxX = screenSize.width - kVoicePipSize - kVoicePipMargin;
  final minY = padding.top + kVoicePipMargin;
  final maxY =
      screenSize.height - padding.bottom - kVoicePipSize - kVoicePipMargin;

  final projected = Offset(
    (rect.left + velocity.dx * _kFlingProjection).clamp(minX, maxX),
    (rect.top + velocity.dy * _kFlingProjection).clamp(minY, maxY),
  );

  final center = projected + const Offset(kVoicePipSize / 2, kVoicePipSize / 2);
  final toLeft = center.dx;
  final toRight = screenSize.width - center.dx;
  final toTop = center.dy - padding.top;
  final toBottom = screenSize.height - padding.bottom - center.dy;

  final nearest = [toLeft, toRight, toTop, toBottom].reduce(min);

  if (nearest == toLeft) return Offset(minX, projected.dy);
  if (nearest == toRight) return Offset(maxX, projected.dy);
  if (nearest == toTop) return Offset(projected.dx, minY);
  return Offset(projected.dx, maxY);
}
