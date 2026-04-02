import 'dart:async';

import 'package:danmalgi_mobile/features/voice/domain/voice_state.dart';
import 'package:danmalgi_mobile/features/voice/presentation/providers/voice_view_model.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class VoiceScreen extends ConsumerWidget {
  const VoiceScreen({super.key, required this.channelId});
  final int channelId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(voiceViewModelProvider(channelId: channelId));

    return Scaffold(
      // appBar: AppBar(title: const Text('음성 채널')),
      body: switch (state) {
        // gRPC 연결 + join() 진행 중
        AsyncLoading() => const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 12),
              Text('채널 연결 중...'),
            ],
          ),
        ),

        // join() 실패
        AsyncError(:final error) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('연결 실패: $error'),
              ElevatedButton(
                onPressed: () => ref.invalidate(
                  voiceViewModelProvider(channelId: channelId),
                ),
                child: const Text('재시도'),
              ),
            ],
          ),
        ),

        // 정상 상태
        AsyncData(:final value) => _VoiceBody(
          state: value,
          channelId: channelId,
        ),

        _ => const SizedBox(),
      },
    );
  }
}

class _VoiceBody extends ConsumerWidget {
  const _VoiceBody({required this.state, required this.channelId});
  final VoiceState state;
  final int channelId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allUsers = [
      if (state.currentUser != null) state.currentUser!,
      ...state.users,
    ];

    return Column(
      children: [
        // 연결 상태 배너
        _StatusBanner(
          isConnected: state.isConnected,
          message: state.statusMessage,
        ),

        // 참여자 목록
        Expanded(
          child: ListView.builder(
            itemCount: allUsers.length,
            itemBuilder: (context, index) {
              final user = allUsers[index];
              final isMe = user.id == state.currentUser?.id;
              final isSpeaking = isMe
                  ? state.isSpeaking
                  : state.speakingUserIds.contains(user.id);
              return ListTile(
                title: Text(isMe ? '${user.name} (나)' : user.name),
                leading: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: isSpeaking
                        ? Border.all(color: Colors.green, width: 2.5)
                        : null,
                  ),
                  child: CircleAvatar(child: Text(user.name[0])),
                ),
                trailing: isMe
                    ? state.isMuted
                          ? const Icon(Icons.mic_off, color: Colors.grey)
                          : const Icon(Icons.mic, color: Colors.blue)
                    : state.trackUserMap.containsValue(user)
                    ? const Icon(Icons.mic, color: Colors.green)
                    : const Icon(Icons.mic_off, color: Colors.grey),
              );
            },
          ),
        ),

        // 하단 컨트롤
        _VoiceControls(channelId: channelId),
      ],
    );
  }
}

class _StatusBanner extends StatelessWidget {
  const _StatusBanner({required this.isConnected, required this.message});
  final bool isConnected;
  final String message;

  @override
  Widget build(BuildContext context) {
    if (message.isEmpty) return const SizedBox();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: isConnected ? Colors.green.shade100 : Colors.orange.shade100,
      child: Text(
        message,
        style: TextStyle(
          color: isConnected ? Colors.green.shade800 : Colors.orange.shade800,
        ),
      ),
    );
  }
}

class _VoiceControls extends ConsumerWidget {
  const _VoiceControls({required this.channelId});
  final int channelId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 나중에 음소거 등 추가될 때 여기서 ViewModel 메서드 호출
    final notifier = ref.read(
      voiceViewModelProvider(channelId: channelId).notifier,
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () => notifier.toggleMicMute(),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        child: const Text('마이크 음소거'),
      ),
    );
  }
}
