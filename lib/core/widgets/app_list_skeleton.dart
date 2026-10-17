import 'package:danmalgi_mobile/core/theme/app_colors.dart';
import 'package:danmalgi_mobile/core/theme/app_dimens.dart';
import 'package:flutter/material.dart';

class AppListSkeleton extends StatefulWidget {
  const AppListSkeleton({super.key});

  @override
  State<AppListSkeleton> createState() => _AppListSkeletonState();
}

class _AppListSkeletonState extends State<AppListSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat(reverse: true);

  late final Animation<double> _opacity = Tween(
    begin: 0.4,
    end: 1.0,
  ).chain(CurveTween(curve: Curves.easeInOut)).animate(_controller);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final list = SliverList.builder(
      itemCount: 8,
      itemBuilder: (_, _) => const _AppListTileSkeleton(),
    );

    if (MediaQuery.disableAnimationsOf(context)) return list;
    return SliverFadeTransition(opacity: _opacity, sliver: list);
  }
}

class _AppListTileSkeleton extends StatelessWidget {
  const _AppListTileSkeleton();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(AppSpacing.s12),
      child: Row(
        spacing: AppSpacing.s12,
        children: [
          CircleAvatar(
            radius: AppAvatarSize.md,
            backgroundColor: AppColors.surfaceSecondary,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSpacing.s8,
            children: [
              _SkeletonBar(width: 104, height: 14),
              _SkeletonBar(width: 176, height: 12),
            ],
          ),
        ],
      ),
    );
  }
}

class _SkeletonBar extends StatelessWidget {
  final double width;
  final double height;

  const _SkeletonBar({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        color: AppColors.surfaceSecondary,
        borderRadius: AppRadius.brPill,
      ),
    );
  }
}
