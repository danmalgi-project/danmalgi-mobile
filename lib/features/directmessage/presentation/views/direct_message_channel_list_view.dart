import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:danmalgi_mobile/core/widgets/async_value_handler.dart';
import 'package:danmalgi_mobile/core/widgets/rounded_text_field.dart';
import 'package:danmalgi_mobile/features/friend/presentation/providers/friend_view_model.dart';
import 'package:danmalgi_mobile/features/friend/presentation/widgets/friend_list_tile.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:danmalgi_mobile/features/directmessage/domain/direct_message_channel_list_state.dart';
import 'package:danmalgi_mobile/features/directmessage/presentation/providers/direct_message_channel_list_view_model.dart';
import 'package:danmalgi_mobile/features/directmessage/presentation/widgets/direct_message_channel_list_tile.dart';

mixin class DirectMessageChannelListViewProviderState {
  AsyncValue<DirectMessageChannelListState> directMessageChannelListViewModel(
    WidgetRef ref,
  ) => ref.watch(directMessageChannelListViewModelProvider);
}

class DirectMessageChannelListView extends ConsumerStatefulWidget {
  const DirectMessageChannelListView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DirectMessageChannelListViewState();
}

class _DirectMessageChannelListViewState
    extends ConsumerState<DirectMessageChannelListView>
    with DirectMessageChannelListViewProviderState {
  List<Widget> data = [];

  @override
  Widget build(BuildContext context) {
    return AsyncValueHandler(
      asyncValue: directMessageChannelListViewModel(ref),
      onRetry: () => ref.invalidate(directMessageChannelListViewModelProvider),
      builder: (state) {
        return RefreshIndicator(
          onRefresh: () async {
            try {
              // ignore: unused_result
              ref.refresh(directMessageChannelListViewModelProvider.future);
            } catch (_) {}
          },
          child: CustomScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverAppBar(
                stretch: true,
                title: Text('DMs', style: TextStyle(fontSize: 26.0)),
                titleSpacing: 18.0,
                floating: true,
                centerTitle: false,
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                actions: [
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          // BottomSheet 전체 상태를 여기서 관리
                          final selectedIds = <int>{};
                          final friendState = ref.watch(
                            friendViewModelProvider,
                          );
                          return StatefulBuilder(
                            builder: (context, setState) {
                              return friendState.maybeWhen(
                                data: (data) {
                                  return Column(
                                    children: [
                                      Expanded(
                                        child: ListView.builder(
                                          itemCount: data.friendList.length,
                                          itemBuilder: (context, index) {
                                            final friend =
                                                data.friendList[index];
                                            final id = friend.user.id.toInt();
                                            final isChecked = selectedIds
                                                .contains(id); // ← Set으로 관리

                                            return CheckboxListTile(
                                              title: Text(friend.user.name),
                                              value: isChecked,
                                              onChanged: (value) {
                                                if (value == null) return;
                                                setState(() {
                                                  // ← StatefulBuilder의 setState
                                                  value
                                                      ? selectedIds.add(id)
                                                      : selectedIds.remove(id);
                                                });
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      // 채팅방 만들기 버튼
                                      Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: ElevatedButton(
                                          onPressed: selectedIds.isEmpty
                                              ? null
                                              : () {
                                                  Navigator.pop(context);
                                                  ref
                                                      .read(
                                                        directMessageChannelListViewModelProvider
                                                            .notifier,
                                                      )
                                                      .createDirectMessageChannel(
                                                        friendIds: selectedIds
                                                            .map(
                                                              (id) => Int64(id),
                                                            )
                                                            .toList(),
                                                      );
                                                },
                                          child: Text(
                                            '채팅방 만들기 (${selectedIds.length}명)',
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                orElse: () => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.add),
                  ),
                ],
                expandedHeight: 180.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align to the left
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: RoundedTextField(
                          hintText: '검색하세요',
                          contentPadding: EdgeInsets.only(
                            left: 24,
                            top: 10,
                            right: 24,
                            bottom: 10,
                          ),
                          borderColor: Color(0xFFE5E5E5),
                          borderRadius: BorderRadius.circular(62),
                        ),
                      ),
                      SizedBox(height: 18.0),
                      SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18.0),
                          child: Row(
                            children: [
                              ...state.directMessageChannelList.mapIndexed((
                                idx,
                                dm,
                              ) {
                                return Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 28.0,
                                      foregroundImage: NetworkImage(
                                        'https://picsum.photos/${200 + idx}',
                                      ),
                                    ),
                                    SizedBox(width: 12.0),
                                  ],
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    ],
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
