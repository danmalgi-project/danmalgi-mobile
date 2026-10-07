import 'dart:ui';

import 'package:danmalgi_mobile/features/voice/presentation/geometry/voice_call_metrics.dart';
import 'package:flutter/material.dart';

const kVoiceSettleDuration = Duration(milliseconds: 280);
const kVoiceSettleCurve = Curves.easeOutCubic;
const kVoiceKeepOpenThreshold = 0.7;
const kVoiceCrossfadeFraction = 0.5;
const kVoiceCallCornerRadius = 20.0;
const kVoiceChromeSlide = 20.0;

/// 통화 화면이 지금 어떤 방식으로 변형 중인지.
@immutable
class VoiceCallMorph {
  const VoiceCallMorph._({
    required this.sliding,
    this.anchor,
    this.anchorT = 1.0,
    this.anchorChrome = 1.0,
  });

  const VoiceCallMorph.open() : this._(sliding: false);

  const VoiceCallMorph.sliding() : this._(sliding: true);

  const VoiceCallMorph.anchored({
    required Rect anchor,
    required double t,
    required double chrome,
  }) : this._(sliding: false, anchor: anchor, anchorT: t, anchorChrome: chrome);

  final bool sliding;
  final Rect? anchor;
  final double anchorT;
  final double anchorChrome;

  VoiceCallFrame resolve({
    required double t,
    required VoiceCallMetrics metrics,
    required Rect pipRect,
  }) {
    if (sliding) {
      final body = metrics.fullBody.translate(0, (1 - t) * metrics.travel);
      return VoiceCallFrame(
        body: body,
        chromeOpacity: metrics.chromeOpacityAt(body),
        avatarOpacity: 0.0,
      );
    }

    final target = anchor ?? metrics.fullBody;
    final k = anchorT <= 0 ? 1.0 : (t / anchorT).clamp(0.0, 1.0);

    return VoiceCallFrame(
      body: Rect.lerp(pipRect, target, k)!,
      avatarOpacity: ((1 - k) / kVoiceCrossfadeFraction).clamp(0.0, 1.0),
      chromeOpacity:
          anchorChrome *
          ((k - (1 - kVoiceCrossfadeFraction)) / kVoiceCrossfadeFraction).clamp(
            0.0,
            1.0,
          ),
    );
  }
}

@immutable
class VoiceCallFrame {
  const VoiceCallFrame({
    required this.body,
    required this.chromeOpacity,
    required this.avatarOpacity,
  });

  final Rect body;
  final double chromeOpacity;
  final double avatarOpacity;

  double get gridOpacity => 1 - avatarOpacity;
  double get cornerRadius =>
      lerpDouble(0.0, kVoiceCallCornerRadius, avatarOpacity)!;
  bool get chromeInteractive => chromeOpacity >= 0.5;
  double get chromeSlide => kVoiceChromeSlide * (1 - chromeOpacity);
}
