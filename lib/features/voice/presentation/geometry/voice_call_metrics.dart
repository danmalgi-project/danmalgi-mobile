import 'package:flutter/material.dart';

const kVoiceHeaderHeight = 72.0;
const kVoiceControlsHeight = 84.0;
const kVoiceChromeFadeDistance = 80.0;

@immutable
class VoiceCallMetrics {
  final Rect fullBody;
  final double travel;

  const VoiceCallMetrics({required this.fullBody, required this.travel});

  double chromeOpacityAt(Rect body) =>
      (1 - (body.top - fullBody.top) / kVoiceChromeFadeDistance).clamp(
        0.0,
        1.0,
      );

  factory VoiceCallMetrics.of(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final padding = MediaQuery.paddingOf(context);
    final top = padding.top + kVoiceHeaderHeight;
    final bottom = padding.bottom + kVoiceControlsHeight;

    return VoiceCallMetrics(
      fullBody: Rect.fromLTWH(0, top, size.width, size.height - top - bottom),
      travel: size.height - top,
    );
  }
}
