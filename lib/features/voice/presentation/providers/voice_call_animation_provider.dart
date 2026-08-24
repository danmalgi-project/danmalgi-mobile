import 'package:flutter/material.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'voice_call_animation_provider.g.dart';

@Riverpod(keepAlive: true)
class VoiceCallAnimation extends _$VoiceCallAnimation {
  @override
  Animation<double>? build() => null;

  void update(Animation<double>? animation) => state = animation;
}
