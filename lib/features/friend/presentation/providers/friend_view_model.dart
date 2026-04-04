import 'dart:async';

import 'package:danmalgi_mobile/core/providers/app_user_provider.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:danmalgi_mobile/core/generated/friend/v1/friend.pb.dart';
import 'package:danmalgi_mobile/core/generated/user/v1/user.pb.dart';
import 'package:danmalgi_mobile/features/friend/data/providers/friend_providers.dart';
import 'package:danmalgi_mobile/features/friend/domain/friend_state.dart';

final friendViewModelProvider =
    AsyncNotifierProvider.autoDispose<FriendViewModel, FriendState>(
      FriendViewModel.new,
    );

class FriendViewModel extends AsyncNotifier<FriendState> {
  @override
  FutureOr<FriendState> build() async {
    ref.watch(currentUserProvider); // Bind lifecycle to auth state

    final List<Friend> initialData = await ref
        .read(friendRepositoryProvider)
        .getFriendList();

    final testData = List.generate(
      20,
      (i) => Friend(
        id: Int64(1000 + i),
        user: User(
          id: Int64(-1),
          email: '',
          name: '[TEST$i]',
          tag: '${7776 + i}',
        ),
        status: FriendStatus.ACCEPT,
      ),
    );

    return FriendState(friendList: [...initialData, ...testData]);
  }

  Future<void> add() async {
    final List<Friend> response = await ref
        .read(friendRepositoryProvider)
        .getFriendList();

    response.addAll([
      Friend(
        id: Int64(1001),
        user: User(id: Int64(-1), email: '', name: 'test1', tag: 'test'),
        status: FriendStatus.ACCEPT,
      ),
    ]);

    state = await AsyncValue.guard(() async {
      final currentState = state.value;
      if (currentState != null) {
        return currentState.copyWith(friendList: response);
      }
      return currentState!;
    });
    // final currentState = state.value;
    // if (currentState != null) {
    //   state = AsyncData(currentState.copyWith(friendList: response));
    // }
  }
}
