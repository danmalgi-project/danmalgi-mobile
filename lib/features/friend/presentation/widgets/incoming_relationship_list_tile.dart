import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:danmalgi_mobile/core/generated/relationship/v1/relationship.pb.dart';
import 'package:danmalgi_mobile/features/friend/presentation/providers/relationship_view_model.dart';

class IncomingRelationshipListTile extends ConsumerWidget {
  final Relationship relationship;

  const IncomingRelationshipListTile({super.key, required this.relationship});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28.0),
          ),
          color: Color(0xFF333333),
          shadowColor: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  flex: 6,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Image.network(
                      "https://pbs.twimg.com/profile_images/1568998644673843202/CZgQSNk8_400x400.jpg",
                    ),
                  ),
                ),
                SizedBox(width: 12.0),
                Expanded(
                  flex: 8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // CircleAvatar(
                          //   radius: 12,
                          //   backgroundColor: Colors.white,
                          // ),
                          // SizedBox(width: 8.0),
                          Flexible(
                            child: Text(
                              "${relationship.user.name}#${relationship.user.tag}",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Colors.white,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.0),
                      GestureDetector(
                        onTap: () {
                          ref
                              .read(relationshipViewModelProvider.notifier)
                              .updateIncomingRelationshipStatus(
                                relationship: relationship,
                                isAccept: true,
                              );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            color: Colors.white,
                          ),
                          child: Text(
                            "수락하기",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
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
        Positioned(
          right: -5,
          top: -5,
          child: GestureDetector(
            onTap: () {
              ref
                  .read(relationshipViewModelProvider.notifier)
                  .updateIncomingRelationshipStatus(
                    relationship: relationship,
                    isAccept: false,
                  );
            },
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Icon(Icons.close, size: 20),
            ),
          ),
        ),
      ],
    );
  }
}
