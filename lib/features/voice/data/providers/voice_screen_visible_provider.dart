import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'voice_screen_visible_provider.g.dart';

@Riverpod(keepAlive: true)
class VoiceScreenVisible extends _$VoiceScreenVisible {
  @override
  bool build() => false;

  void set(bool value) => state = value;
}
