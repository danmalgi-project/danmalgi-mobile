import 'package:danmalgi_mobile/core/theme/app_colors.dart';
import 'package:danmalgi_mobile/core/theme/app_dimens.dart';
import 'package:danmalgi_mobile/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:danmalgi_mobile/features/directmessage/presentation/providers/direct_message_channel_list_view_model.dart';
import 'package:danmalgi_mobile/features/friend/presentation/providers/friend_view_model.dart';
import 'package:danmalgi_mobile/features/friend/presentation/providers/relationship_view_model.dart';

const _kTabAnimDuration = Duration(milliseconds: 220);

class ScaffoldWithNavBar extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar({super.key, required this.navigationShell});

  static const _items = [
    ('assets/Icons/Icon-message.svg', 'DM'),
    ('assets/Icons/Icon-user.svg', '친구'),
    ('assets/Icons/Icon-user.svg', '설정'),
  ];

  void _onTap(WidgetRef ref, int index) {
    switch (index) {
      case 0:
        ref.invalidate(directMessageChannelListViewModelProvider);
      case 1:
        ref.invalidate(friendViewModelProvider);
        ref.invalidate(relationshipViewModelProvider);
    }
    navigationShell.goBranch(index);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: ColoredBox(
        color: AppColors.surfaceNav,
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.s12),
            child: Row(
              children: [
                for (final (i, (icon, label)) in _items.indexed)
                  Expanded(
                    child: _NavTab(
                      iconPath: icon,
                      label: label,
                      selected: navigationShell.currentIndex == i,
                      onTap: () => _onTap(ref, i),
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

class _NavTab extends StatelessWidget {
  const _NavTab({
    required this.iconPath,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String iconPath;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final iconTheme = IconTheme.of(context);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (!selected) HapticFeedback.selectionClick();
        onTap();
      },
      child: TweenAnimationBuilder<Color?>(
        tween: ColorTween(
          end: selected ? AppColors.accent : AppColors.iconInactive,
        ),
        duration: _kTabAnimDuration,
        builder: (context, color, _) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconTheme.merge(
              data: IconThemeData(color: color, size: 20),
              child: SvgPicture.asset(
                iconPath,
                width: iconTheme.size,
                height: iconTheme.size,
                colorFilter: ColorFilter.mode(color!, BlendMode.srcIn),
              ),
            ),
            const SizedBox(height: AppSpacing.s4),
            Text(label, style: AppTypography.tab.copyWith(color: color)),
          ],
        ),
      ),
    );
  }
}
