import 'dart:ui';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'voice_pip_offset_provider.g.dart';

@Riverpod(keepAlive: true)
class VoicePipOffset extends _$VoicePipOffset {
  @override
  Offset? build() => null;

  void update(Offset? offset) => state = offset;
}
