import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:danmalgi_mobile/core/generated/dm/v1/dm.pb.dart';

class DirectMessageChannelListTile extends ConsumerWidget {
  final DirectMessageChannel channel;

  const DirectMessageChannelListTile({super.key, required this.channel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        context.push('/direct-message/${channel.dmId}');
      },
      child: Container(
        child: Padding(
          padding: EdgeInsets.only(left: 16.0, top: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                foregroundImage: NetworkImage(
                  'https://picsum.photos/${200 + channel.dmId.toInt()}',
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(right: 10.0, bottom: 12.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color.fromRGBO(60, 60, 67, 0.4),
                        width: 0.35,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                              "설명",
                              style: TextStyle(
                                fontSize: 13.0,
                                color: Colors.grey,
                              ),
                              overflow: TextOverflow.fade,
                              maxLines: 4,
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
        ),
      ),
    );
  }
}
