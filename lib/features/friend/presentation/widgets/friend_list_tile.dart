import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:danmalgi_mobile/core/generated/friend.pb.dart';
import 'package:danmalgi_mobile/core/router/route_paths.dart';
import 'package:danmalgi_mobile/features/directmessage/presentation/providers/direct_message_channel_list_view_model.dart';

class FriendListTile extends ConsumerWidget {
  final Friend friend;

  const FriendListTile({super.key, required this.friend});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.0.h, horizontal: 24.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 19.0),
            GestureDetector(
              onTap: () async {
                showAboutDialog(
                  context: context,
                  children: [
                    Text('NAME: ${friend.user.name}'),
                    Text('TAG: ${friend.user.tag}'),
                    Text('EMAIL: ${friend.user.email}'),
                  ],
                );
              },
              child: CircleAvatar(
                radius: 16.0,
                backgroundColor: Color.fromARGB(255, 56, 56, 56),
              ),
            ),
            SizedBox(width: 17.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  friend.user.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0,
                    color: Color(0xFF565656),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "Memo.",
                  style: TextStyle(fontSize: 10.0, color: Colors.grey),
                  overflow: TextOverflow.fade,
                  maxLines: 4,
                ),
              ],
            ),
            Spacer(),
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFF1F3F5),
                ),
                child: Icon(Icons.call, color: Color(0xFF565656), size: 24.0),
              ),
            ),

            SizedBox(width: 10),
            InkWell(
              onTap: () async {
                final directMessageChannel = await ref
                    .read(directMessageChannelListViewModelProvider.notifier)
                    .createDirectMessageChannel(friendIds: [friend.id]);

                if (directMessageChannel == null) return;

                context.push(
                  RoutePaths.directMessageChannelDetail(
                    directMessageChannel.dmId,
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFF1F3F5),
                ),
                child: Icon(
                  Icons.message,
                  color: Color(0xFF565656),
                  size: 24.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
