import 'package:danmalgi_mobile/core/router/route_paths.dart';
import 'package:danmalgi_mobile/core/theme/app_dimens.dart';
import 'package:danmalgi_mobile/core/widgets/app_icon.dart';
import 'package:danmalgi_mobile/core/widgets/app_scaffold.dart';
import 'package:danmalgi_mobile/features/friend/presentation/providers/friend_view_model.dart';
import 'package:danmalgi_mobile/features/friend/presentation/providers/relationship_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FriendView extends ConsumerWidget {
  const FriendView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      title: '친구',
      padded: false,
      actions: [
        IconButton(
          tooltip: '검색',
          icon: const AppIcon(AppIconType.search),
          onPressed: () {},
        ),
        IconButton(
          tooltip: '친구 추가',
          icon: const AppIcon(AppIconType.addFriend),
          onPressed: () => context.push(RoutePaths.addFriend),
        ),
      ],
      body: RefreshIndicator(
        onRefresh: () => Future.wait([
          ref.refresh(friendViewModelProvider.future),
          ref.refresh(relationshipViewModelProvider.future),
        ]),
        child: const CustomScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          slivers: [_FriendSection()],
        ),
      ),
    );
  }
}

class _FriendSection extends ConsumerWidget {
  const _FriendSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final friends = ref.watch(friendViewModelProvider);

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.s16,
        AppSpacing.s20,
        AppSpacing.s16,
        AppSpacing.s24,
      ),
      sliver: friends.when(
        data: (state) => SliverList.builder(
          itemCount: state.friendList.length,
          itemBuilder: (context, index) =>
              Text(state.friendList[index].user.name),
        ),
        loading: () => const SliverFillRemaining(
          hasScrollBody: false,
          child: Center(child: CircularProgressIndicator()),
        ),
        error: (_, _) => const SliverFillRemaining(
          hasScrollBody: false,
          child: Center(child: Text('불러오지 못했습니다')),
        ),
      ),
    );
  }
}
