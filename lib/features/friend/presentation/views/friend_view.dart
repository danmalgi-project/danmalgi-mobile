import 'package:danmalgi_mobile/core/extensions/date_time_extensions.dart';
import 'package:danmalgi_mobile/core/generated/friend/v1/friend.pb.dart';
import 'package:danmalgi_mobile/core/generated/relationship/v1/relationship.pbgrpc.dart';
import 'package:danmalgi_mobile/core/router/route_paths.dart';
import 'package:danmalgi_mobile/core/theme/app_colors.dart';
import 'package:danmalgi_mobile/core/theme/app_dimens.dart';
import 'package:danmalgi_mobile/core/theme/app_typography.dart';
import 'package:danmalgi_mobile/core/widgets/app_bottom_sheet.dart';
import 'package:danmalgi_mobile/core/widgets/app_empty_state.dart';
import 'package:danmalgi_mobile/core/widgets/app_icon.dart';
import 'package:danmalgi_mobile/core/widgets/app_list_item.dart';
import 'package:danmalgi_mobile/core/widgets/app_scaffold.dart';
import 'package:danmalgi_mobile/core/widgets/cached_circle_avatar.dart';
import 'package:danmalgi_mobile/features/directmessage/presentation/providers/direct_message_channel_list_view_model.dart';
import 'package:danmalgi_mobile/features/friend/presentation/providers/friend_view_model.dart';
import 'package:danmalgi_mobile/features/friend/presentation/providers/relationship_view_model.dart';
import 'package:danmalgi_mobile/features/friend/presentation/widgets/friend_section_header.dart';
import 'package:danmalgi_mobile/features/friend/presentation/widgets/name_with_tag.dart';
import 'package:fixnum/fixnum.dart';
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
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: AppSpacing.s20)),
            _ReceivedRequestSection(),
            _FriendSection(),
          ],
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
      padding: const EdgeInsets.only(
        left: AppSpacing.s16,
        right: AppSpacing.s16,
        bottom: AppSpacing.s24,
      ),
      sliver: friends.when(
        data: (state) => state.friendList.isEmpty
            ? SliverFillRemaining(
                hasScrollBody: false,
                child: AppEmptyState(
                  title: '아직 친구가 없어요',
                  message: '친구를 추가하고 대화를 시작해 보세요.',
                  actions: [
                    ElevatedButton(
                      onPressed: () => context.push(RoutePaths.addFriend),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(220, 44),
                        padding: EdgeInsets.zero,
                        textStyle: AppTypography.body,
                      ),
                      child: const Text("친구 추가하기"),
                    ),
                  ],
                ),
              )
            : SliverMainAxisGroup(
                slivers: [
                  SliverToBoxAdapter(
                    child: FriendSectionHeader(
                      title: '친구 목록',
                      count: state.friendList.length,
                    ),
                  ),
                  SliverList.builder(
                    itemCount: state.friendList.length,
                    itemBuilder: (context, index) {
                      final friend = state.friendList[index];
                      return AppListItem(
                        leading: CachedCircleAvatar(
                          url: friend.user.profileImageUrl,
                          radius: AppAvatarSize.md,
                          seed: friend.user.id.toInt(),
                        ),
                        title: NameWithTag(
                          name: friend.user.name,
                          tag: friend.user.tag,
                        ),
                        onTap: () => _openDirectMessage(context, ref, friend),
                      );
                    },
                  ),
                ],
              ),
        loading: () => _FriendListSkeleton(),
        error: (_, _) => SliverFillRemaining(
          hasScrollBody: false,
          child: AppEmptyState(
            title: '불러오지 못했어요',
            message: '잠시 후 다시 시도해주세요.',
            actions: [
              TextButton(
                onPressed: () => ref.invalidate(friendViewModelProvider),
                child: const Text('다시 시도'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openDirectMessage(
    BuildContext context,
    WidgetRef ref,
    Friend friend,
  ) async {
    final channel = await ref
        .read(directMessageChannelListViewModelProvider.notifier)
        .createDirectMessageChannel(friendIds: [friend.user.id]);

    if (channel == null || !context.mounted) return;
    context.push(RoutePaths.chat(channel.dmId));
  }
}

class _FriendListSkeleton extends StatefulWidget {
  const _FriendListSkeleton();

  @override
  State<_FriendListSkeleton> createState() => __FriendListSkeletonState();
}

class __FriendListSkeletonState extends State<_FriendListSkeleton>
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
      itemBuilder: (_, _) => const _FriendTileSkeleton(),
    );

    if (MediaQuery.disableAnimationsOf(context)) return list;
    return SliverFadeTransition(opacity: _opacity, sliver: list);
  }
}

class _FriendTileSkeleton extends StatelessWidget {
  const _FriendTileSkeleton();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(AppSpacing.s12),
      child: Row(
        spacing: AppSpacing.s12,
        children: [
          CircleAvatar(radius: 24, backgroundColor: AppColors.surfaceSecondary),
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

class _ReceivedRequestSection extends ConsumerStatefulWidget {
  const _ReceivedRequestSection();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ReceivedRequestSectionState();
}

class _ReceivedRequestSectionState
    extends ConsumerState<_ReceivedRequestSection> {
  final _pending = <Int64>{};

  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final requests = ref.watch(
      relationshipViewModelProvider.select(
        (s) => s.value?.incomingRelationshipList ?? const <Relationship>[],
      ),
    );

    if (requests.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    const maxCollapsed = 3;
    final canExpand = requests.length > maxCollapsed;
    final visible = (_expanded || !canExpand)
        ? requests
        : requests.take(maxCollapsed);

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.s16,
        0,
        AppSpacing.s16,
        AppSpacing.s24,
      ),
      sliver: SliverToBoxAdapter(
        child: Material(
          color: AppColors.surfacePrimary,
          borderRadius: AppRadius.brLg,
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.only(
              top: AppSpacing.s12,
              bottom: AppSpacing.s4,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.s16,
                    vertical: AppSpacing.s6,
                  ),
                  child: FriendSectionHeader(
                    title: '친구 요청',
                    count: requests.length,
                    trailing: canExpand
                        ? InkWell(
                            onTap: () => setState(() => _expanded = !_expanded),
                            borderRadius: AppRadius.brSm,
                            child: Padding(
                              padding: const EdgeInsets.all(AppSpacing.s4),
                              child: Text(
                                _expanded ? '접기' : '모두 보기',
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.accent,
                                ),
                              ),
                            ),
                          )
                        : null,
                  ),
                ),
                for (final r in visible)
                  AppListItem(
                    leading: CachedCircleAvatar(
                      url: r.user.profileImageUrl,
                      radius: AppAvatarSize.md,
                      seed: r.user.id.toInt(),
                    ),
                    title: NameWithTag(name: r.user.name, tag: r.user.tag),
                    subtitle: r.hasRequestedAt()
                        ? Text(
                            '${r.requestedAt.toDateTime(toLocal: true).relativeLabel()} 요청',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          )
                        : null,
                    trailing: Row(
                      spacing: AppSpacing.s8,
                      children: [
                        ElevatedButton(
                          onPressed: _pending.contains(r.relationshipId)
                              ? null
                              : () => _accept(r),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(60, 36),
                            padding: EdgeInsets.zero,
                            textStyle: AppTypography.caption,
                          ),
                          child: const Text('수락'),
                        ),
                        Tooltip(
                          message: '더보기',
                          child: SizedBox.square(
                            dimension: 44,
                            child: Material(
                              color: AppColors.surfaceSecondary,
                              shape: const CircleBorder(),
                              clipBehavior: Clip.antiAlias,
                              child: InkWell(
                                onTap: () => _showMenu(r),
                                child: const Center(
                                  child: AppIcon(AppIconType.more, size: 20),
                                ),
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
      ),
    );
  }

  void _showMenu(Relationship r) {
    showAppBottomSheet(
      context: context,
      child: ListTile(
        leading: const AppIcon(AppIconType.close, color: AppColors.danger),
        title: Text(
          '요청 거절',
          style: AppTypography.subhead.copyWith(color: AppColors.danger),
        ),
        onTap: () {
          Navigator.of(context).pop();
          _reject(r);
        },
      ),
    );
  }

  Future<void> _accept(Relationship r) async {
    setState(() => _pending.add(r.relationshipId));

    await ref
        .read(relationshipViewModelProvider.notifier)
        .updateIncomingRelationshipStatus(relationship: r, isAccept: true);
    ref.invalidate(friendViewModelProvider);

    if (mounted) setState(() => _pending.remove(r.relationshipId));
  }

  Future<void> _reject(Relationship r) async {
    setState(() => _pending.add(r.relationshipId));

    await ref
        .read(relationshipViewModelProvider.notifier)
        .updateIncomingRelationshipStatus(relationship: r, isAccept: false);

    if (mounted) setState(() => _pending.remove(r.relationshipId));
  }
}
