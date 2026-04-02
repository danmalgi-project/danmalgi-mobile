import 'package:danmalgi_mobile/features/user/domain/user.dart';
import 'package:danmalgi_mobile/features/voice/data/providers/voice_manager_provider.dart';
import 'package:danmalgi_mobile/features/voice/data/managers/mock_voice_manager.dart';
import 'package:danmalgi_mobile/features/voice/domain/voice_state.dart';
import 'package:danmalgi_mobile/features/voice/presentation/providers/voice_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('VoiceViewModel 테스트', () {
    late MockVoiceManager mockRepo;
    late ProviderContainer container;

    setUp(() {
      mockRepo = MockVoiceManager();
      container = ProviderContainer(
        overrides: [
          // Mock으로 교체 — 이 한 줄이 전부
          voiceRepositoryProvider(channelId: 1).overrideWith((_) => mockRepo),
        ],
      );
    });

    tearDown(() async {
      container.dispose();
    });

    test('Step A: join()이 호출되는지 확인', () async {
      // build()가 실행되면 join()이 자동 호출되어야 함
      await container.read(voiceViewModelProvider(channelId: 1).future);

      expect(mockRepo.joinCalled, isTrue);
      print('✅ join() 호출 확인');
    });

    test('Step B: statusStream 이벤트가 state에 반영되는지 확인', () async {
      await container.read(voiceViewModelProvider(channelId: 1).future);

      // Mock에서 직접 이벤트 발생
      mockRepo.emitConnected();

      // stream이 처리될 시간을 줌
      await Future.delayed(Duration.zero);

      final state = container.read(voiceViewModelProvider(channelId: 1)).value!;

      expect(state.statusMessage, '✅ Peer 연결 완료!');
      expect(state.isConnected, isTrue);
      print('✅ statusStream → state 반영 확인: ${state.statusMessage}');
    });

    test('Step C: usersStream 이벤트가 state에 반영되는지 확인', () async {
      await container.read(voiceViewModelProvider(channelId: 1).future);

      final users = [
        User(id: 1, name: 'Alice', email: 'alice@danmalgi.com', tag: '1234'),
        User(id: 2, name: 'Bob', email: 'bob@danmalgi.com', tag: '5678'),
      ];
      mockRepo.emitUsers(users);

      await Future.delayed(Duration.zero);

      final state = container.read(voiceViewModelProvider(channelId: 1)).value!;

      expect(state.users.length, 2);
      expect(state.users.first.name, 'Alice');
      print('✅ usersStream → state 반영 확인: ${state.users.map((u) => u.name)}');
    });

    test('Step D: join() 실패 시 error state가 되는지 확인', () async {
      // join()이 예외를 던지도록 설정
      mockRepo.joinException = Exception('서버 연결 실패');

      await container
          .read(voiceViewModelProvider(channelId: 1).future)
          .catchError((_) => const VoiceState()); // 예외 무시

      final state = container.read(voiceViewModelProvider(channelId: 1));

      expect(state.hasError, isTrue);
      print('✅ 에러 상태 확인: ${state.error}');
    });

    test('Step E: dispose 시 구독이 정리되는지 확인', () async {
      await container.read(voiceViewModelProvider(channelId: 1).future);

      // container dispose → ref.onDispose 트리거
      container.dispose();

      // dispose 후 이벤트를 emit해도 에러가 없어야 함
      // (이미 stream이 닫혔으므로)
      expect(() => mockRepo.emitError('late event'), throwsA(anything));
      print('✅ dispose 후 stream 정리 확인');
    });
  });
}
