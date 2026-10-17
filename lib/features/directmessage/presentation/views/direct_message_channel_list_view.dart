import 'package:danmalgi_mobile/core/error/app_exception.dart';
import 'package:danmalgi_mobile/core/extensions/date_time_extensions.dart';
import 'package:danmalgi_mobile/core/generated/dm/v1/dm.pb.dart';
import 'package:danmalgi_mobile/core/providers/app_message_notifier.dart';
import 'package:danmalgi_mobile/core/providers/app_user_provider.dart';
import 'package:danmalgi_mobile/core/router/route_paths.dart';
import 'package:danmalgi_mobile/core/theme/app_colors.dart';
import 'package:danmalgi_mobile/core/theme/app_dimens.dart';
import 'package:danmalgi_mobile/core/theme/app_typography.dart';
import 'package:danmalgi_mobile/core/widgets/app_action_sheet.dart';
import 'package:danmalgi_mobile/core/widgets/app_dialog.dart';
import 'package:danmalgi_mobile/core/widgets/app_empty_state.dart';
import 'package:danmalgi_mobile/core/widgets/app_icon.dart';
import 'package:danmalgi_mobile/core/widgets/app_list_item.dart';
import 'package:danmalgi_mobile/core/widgets/app_list_skeleton.dart';
import 'package:danmalgi_mobile/core/widgets/app_scaffold.dart';
import 'package:danmalgi_mobile/core/widgets/app_sheet.dart';
import 'package:danmalgi_mobile/core/widgets/cached_circle_avatar.dart';
import 'package:danmalgi_mobile/features/directmessage/domain/direct_message_channel_x.dart';
import 'package:danmalgi_mobile/features/directmessage/presentation/providers/direct_message_channel_list_view_model.dart';
import 'package:danmalgi_mobile/features/directmessage/presentation/widgets/direct_message_channel_avatar.dart';
import 'package:danmalgi_mobile/features/directmessage/presentation/widgets/group_channel_edit_sheet.dart';
import 'package:danmalgi_mobile/features/friend/presentation/providers/friend_view_model.dart';
import 'package:danmalgi_mobile/features/friend/presentation/widgets/name_with_tag.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

enum _ChannelMenu { customize, leave }

class DirectMessageChannelListView extends ConsumerWidget {
  const DirectMessageChannelListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      title: '채팅',
      padded: false,
      actions: [
        IconButton(
          tooltip: '검색',
          icon: const AppIcon(AppIconType.search),
          onPressed: () {},
        ),
        IconButton(
          tooltip: '그룹 채팅 생성',
          icon: const AppIcon(AppIconType.add),
          onPressed: () => _showCreateChannelSheet(context: context),
        ),
      ],
      body: RefreshIndicator(
        onRefresh: () =>
            ref.refresh(directMessageChannelListViewModelProvider.future),
        child: const CustomScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          slivers: [_DirectMessageSection()],
        ),
      ),
    );
  }
}

class _DirectMessageSection extends ConsumerWidget {
  const _DirectMessageSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final directMessages = ref.watch(directMessageChannelListViewModelProvider);

    return directMessages.when(
      data: (items) => items.isEmpty
          ? SliverFillRemaining(
              hasScrollBody: false,
              child: AppEmptyState(
                icon: SizedBox(
                  width: 160,
                  height: 160,
                  child: SvgPicture.asset('assets/Icons/dm-empty.svg'),
                ),
                title: '모든 대화를 시작해보세요',
                message: '친구를 추가하고 첫 대화를 나눠보세요.\n가장 빠르고 선명한 소통이 기다립니다.',
                actions: [
                  ElevatedButton.icon(
                    onPressed: () => context.push(RoutePaths.addFriend),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(313, 50),
                      padding: EdgeInsets.zero,
                      textStyle: AppTypography.body,
                    ),
                    icon: const AppIcon(AppIconType.addFriend),
                    label: const Text("친구 추가하기"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _showCreateChannelSheet(context: context),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(313, 50),
                      padding: EdgeInsets.zero,
                      textStyle: AppTypography.body,
                      backgroundColor: AppColors.surfacePrimary,
                      foregroundColor: AppColors.textPrimary,
                    ),
                    icon: const AppIcon(AppIconType.add),
                    label: const Text("그룹 채팅 만들기"),
                  ),
                ],
              ),
            )
          : SliverMainAxisGroup(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(left: AppSpacing.s16),
                    child: Text(
                      '모든 채팅',
                      style: AppTypography.badge.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
                SliverList.builder(
                  itemCount: items.length,
                  findChildIndexCallback: (key) {
                    final id = (key as ValueKey<int>).value;
                    final index = items.indexWhere((e) => e.channel.dmId == id);
                    return index < 0 ? null : index;
                  },
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final channel = item.channel;

                    return AppListItem(
                      key: ValueKey(item.channel.dmId.toInt()),
                      padding: EdgeInsets.symmetric(
                        vertical: AppSpacing.s12,
                        horizontal: AppSpacing.s16,
                      ),
                      leading: DirectMessageChannelAvatar(
                        channel: channel,
                        myId: currentUser?.id,
                        radius: AppAvatarSize.md,
                      ),
                      title: Text(
                        channel.channelName,
                        style: AppTypography.body.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: (item.hasLastMessage())
                          ? Text(
                              item.lastMessage.content,
                              style: AppTypography.caption.copyWith(
                                color: AppColors.textSecondary,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            )
                          : null,
                      trailing: Row(
                        children: [
                          if (item.hasLastMessage())
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              spacing: AppSpacing.s6,
                              children: [
                                Text(
                                  item.lastMessage.createdAt
                                      .toDateTime(toLocal: true)
                                      .relativeLabel(),
                                  style: AppTypography.caption.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),

                                /// TODO: 안읽은 메세지 기능 추가되면 사용
                                // Container(
                                //   decoration: BoxDecoration(
                                //     shape: BoxShape.circle,
                                //     color: Color(0xFFFFD60A),
                                //   ),
                                //   margin: EdgeInsets.zero,
                                //   padding: const EdgeInsets.symmetric(
                                //     vertical: 2.0,
                                //     horizontal: 6.0,
                                //   ),
                                //   child: Text(
                                //     "1",
                                //     style: TextStyle(
                                //       fontSize: 10,
                                //       color: Color(0xFF1C1C1E),
                                //       fontWeight: FontWeight.w900,
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                        ],
                      ),
                      onTap: () => context.push(RoutePaths.chat(channel.dmId)),
                      onLongPress: () async {
                        final menu = await showAppActionSheet<_ChannelMenu>(
                          context: context,
                          title: channel.channelName,
                          actions: [
                            if (channel.type == DirectMessageType.group)
                              const AppSheetAction(
                                value: _ChannelMenu.customize,
                                label: '그룹 커스터마이징',
                              ),
                            const AppSheetAction(
                              value: _ChannelMenu.leave,
                              label: '대화방 나가기',
                              destructive: true,
                            ),
                          ],
                        );
                        if (!context.mounted) return;

                        switch (menu) {
                          case _ChannelMenu.customize:
                            _customize(context, channel);
                          case _ChannelMenu.leave:
                            _leave(context, ref, channel);
                          case null:
                            return;
                        }
                      },
                    );
                  },
                ),
              ],
            ),
      loading: () => const AppListSkeleton(),
      error: (e, _) => SliverFillRemaining(
        hasScrollBody: false,
        child: AppEmptyState(
          title: '불러오지 못했어요',
          message: '잠시 후 다시 시도해주세요.',
          actions: [
            TextButton(
              onPressed: () =>
                  ref.invalidate(directMessageChannelListViewModelProvider),
              child: const Text('다시 시도'),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _customize(BuildContext context, DirectMessageChannel channel) {
  return showAppSheet(
    context: context,
    title: '그룹 커스터마이징',
    builder: (_) => GroupChannelEditSheet(channel: channel),
  );
}

Future<void> _leave(
  BuildContext context,
  WidgetRef ref,
  DirectMessageChannel channel,
) async {
  final ok = await showAppConfirmDialog(
    context: context,
    title: '채팅방을 나갈까요?',
    message: '나가면 이 대화 내용을 다시 볼 수 없어요.',
    confirmLabel: '나가기',
    destructive: true,
  );
  if (!ok || !context.mounted) return;

  try {
    await ref
        .read(directMessageChannelListViewModelProvider.notifier)
        .leaveDirectMessageChannel(id: channel.dmId);
  } on AppException catch (e) {
    ref.read(appMessageNotifierProvider.notifier).show(e.message);
  }
}

Future<void> _showCreateChannelSheet({required BuildContext context}) async {
  final channel = await showAppSheet<DirectMessageChannel>(
    context: context,
    title: '새로운 그룹 대화',
    builder: (_) => const _CreateChannelSheet(),
  );
  if (channel == null || !context.mounted) return;
  context.push(RoutePaths.chat(channel.dmId));
}

class _CreateChannelSheet extends ConsumerStatefulWidget {
  const _CreateChannelSheet();

  @override
  ConsumerState<_CreateChannelSheet> createState() =>
      _CreateChannelSheetState();
}

class _CreateChannelSheetState extends ConsumerState<_CreateChannelSheet> {
  final Set<Int64> _selectedIds = {};

  bool _isCreating = false;

  void _toggleFriend({required Int64 friendId, required bool isSelected}) {
    setState(() {
      if (isSelected) {
        _selectedIds.add(friendId);
      } else {
        _selectedIds.remove(friendId);
      }
    });
  }

  Future<void> _create() async {
    if (_selectedIds.isEmpty || _isCreating) return;
    setState(() => _isCreating = true);

    final channel = await ref
        .read(directMessageChannelListViewModelProvider.notifier)
        .createDirectMessageChannel(friendIds: _selectedIds.toList());
    if (!mounted) return;

    if (channel == null) {
      setState(() => _isCreating = false);
      return;
    }
    Navigator.of(context).pop(channel);
  }

  @override
  Widget build(BuildContext context) {
    final friends = ref.watch(friendViewModelProvider);

    return friends.when(
      data: (state) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.length,
              itemBuilder: (context, index) {
                final friend = state[index];
                final id = friend.user.id;
                final selected = _selectedIds.contains(id);

                return AppListItem(
                  leading: CachedCircleAvatar(
                    url: friend.user.profileImageUrl,
                    seed: id.toInt(),
                  ),
                  title: NameWithTag(
                    name: friend.user.name,
                    tag: friend.user.tag,
                  ),
                  trailing: Checkbox(
                    value: selected,
                    onChanged: _isCreating
                        ? null
                        : (v) => _toggleFriend(
                            friendId: id,
                            isSelected: v ?? false,
                          ),
                  ),
                  onTap: _isCreating
                      ? null
                      : () =>
                            _toggleFriend(friendId: id, isSelected: !selected),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.s24,
              AppSpacing.s12,
              AppSpacing.s24,
              AppSpacing.s16,
            ),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _selectedIds.isEmpty || _isCreating ? null : _create,
                child: _isCreating
                    ? const SizedBox.square(
                        dimension: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text('대화 시작 (${_selectedIds.length}명)'),
              ),
            ),
          ),
        ],
      ),
      loading: () => const Padding(
        padding: EdgeInsets.all(AppSpacing.s24),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (_, _) => Padding(
        padding: const EdgeInsets.all(AppSpacing.s24),
        child: AppEmptyState(
          title: '친구 목록을 불러오지 못했어요',
          actions: [
            TextButton(
              onPressed: () => ref.invalidate(friendViewModelProvider),
              child: const Text('다시 시도'),
            ),
          ],
        ),
      ),
    );
  }
}
