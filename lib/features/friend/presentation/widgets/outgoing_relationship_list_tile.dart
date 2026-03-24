import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:danmalgi_mobile/core/generated/relationship.pb.dart';

class OutgoingRelationshipListTile extends ConsumerWidget {
  final Relationship relationship;

  const OutgoingRelationshipListTile({super.key, required this.relationship});

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
                showAboutDialog(context: context, children: [
                    
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
                  "${relationship.user.name}#${relationship.user.tag}",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0,
                    color: Color(0xFF565656),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "수락 대기중...",
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
                child: Icon(
                  Icons.cancel_outlined,
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
