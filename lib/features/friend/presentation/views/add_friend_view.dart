import 'package:danmalgi_mobile/core/error/app_exception.dart';
import 'package:danmalgi_mobile/core/generated/relationship/v1/relationship.pbgrpc.dart';
import 'package:danmalgi_mobile/core/theme/app_colors.dart';
import 'package:danmalgi_mobile/core/theme/app_dimens.dart';
import 'package:danmalgi_mobile/core/theme/app_typography.dart';
import 'package:danmalgi_mobile/core/widgets/app_empty_state.dart';
import 'package:danmalgi_mobile/core/widgets/app_icon.dart';
import 'package:danmalgi_mobile/core/widgets/app_list_item.dart';
import 'package:danmalgi_mobile/core/widgets/app_scaffold.dart';
import 'package:danmalgi_mobile/core/widgets/cached_circle_avatar.dart';
import 'package:danmalgi_mobile/features/friend/domain/friend_relation.dart';
import 'package:danmalgi_mobile/features/friend/presentation/providers/add_friend_view_model.dart';
import 'package:danmalgi_mobile/features/friend/presentation/providers/friend_relation_provider.dart';
import 'package:danmalgi_mobile/features/friend/presentation/providers/friend_view_model.dart';
import 'package:danmalgi_mobile/features/friend/presentation/providers/relationship_view_model.dart';
import 'package:danmalgi_mobile/features/friend/presentation/widgets/friend_section_header.dart';
import 'package:danmalgi_mobile/features/friend/presentation/widgets/name_with_tag.dart';
import 'package:danmalgi_mobile/features/user/domain/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddFriendView extends ConsumerWidget {
  const AddFriendView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      title: '친구 추가',
      padded: true,
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: AppSpacing.s12),
              child: TextField(
                autocorrect: false,
                enableSuggestions: false,
                decoration: InputDecoration(
                  hintText: '닉네임#태그 입력',
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(
                      left: AppSpacing.s16,
                      right: AppSpacing.s16,
                    ),
                    child: AppIcon(AppIconType.search, size: 24),
                  ),
                  fillColor: AppColors.surfaceSecondary,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.s24,
                    vertical: AppSpacing.s12,
                  ),
                ),
                textInputAction: TextInputAction.search,
                onSubmitted: (value) =>
                    ref.read(addFriendViewModelProvider.notifier).search(value),
              ),
            ),
          ),
          const _SearchResultSection(),
        ],
      ),
    );
  }
}

class _SearchResultSection extends ConsumerWidget {
  const _SearchResultSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final results = ref.watch(addFriendViewModelProvider);

    return SliverPadding(
      padding: EdgeInsets.only(top: AppSpacing.s28),
      sliver: results.when(
        data: (users) {
          if (users == null) {
            return const SliverFillRemaining(
              hasScrollBody: false,
              child: AppEmptyState(
                title: '친구를 찾아보세요',
                message: '닉네임과 태그를 함께 입력해주세요.\n예: 단말기#1111',
              ),
            );
          }

          return SliverMainAxisGroup(
            slivers: [
              SliverToBoxAdapter(
                child: FriendSectionHeader(title: '검색 결과', count: users.length),
              ),
              if (users.isEmpty)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: AppEmptyState(
                    title: '검색 결과가 없어요',
                    message: '닉네임과 태그를 다시 확인해주세요.',
                  ),
                )
              else
                SliverList.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return AppListItem(
                      leading: CachedCircleAvatar(
                        url: user.imageUrl,
                        radius: AppAvatarSize.md,
                        seed: user.id,
                      ),
                      title: NameWithTag.stacked(
                        name: user.name,
                        tag: user.tag,
                      ),
                      trailing: _RelationButton(user: user),
                    );
                  },
                ),
            ],
          );
        },
        error: (e, _) => SliverFillRemaining(
          hasScrollBody: false,
          child: AppEmptyState(title: '검색하지 못했어요', message: _errorMessage(e)),
        ),
        loading: () => const SliverFillRemaining(
          hasScrollBody: false,
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

String _errorMessage(Object e) {
  return switch (e) {
    FormatException(:final message) => message,
    AppException(:final message) => message,
    _ => '잠시 후 다시 시도해주세요.',
  };
}

class _RelationButton extends ConsumerStatefulWidget {
  final UserProfile user;
  const _RelationButton({required this.user});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RelationButtonState();
}

class _RelationButtonState extends ConsumerState<_RelationButton> {
  bool _sending = false;

  Future<void> _add() async {
    setState(() => _sending = true);

    await ref
        .read(relationshipViewModelProvider.notifier)
        .addRelationship(name: widget.user.name, tag: widget.user.tag);
    ref.invalidate(relationshipViewModelProvider);

    if (mounted) setState(() => _sending = false);
  }

  Future<void> _accept(Relationship r) async {
    setState(() => _sending = true);

    await ref
        .read(relationshipViewModelProvider.notifier)
        .updateIncomingRelationshipStatus(relationship: r, isAccept: true);
    ref.invalidate(friendViewModelProvider);

    if (mounted) setState(() => _sending = false);
  }

  Widget _button(
    String text, {
    Color disabledBackgroundColor = AppColors.surfaceInput,
    Color disabledForegroundColor = AppColors.textSecondary,
    VoidCallback? onPressed,
  }) => ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(104, 36),
      padding: EdgeInsets.zero,
      textStyle: AppTypography.caption,
      disabledBackgroundColor: disabledBackgroundColor,
      disabledForegroundColor: disabledForegroundColor,
    ),
    child: Text(text),
  );

  @override
  Widget build(BuildContext context) {
    final relation = ref.watch(friendRelationProvider(widget.user.id));

    return SizedBox(
      width: 104,
      child: switch (relation) {
        FriendRelationNone() when !_sending => _button('추가', onPressed: _add),
        FriendRelationNone() || FriendRelationOutgoing() => _button(
          '요청됨',
          disabledBackgroundColor: AppColors.surfaceSecondary,
          disabledForegroundColor: AppColors.textPrimary,
        ),
        FriendRelationIncoming(:final relationship) => _button(
          '수락',
          onPressed: _sending ? null : () => _accept(relationship),
        ),
        FriendRelationFriend() => _button('친구'),
        FriendRelationMe() => const SizedBox.shrink(),
      },
    );
  }
}
