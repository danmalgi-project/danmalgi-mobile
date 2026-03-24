import 'package:danmalgi_mobile/core/widgets/async_value_handler.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:danmalgi_mobile/features/chat/presentation/providers/chat_view_model.dart';
import 'package:danmalgi_mobile/features/chat/presentation/views/chat_view.dart';
import 'package:danmalgi_mobile/features/directmessage/presentation/providers/direct_message_channel_view_model.dart';
import 'package:danmalgi_mobile/features/voice/presentation/views/voice_view.dart';

class DirectMessageChannelView extends ConsumerWidget {
  final int channelId;
  const DirectMessageChannelView({super.key, required this.channelId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final channelAsync = ref.watch(
      directMessageChannelViewModelProvider(channelId),
    );

    final currentState = channelAsync.value;

    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        backgroundColor: Color(0xFFF1F3F5),
        surfaceTintColor: Color(0xFFF1F3F5),
        title: Text(
          currentState?.channel.channelName ?? '채팅방 불러오는 중...',
          style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold),
        ),
        actions: [
          if (currentState != null)
            IconButton(
              onPressed: () async {
                if (currentState.isCalling) {
                  await ref
                      .read(
                        directMessageChannelViewModelProvider(
                          channelId,
                        ).notifier,
                      )
                      .hangOut();
                } else {
                  await ref
                      .read(
                        directMessageChannelViewModelProvider(
                          channelId,
                        ).notifier,
                      )
                      .call();

                  await ref
                      .read(chatViewModelProvider(channelId).notifier)
                      .sendMessage(content: "/call");
                }
              },
              icon: Icon(
                currentState.isCalling ? Icons.phone_disabled : Icons.phone,
                color: currentState.isCalling ? Colors.red : Colors.black,
              ),
            ),
        ],
      ),
      resizeToAvoidBottomInset: true,
      body: AsyncValueHandler(
        asyncValue: channelAsync,
        onRetry: () => ref.invalidate(directMessageChannelViewModelProvider),
        builder: (state) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              (state.isCalling)
                  ? Expanded(flex: 1, child: VoiceView())
                  : SizedBox(),
              Divider(),
              Expanded(flex: 3, child: ChatView(channelId: channelId)),
            ],
          );
        },
      ),
    );
  }
}
