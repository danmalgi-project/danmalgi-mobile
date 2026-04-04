import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:danmalgi_mobile/features/directmessage/presentation/providers/direct_message_channel_list_view_model.dart';
import 'package:danmalgi_mobile/features/friend/presentation/providers/friend_view_model.dart';
import 'package:danmalgi_mobile/features/friend/presentation/providers/relationship_view_model.dart';

class ScaffoldWithNavBar extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar({required this.navigationShell});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: navigationShell,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Color(0xFF333333),
        unselectedItemColor: Color(0xFFA29898),
        backgroundColor: Colors.white,
        enableFeedback: false,
        elevation: 0.0,
        onTap: (value) {
          switch (value) {
            case 0:
              ref.invalidate(directMessageChannelListViewModelProvider);
              break;
            case 1:
              ref.invalidate(friendViewModelProvider);
              ref.invalidate(relationshipViewModelProvider);
              break;
          }
          navigationShell.goBranch(value);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled, size: 26),
            label: "Home",
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.notifications, size: 30),
          //   label: "Notification",
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt, size: 30),
            label: "Friend",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 31),
            label: "Profile",
          ),
        ],
      ),
      // floatingActionButton: Container(
      //   color: Colors.white,
      //   // padding: const EdgeInsets.symmetric(vertical: 17.0),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     children: _icons.mapIndexed((idx, icon) {
      //       return Expanded(
      //         child: GestureDetector(
      //           behavior: HitTestBehavior.opaque,
      //           onTap: () => navigationShell.goBranch(idx),
      //           child: Container(
      //             // padding: EdgeInsets.symmetric(vertical: 17.0),
      //             height: 64.0,
      //             child: Icon(
      //               icon.icon,
      //               size: icon.size,
      //               color: navigationShell.currentIndex == idx
      //                   ? Color(0xFF333333)
      //                   : Color(0xFFA29898),
      //             ),
      //           ),
      //         ),
      //       );
      //     }).toList(),
      //   ),
      // ),
    );
  }
}
