import 'dart:async';

import 'package:danmalgi_mobile/core/generated/dm/v1/dm.pbgrpc.dart';
import 'package:danmalgi_mobile/core/widgets/cached_circle_avatar.dart';
import 'package:danmalgi_mobile/features/directmessage/data/providers/direct_message_channel_provider.dart';
import 'package:danmalgi_mobile/features/voice/data/providers/active_voice_session_provider.dart';
import 'package:danmalgi_mobile/features/voice/data/providers/voice_manager_provider.dart';
import 'package:danmalgi_mobile/features/voice/data/providers/voice_screen_visible_provider.dart';
import 'package:danmalgi_mobile/features/voice/domain/voice_state.dart';
import 'package:danmalgi_mobile/features/voice/presentation/providers/voice_view_model.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class VoiceView extends ConsumerStatefulWidget {
  const VoiceView({super.key, required this.channelId});
  final int channelId;

  @override
  ConsumerState<VoiceView> createState() => _VoiceViewState();
}

class _VoiceViewState extends ConsumerState<VoiceView> {
  late final _visible = ref.read(voiceScreenVisibleProvider.notifier);

  @override
  void initState() {
    super.initState();
    Future(() => _visible.set(true));
  }

  @override
  void dispose() {
    Future(() => _visible.set(false));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future(
      () =>
          ref.read(activeVoiceSessionProvider.notifier).start(widget.channelId),
    );

    ref.listen(voiceViewModelProvider(channelId: widget.channelId), (
      previous,
      next,
    ) {
      if (next.value?.terminated == true && context.mounted) {
        ref.read(activeVoiceSessionProvider.notifier).end();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('연결이 불안정하여 통화가 종료되었습니다')));
        context.pop();
      }
    });

    final AsyncValue<DirectMessageChannel> channelAsync = ref.watch(
      directMessageChannelProvider(channelId: widget.channelId),
    );
    final AsyncValue<VoiceState> voiceAsync = ref.watch(
      voiceViewModelProvider(channelId: widget.channelId),
    );
    final VoiceViewModel voiceNotifier = ref.read(
      voiceViewModelProvider(channelId: widget.channelId).notifier,
    );

    return channelAsync.when(
      data: (channelState) {
        return Scaffold(
          backgroundColor: Color(0xFF1C1C1E),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: SizedBox.shrink(),
            leadingWidth: 0,
            titleSpacing: 0,
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    channelState.channelName,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),

                  // TODO: 녹화 기능과 통화 시간 기능이 추가되면 변경
                  if (true) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          width: 8,
                          height: 8,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "REC · ${'12:34'}",
                          style: TextStyle(
                            color: Color(0xFF8E8E93),
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ] else
                    Text("12:34"), // 통화 시간
                  SizedBox(width: 8),
                ],
              ),
            ),
            actions: [_StatusBanner(voiceAsync: voiceAsync)],
          ),
          bottomNavigationBar: _VoiceControls(
            voiceAsync: voiceAsync,
            notifier: voiceNotifier,
          ),
          body: switch (voiceAsync) {
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
                      voiceViewModelProvider(channelId: widget.channelId),
                    ),
                    child: const Text('재시도'),
                  ),
                ],
              ),
            ),

            // 정상 상태
            AsyncData(:final value) => _VoiceBody(
              state: value,
              channelId: widget.channelId,
            ),

            _ => const SizedBox.shrink(),
          },
        );
      },
      error: (e, s) => ErrorWidget(e),
      loading: () => const Center(child: CircularProgressIndicator()),
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

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          const spacing = 16.0;
          const crossAxisCount = 2;
          final itemSize =
              (constraints.maxWidth - spacing * (crossAxisCount - 1)) /
              crossAxisCount;

          final itemProfileSize = itemSize * 0.25;

          return Wrap(
            alignment: WrapAlignment.start,
            spacing: spacing,
            runSpacing: spacing,
            children: [
              for (final user in allUsers)
                SizedBox(
                  width: itemSize,
                  height: itemSize,
                  child: Material(
                    color: const Color(0xFF161618),
                    borderRadius: BorderRadius.circular(18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            CachedCircleAvatar(
                              url: user.imageUrl,
                              radius: itemProfileSize,
                              backgroundColor: Colors.transparent,
                            ),
                            if (state.isMuted)
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Material(
                                  clipBehavior: Clip.antiAlias,
                                  shape: CircleBorder(),
                                  color: Colors.red,
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Icon(
                                      Icons.mic_off_outlined,
                                      size: itemSize * 0.075,
                                    ),
                                  ),
                                ),
                              ),
                            // if (state.trackUserMap.containsValue(user))
                            //   Positioned(
                            //     bottom: 0,
                            //     right: 0,
                            //     child: Material(
                            //       clipBehavior: Clip.antiAlias,
                            //       shape: CircleBorder(),
                            //       color: Colors.red,
                            //       child: Padding(
                            //         padding: const EdgeInsets.all(6.0),
                            //         child: Icon(
                            //           Icons.mic_off_outlined,
                            //           size: itemSize * 0.075,
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          user.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _StatusBanner extends StatelessWidget {
  const _StatusBanner({required this.voiceAsync});
  final AsyncValue voiceAsync;

  @override
  Widget build(BuildContext context) {
    return switch (voiceAsync) {
      AsyncLoading() => _banner(VoiceConnectionStatus.connecting),
      AsyncError() => _banner(VoiceConnectionStatus.failed),
      AsyncData(:final value) => _banner(value.status),
      _ => const SizedBox(),
    };
  }

  Widget _banner(VoiceConnectionStatus status) {
    final (label, color) = switch (status) {
      VoiceConnectionStatus.connecting => ('연결 중', Colors.grey),
      VoiceConnectionStatus.connected => ('연결 양호', Color(0xFF30D158)),
      VoiceConnectionStatus.unstable => ('연결 불안정', Colors.orange),
      VoiceConnectionStatus.failed => ('연결 실패', Colors.red),
    };

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color(0xFF161618),
      ),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Text(label, style: TextStyle(color: color)),
    );
  }
}

class _VoiceControls extends ConsumerWidget {
  const _VoiceControls({required this.voiceAsync, required this.notifier});

  final AsyncValue<VoiceState> voiceAsync;
  final VoiceViewModel notifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isReady = voiceAsync is AsyncData<VoiceState>;
    final isMuted = voiceAsync.value?.isMuted ?? false;

    return Container(
      color: Color(0xFF111112),
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 52,
            height: 52,
            child: Material(
              color: Color(0xFF272729),
              shape: CircleBorder(),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: isReady ? notifier.toggleMicMute : null,
                child: Icon(
                  isMuted ? Icons.mic_off : Icons.mic_none_rounded,
                  color: isMuted ? Colors.red : Colors.white,
                  size: 20.0,
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          SizedBox(
            width: 52,
            height: 52,
            child: Material(
              color: Color(0xFF272729),
              shape: CircleBorder(),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: isReady ? () {} : null,
                child: Icon(Icons.videocam_outlined, size: 20.0),
              ),
            ),
          ),
          SizedBox(width: 12),
          SizedBox(
            width: 52,
            height: 52,
            child: Material(
              color: Color(0xFF272729),
              shape: CircleBorder(),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: isReady ? () {} : null,
                child: Icon(Icons.monitor, size: 20.0),
              ),
            ),
          ),
          SizedBox(width: 12),
          SizedBox(
            width: 52,
            height: 52,
            child: Material(
              color: Color(0xFF272729),
              shape: CircleBorder(),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: isReady ? () {} : null,
                child: Icon(Icons.emoji_emotions_outlined, size: 20.0),
              ),
            ),
          ),
          SizedBox(width: 12),
          SizedBox(
            width: 52,
            height: 52,
            child: Material(
              color: Color(0xFFFF2121),
              shape: CircleBorder(),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: isReady
                    ? () {
                        ref.read(activeVoiceSessionProvider.notifier).end();
                        context.pop();
                      }
                    : null,
                child: Icon(Icons.phone_disabled_outlined, size: 20.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
