// test/mocks/mock_voice_repository.dart

import 'dart:async';

import 'package:danmalgi_mobile/features/user/domain/user.dart';
import 'package:danmalgi_mobile/features/voice/domain/voice_manager.dart';
import 'package:danmalgi_mobile/features/voice/domain/voice_state.dart';

class MockVoiceManager implements VoiceManager {
  final _stateController = StreamController<VoiceState>.broadcast();

  bool joinCalled = false;
  Exception? joinException;
  bool isMuted = false;

  // 테스트에서 상태를 직접 주입
  void emit(VoiceState state) => _stateController.add(state);

  // 자주 쓰는 시나리오는 헬퍼로
  void emitConnected() => emit(
    const VoiceState(isConnected: true, statusMessage: '✅ WebRTC 연결 완료'),
  );

  void emitUsers(List<User> users) => emit(VoiceState(users: users));

  void emitError(String message) =>
      emit(VoiceState(isConnected: false, statusMessage: '❌ $message'));

  @override
  Stream<VoiceState> get stateStream => _stateController.stream;

  @override
  Future<void> join() async {
    joinCalled = true;
    if (joinException != null) throw joinException!;
  }

  @override
  Future<void> toggleMicMute(bool mute) async {
    isMuted = mute;
  }

  @override
  Future<void> dispose() async {
    await _stateController.close();
  }
}
