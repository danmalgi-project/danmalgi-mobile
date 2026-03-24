import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:danmalgi_mobile/features/chat/presentation/providers/chat_view_model.dart';
import 'package:danmalgi_mobile/features/chat/presentation/widgets/message_tile.dart';

class ChatView extends ConsumerStatefulWidget {
  final int channelId;

  const ChatView({super.key, required this.channelId});

  @override
  ConsumerState<ChatView> createState() => ChatViewState();
}

class ChatViewState extends ConsumerState<ChatView> {
  final FocusNode _focusNode = FocusNode();

  final ScrollController _scrollController = ScrollController();

  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _modifyTextEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _focusNode.dispose();

    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();

    _messageController.dispose();
    _modifyTextEditingController.dispose();

    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent * 0.8) {
      final state = ref.read(chatViewModelProvider(widget.channelId)).value;

      if (state == null) return;

      final messages = state.messages;

      if (messages.isEmpty) return;

      String lastMessageId = messages.last.id;

      ref
          .read(chatViewModelProvider(widget.channelId).notifier)
          .getPreviousMessages(
            channelId: widget.channelId,
            messageId: int.parse(lastMessageId),
          );
    }
  }

  Future<void> _sendMessage() async {
    final content = _messageController.text;
    _messageController.clear();

    if (content.trim() == "") return;

    await ref
        .read(chatViewModelProvider(widget.channelId).notifier)
        .sendMessage(content: content);

    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<String>> idsAsync = ref.watch(
      chatViewModelProvider(widget.channelId).select(
        (state) =>
            state.whenData((state) => state.messages.map((m) => m.id).toList()),
      ),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: idsAsync.when(
            data: (ids) {
              return GestureDetector(
                onTap: _focusNode.unfocus,
                child: CustomScrollView(
                  reverse: true,
                  controller: _scrollController,
                  physics: AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 4,
                      ),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          findChildIndexCallback: (key) {
                            if (key is ValueKey<String>) {
                              final index = ids.indexOf(key.value);
                              return index != -1 ? index : null;
                            }
                            return null;
                          },
                          childCount: ids.length,
                          (context, index) {
                            final id = ids[index];

                            return Padding(
                              key: ValueKey(id),
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: MessageTile(
                                messageId: id,
                                channelId: widget.channelId,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Text('Error: $err'),
          ),
        ),
        SizedBox(height: 16.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Stack(
            alignment: Alignment.center,
            children: [
              TextField(
                controller: _messageController,
                focusNode: _focusNode,
                onSubmitted: (_) => _sendMessage(),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                    left: 24,
                    top: 18,
                    right: 48,
                    bottom: 18,
                  ),
                  hintText: "메세지를 입력해주세요.",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              Positioned(
                right: 15,
                child: IconButton(
                  onPressed: _sendMessage,
                  icon: const Icon(Icons.send_rounded),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 44.h),
      ],
    );
  }
}
