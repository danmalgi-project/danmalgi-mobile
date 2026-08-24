import 'package:flutter/material.dart';

const kVoicePipSize = 108.0;
const kVoicePipMargin = 16.0;

Rect voicePipRect({
  required Size screenSize,
  required EdgeInsets padding,
  required Offset? offset,
}) {
  final minX = kVoicePipMargin;
  final maxX = screenSize.width - kVoicePipSize - kVoicePipMargin;
  final minY = padding.top + kVoicePipMargin;
  final maxY =
      screenSize.height - padding.bottom - kVoicePipSize - kVoicePipMargin;

  final o = offset ?? Offset(maxX, minY);

  return Rect.fromLTWH(
    o.dx.clamp(minX, maxX),
    o.dy.clamp(minY, maxY),
    kVoicePipSize,
    kVoicePipSize,
  );
}
