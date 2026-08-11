import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:danmalgi_mobile/core/widgets/async_value_handler.dart';
import 'package:danmalgi_mobile/core/widgets/cached_circle_avatar.dart';
import 'package:danmalgi_mobile/core/widgets/rounded_text_field.dart';
import 'package:danmalgi_mobile/features/friend/presentation/providers/friend_view_model.dart';
import 'package:danmalgi_mobile/features/friend/presentation/widgets/friend_list_tile.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:danmalgi_mobile/features/directmessage/domain/direct_message_channel_list_state.dart';
import 'package:danmalgi_mobile/features/directmessage/presentation/providers/direct_message_channel_list_view_model.dart';
import 'package:danmalgi_mobile/features/directmessage/presentation/widgets/direct_message_channel_list_tile.dart';
import 'package:flutter_svg/svg.dart';

class DirectMessageChannelListView extends ConsumerStatefulWidget {
  const DirectMessageChannelListView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DirectMessageChannelListViewState();
}

class _DirectMessageChannelListViewState
    extends ConsumerState<DirectMessageChannelListView> {
  List<Widget> data = [];

  @override
  Widget build(BuildContext context) {
    final channelListAsync = ref.watch(
      directMessageChannelListViewModelProvider,
    );

    return AsyncValueHandler(
      asyncValue: channelListAsync,
      onRetry: () => ref.invalidate(directMessageChannelListViewModelProvider),
      builder: (state) {
        return RefreshIndicator(
          onRefresh: () async {
            try {
              await ref.refresh(
                directMessageChannelListViewModelProvider.future,
              );
              print("test");
            } catch (_) {}
          },
          child: CustomScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverAppBar(
                stretch: true,
                title: Text(
                  'DM',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800),
                ),
                actionsPadding: EdgeInsets.only(right: 24.0),
                titleSpacing: 24.0,
                floating: true,
                snap: true,
                centerTitle: false,
                actions: [
                  SizedBox(
                    width: 36.0,
                    height: 36.0,
                    child: Material(
                      color: Color(0xFF1C1C1E),
                      shape: CircleBorder(),
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () => showCreateDirectMessageChannelSheet(
                          context: context,
                        ),
                        child: const Center(
                          child: Icon(Icons.add_rounded, size: 26.0),
                        ),
                      ),
                    ),
                  ),
                ],
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(64),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
                    child: RoundedTextField(
                      hintText: '대화 검색',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: SvgPicture.asset(
                          "assets/Icons/Icon-search.svg",
                          width: 18,
                          height: 18,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 10,
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
              ),

              if (state.isEmpty)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: Text('DM이 존재하지 않습니다.')),
                )
              else
                SliverList.builder(
                  itemCount: state.length,
                  itemBuilder: (context, index) {
                    final channel = state.directMessageChannelList[index];
                    return DirectMessageChannelListTile(channel: channel);
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}

Future<void> showCreateDirectMessageChannelSheet({
  required BuildContext context,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => const CreateDirectMessageChannelSheet(),
  );
}

class CreateDirectMessageChannelSheet extends ConsumerStatefulWidget {
  const CreateDirectMessageChannelSheet({super.key});

  @override
  ConsumerState<CreateDirectMessageChannelSheet> createState() =>
      _CreateDirectMessageChannelSheetState();
}

class _CreateDirectMessageChannelSheetState
    extends ConsumerState<CreateDirectMessageChannelSheet> {
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

  Future<void> _createDirectMessageChannel() async {
    if (_selectedIds.isEmpty || _isCreating) {
      return;
    }

    setState(() {
      _isCreating = true;
    });

    try {
      await ref
          .read(directMessageChannelListViewModelProvider.notifier)
          .createDirectMessageChannel(friendIds: _selectedIds.toList());

      if (!mounted) return;

      Navigator.of(context).pop();
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('채팅방을 만들지 못했습니다.')));

      setState(() {
        _isCreating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final friendState = ref.watch(friendViewModelProvider);

    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.8,
      child: friendState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('친구 목록을 불러오지 못했습니다.'),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () {
                  ref.invalidate(friendViewModelProvider);
                },
                child: const Text('다시 시도'),
              ),
            ],
          ),
        ),
        data: (data) {
          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 16, 20, 12),
                child: Row(
                  children: [
                    Text(
                      '새로운 대화',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: ListView.builder(
                  itemCount: data.friendList.length,
                  itemBuilder: (context, index) {
                    final friend = data.friendList[index];
                    final friendId = friend.user.id;
                    final isSelected = _selectedIds.contains(friendId);

                    return CheckboxListTile(
                      title: Text(friend.user.name),
                      value: isSelected,
                      onChanged: _isCreating
                          ? null
                          : (value) {
                              if (value == null) return;

                              _toggleFriend(
                                friendId: friendId,
                                isSelected: value,
                              );
                            },
                    );
                  },
                ),
              ),
              SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _selectedIds.isEmpty || _isCreating
                          ? null
                          : _createDirectMessageChannel,
                      child: _isCreating
                          ? const SizedBox.square(
                              dimension: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text('채팅방 만들기 (${_selectedIds.length}명)'),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
