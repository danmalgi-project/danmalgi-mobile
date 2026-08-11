import 'package:collection/collection.dart';
import 'package:danmalgi_mobile/core/providers/app_user_provider.dart';
import 'package:danmalgi_mobile/core/widgets/app_bottom_sheet.dart';
import 'package:danmalgi_mobile/core/widgets/cached_circle_avatar.dart';
import 'package:danmalgi_mobile/features/directmessage/data/providers/direct_message_channel_repository_provider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:danmalgi_mobile/core/generated/dm/v1/dm.pb.dart';
import 'package:image_picker/image_picker.dart';

class DirectMessageChannelListTile extends ConsumerWidget {
  final DirectMessageChannel channel;

  const DirectMessageChannelListTile({super.key, required this.channel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final otherUser = channel.users.firstWhereOrNull(
      (u) => u.id != currentUser?.id,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Material(
        color: Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(22.0),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            context.push('/chat/${channel.dmId}');
          },
          onLongPress: () async {
            print("Long! ${channel.users}");
            await showAppBottomSheet(
              context: context,
              child: Column(
                children: [
                  ListTile(
                    onTap: () async {
                      await Future.delayed(
                        const Duration(milliseconds: 150),
                      ); // 탭 피드백 후
                      if (!context.mounted) return;
                      Navigator.pop(context);
                      await Future.delayed(
                        const Duration(milliseconds: 200),
                      ); // 닫힘 애니메이션 후
                      if (!context.mounted) return;

                      showAppBottomSheet(
                        context: context,
                        isFullScreen: true,
                        title: "그룹 커스터마이징하기",
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                final picker = ImagePicker();
                                final image = await picker.pickImage(
                                  source: ImageSource.gallery,
                                );
                                if (image == null) return;
                                final bytes = await image.readAsBytes();

                                await ref
                                    .read(
                                      directMessageChannelRepositoryProvider,
                                    )
                                    .uploadChannelImage(
                                      id: channel.dmId.toInt(),
                                      imageBytes: bytes,
                                      extension: "jpg",
                                    );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 18.0,
                                  horizontal: 18.0,
                                ),
                                child: Column(
                                  children: [
                                    CachedCircleAvatar(
                                      url: channel.channelImageUrl,
                                      radius: 36.0,
                                    ),

                                    SizedBox(height: 48.0),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("그룹 이름"),
                                        TextField(),
                                        SizedBox(height: 8.0),
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(),
                                            onPressed: () {},
                                            child: Text("변경사항 저장하기"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    title: Text("그룹 커스터마이징"),
                  ),
                ],
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                if (channel.isGroup)
                  CachedCircleAvatar(radius: 22, url: channel.channelImageUrl)
                else if (channel.users.isNotEmpty)
                  CachedCircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.amber,
                    url: otherUser?.profileImageUrl,
                  )
                else
                  // TODO: 삭제 예정 - 목업 데이터 예외처리용
                  const CircleAvatar(radius: 22),

                const SizedBox(width: 12.0),

                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              channel.channelName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),

                            Text(
                              "마지막 대화",
                              style: TextStyle(
                                fontSize: 13.0,
                                color: Color(0xFF8E8E93),
                              ),
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "15분 전",
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Color(0xFF8E8E93),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFFFD60A),
                              ),
                              margin: EdgeInsets.zero,
                              padding: const EdgeInsets.symmetric(
                                vertical: 2.0,
                                horizontal: 6.0,
                              ),
                              child: Text(
                                "1",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xFF1C1C1E),
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
