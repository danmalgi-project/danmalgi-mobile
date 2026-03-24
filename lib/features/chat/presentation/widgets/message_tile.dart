import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:danmalgi_mobile/features/chat/domain/message.dart';
import 'package:danmalgi_mobile/features/chat/presentation/providers/chat_view_model.dart';

class MessageTile extends ConsumerWidget {
  final int channelId;
  final String messageId;

  const MessageTile({
    super.key,
    required this.channelId,
    required this.messageId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final message = ref.watch(
      chatViewModelProvider(channelId).select(
        (state) => state.value?.messages.firstWhere(
          (m) => m.id == messageId,
          // 삭제된 경우 처리 (선택사항)
          // orElse: () => ChatMessage(id: 'deleted', content: '삭제된 메시지'),
        ),
      ),
    );

    if (message == null) return const SizedBox.shrink();

    final bool showProfile = ref.watch(
      chatViewModelProvider(channelId).select((state) {
        final messages = state.value!.messages;

        final beforeIndex = messages.indexOf(message) + 1;
        if (beforeIndex > messages.length - 1 || beforeIndex < 0) return true;

        final timeDiff = message.createdAt.difference(
          messages[beforeIndex].createdAt,
        );

        // print('--------------------------------------------------');
        // print(
        //   'before: ${messages[beforeIndex].content}, ${messages[beforeIndex].user.id}',
        // );
        // print('current: ${message.content}, ${message.user.id}');
        // print('diff: ${timeDiff}');

        if (messages[beforeIndex].user.id == message.user.id) {
          if (timeDiff > Duration(minutes: 5)) {
            return true;
          } else {
            return false;
          }
        } else {
          return true;
        }
      }),
    );

    return
    // return (message.content == "/call")
    //     ? Padding(
    //         padding: EdgeInsets.symmetric(veㄱrtical: 12.0),
    //         child: GestureDetector(
    //           onTap: () async => await ref
    //               .read(
    //                 directMessageChannelViewModelProvider(
    //                   message.channelId.toInt(),
    //                 ).notifier,
    //               )
    //               .call(),
    //           child: Container(
    //             padding: EdgeInsets.symmetric(vertical: 20, horizontal: 32),
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(8),
    //               color: Color(0xFF333333),
    //               boxShadow: [
    //                 BoxShadow(
    //                   color: Colors.grey.withOpacity(0.7),
    //                   blurRadius: 1.0,
    //                   spreadRadius: 0.0,
    //                   offset: const Offset(1, 0.25),
    //                 ),
    //               ],
    //             ),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: [
    //                 Icon(Icons.phone, color: Colors.white),
    //                 SizedBox(width: 8),
    //                 Text(
    //                   "전화가 왔습니다",
    //                   overflow: TextOverflow.clip,
    //                   softWrap: true,
    //                   style: TextStyle(
    //                     fontWeight: FontWeight.bold,
    //                     fontSize: 14,
    //                     color: Colors.white,
    //                   ),
    //                 ),
    //                 Spacer(),
    //                 Icon(Icons.arrow_forward_rounded, color: Colors.white),
    //               ],
    //             ),
    //           ),
    //         ),
    //       )
    //     :
    Row(
      mainAxisAlignment: (message.isAuthor)
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        // Visibility(
        //   visible: !(message.isAuthor || showProfile),
        //   maintainAnimation: true,
        //   maintainSize: true,
        //   maintainState: true,
        //   child: CircleAvatar(),
        // ),
        // Opacity(
        //   opacity: !(message.isAuthor || showProfile) ? 1 : 0,
        //   child: SizedBox(width: 8),
        // ),
        (message.isAuthor)
            ? SizedBox(width: 48)
            : (showProfile)
            ? CircleAvatar()
            : SizedBox(width: 48),
        (message.isAuthor)
            ? SizedBox()
            : (showProfile)
            ? SizedBox(width: 8)
            : SizedBox(),
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              (message.isAuthor)
                  ? SizedBox()
                  : (showProfile)
                  ? Text(message.user.name)
                  : SizedBox(),
              (message.isAuthor)
                  ? SizedBox()
                  : (showProfile)
                  ? SizedBox(height: 8)
                  : SizedBox(),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: (message.isAuthor)
                      ? Color(0xFF333333)
                      : Color(0xFFF1F3F5),
                ),
                child: GestureDetector(
                  onLongPress: () {
                    if (message.isAuthor) {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                          ),
                        ),
                        builder: (BuildContext context) {
                          TextEditingController modifyTextEditingController =
                              TextEditingController();
                          return Padding(
                            padding: MediaQuery.of(context).viewInsets,
                            child: Container(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  SizedBox(width: double.infinity, height: 20),
                                  Text("${message.createdAt}"),
                                  SizedBox(width: double.infinity, height: 10),
                                  Text("선택한 메세지 : ${message.id}"),
                                  Text("선택한 메세지 : ${message.content}"),
                                  SizedBox(width: double.infinity, height: 10),
                                  TextFormField(
                                    controller: modifyTextEditingController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please Enter Modify Text';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter Modify Text',
                                      labelText: 'Modify Text',
                                    ),
                                  ),
                                  ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      minWidth: double.infinity,
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        await ref
                                            .read(
                                              chatViewModelProvider(
                                                int.parse(message.channelId),
                                              ).notifier,
                                            )
                                            .modifyMessage(
                                              messageId: Int64.parseInt(
                                                message.id,
                                              ),
                                              content:
                                                  modifyTextEditingController
                                                      .text,
                                            );
                                        modifyTextEditingController.clear();
                                        Navigator.of(context).pop();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        "수정",
                                        style: TextStyle(color: Colors.black87),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: double.infinity, height: 20),
                                  ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      minWidth: double.infinity,
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        await ref
                                            .read(
                                              chatViewModelProvider(
                                                int.parse(message.channelId),
                                              ).notifier,
                                            )
                                            .deleteMessage(
                                              messageId: Int64.parseInt(
                                                message.id,
                                              ),
                                            );
                                        Navigator.of(context).pop();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        "삭제",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                  child: Text(
                    message.content,
                    overflow: TextOverflow.clip,
                    softWrap: true,
                    style: TextStyle(
                      color: (message.isAuthor) ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
