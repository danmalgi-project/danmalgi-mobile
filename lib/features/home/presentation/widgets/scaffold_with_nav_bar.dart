import 'package:danmalgi_mobile/core/widgets/bottom_nav_svg_icon.dart';
import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      bottomNavigationBar: Container(
        color: const Color(0xFF121212),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: BottomNavigationBar(
          currentIndex: navigationShell.currentIndex,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: Color(0xFFFFE500),
          unselectedItemColor: Color(0xFF8E8E93),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          onTap: (value) {
            switch (value) {
              case 1:
                ref.invalidate(directMessageChannelListViewModelProvider);
                break;
              case 2:
                ref.invalidate(friendViewModelProvider);
                ref.invalidate(relationshipViewModelProvider);
                break;
            }
            navigationShell.goBranch(value);
          },
          items: [
            BottomNavigationBarItem(
              icon: const BottomNavSvgIcon('assets/Icons/Icon-home.svg'),
              label: "홈",
            ),
            BottomNavigationBarItem(
              icon: const BottomNavSvgIcon('assets/Icons/Icon-message.svg'),
              label: "DM",
            ),
            BottomNavigationBarItem(
              icon: const BottomNavSvgIcon('assets/Icons/Icon-server.svg'),
              label: "친구",
            ),
            BottomNavigationBarItem(
              icon: const BottomNavSvgIcon('assets/Icons/Icon-user.svg'),
              label: "프로필",
            ),
          ],
        ),
      ),
    );
  }
}
