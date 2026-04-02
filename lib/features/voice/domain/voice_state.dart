import 'package:danmalgi_mobile/features/user/domain/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'voice_state.freezed.dart';

@freezed
abstract class VoiceState with _$VoiceState {
  const factory VoiceState({
    User? currentUser,
    @Default([]) List<User> users,
    @Default('') String statusMessage,
    @Default(false) bool isConnected,
    @Default({}) Map<String, User> trackUserMap,
    @Default(false) bool isMuted,
    @Default(false) bool isSpeaking,
    @Default({}) Set<int> speakingUserIds,
  }) = _VoiceState;
}
