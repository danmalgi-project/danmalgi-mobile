import 'dart:async';

import 'package:collection/collection.dart';
import 'package:danmalgi_mobile/core/providers/app_user_provider.dart';
import 'package:danmalgi_mobile/core/router/route_paths.dart';
import 'package:danmalgi_mobile/core/widgets/cached_circle_avatar.dart';
import 'package:danmalgi_mobile/features/directmessage/data/providers/direct_message_channel_provider.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:danmalgi_mobile/features/chat/presentation/providers/chat_view_model.dart';
import 'package:danmalgi_mobile/features/chat/presentation/widgets/message_tile.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

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
    final channelAsync = ref.watch(
      directMessageChannelProvider(channelId: widget.channelId),
    );
    final currentUser = ref.watch(currentUserProvider);

    final AsyncValue<List<String>> idsAsync = ref.watch(
      chatViewModelProvider(widget.channelId).select(
        (state) =>
            state.whenData((state) => state.messages.map((m) => m.id).toList()),
      ),
    );

    return channelAsync.when(
      data: (channelState) {
        final otherUser = channelState.users.firstWhereOrNull(
          (u) => u.id != currentUser?.id,
        );

        return Scaffold(
          appBar: AppBar(
            // centerTitle: true,
            // backgroundColor: Color(0xFFF1F3F5),
            // surfaceTintColor: Color(0xFFF1F3F5),
            leading: IconButton(
              icon: SvgPicture.asset('assets/Icons/Icon-left.svg'),
              onPressed: () => context.pop(),
            ),
            titleSpacing: 0,
            title: Row(
              children: [
                if (channelState.isGroup)
                  CachedCircleAvatar(
                    url: channelState.channelImageUrl,
                    radius: 16,
                  )
                else
                  CachedCircleAvatar(
                    url: otherUser?.profileImageUrl,
                    radius: 16,
                  ),
                SizedBox(width: 8),
                Text(
                  channelState.channelName,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          body: Column(
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
                              horizontal: 16,
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
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (err, stack) => Text('Error: $err'),
                ),
              ),
              SizedBox(height: 16),
              SafeArea(
                top: false,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 16.0,
                  ),
                  color: Color(0xFF1C1C1E),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: Material(
                          color: Color(0xFF272729),
                          shape: CircleBorder(),
                          clipBehavior: Clip.antiAlias,
                          child: InkWell(
                            // onTap: () async {
                            //   final picker = ImagePicker();
                            //   final multipleMedia = await picker
                            //       .pickMultipleMedia();
                            //   for (final file in multipleMedia) {
                            //     await ref
                            //         .read(
                            //           chatViewModelProvider(
                            //             widget.channelId,
                            //           ).notifier,
                            //         )
                            //         .sendMessage(content: null, file: file);
                            //   }
                            //   // final bytes = await image.readAsBytes();
                            // },
                            onTap: () async {
                              context.go(
                                RoutePaths.voice(Int64(widget.channelId)),
                              );
                              // final bytes = await image.readAsBytes();
                            },
                            child: const Icon(Icons.add),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            TextField(
                              controller: _messageController,
                              focusNode: _focusNode,
                              onSubmitted: (_) => _sendMessage(),
                              cursorColor: Color(0xFF8E8E93),
                              minLines: 1,
                              maxLines: 3,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(
                                  18,
                                  12,
                                  48,
                                  12,
                                ),
                                filled: true,
                                fillColor: Color(0xFF272729),
                                hintText: "메세지를 입력하세요.",
                                hintStyle: TextStyle(color: Color(0xFF8E8E93)),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                            ),

                            Positioned(
                              right: 15,
                              child: SizedBox(
                                width: 32,
                                height: 32,
                                child: Material(
                                  color: Color(0xFFFFE500),
                                  shape: CircleBorder(),
                                  clipBehavior: Clip.antiAlias,
                                  child: InkWell(
                                    onTap: _sendMessage,
                                    child: const Icon(
                                      Icons.arrow_upward_rounded,
                                      color: Colors.black,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      error: (e, s) => ErrorWidget(e),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
