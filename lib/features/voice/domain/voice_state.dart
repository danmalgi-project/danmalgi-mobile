import 'package:danmalgi_mobile/features/user/domain/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'voice_state.freezed.dart';

enum VoiceConnectionStatus { connecting, connected, unstable, failed }

@freezed
abstract class VoiceState with _$VoiceState {
  const VoiceState._();

  List<User> get participants => [?currentUser, ...users];

  const factory VoiceState({
    User? currentUser,
    @Default([]) List<User> users,
    @Default(VoiceConnectionStatus.connecting) VoiceConnectionStatus status,
    @Default('') String statusMessage,
    @Default(false) bool isConnected,
    @Default({}) Map<String, User> trackUserMap,
    @Default(false) bool isMuted,
    @Default(false) bool isSpeaking,
    @Default({}) Set<int> speakingUserIds,
    @Default(false) bool terminated,
  }) = _VoiceState;
}
