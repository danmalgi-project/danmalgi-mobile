import 'dart:async';

import 'package:danmalgi_mobile/core/generated/friend/v1/friend.pb.dart';
import 'package:danmalgi_mobile/core/providers/app_user_provider.dart';
import 'package:danmalgi_mobile/features/friend/data/providers/friend_providers.dart';
import 'package:danmalgi_mobile/features/friend/domain/friend_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'friend_view_model.g.dart';

@riverpod
class FriendViewModel extends _$FriendViewModel {
  @override
  FutureOr<FriendState> build() async {
    ref.watch(currentUserProvider); // Bind lifecycle to auth state

    final List<Friend> initialData = await ref
        .read(friendRepositoryProvider)
        .getFriendList();

    return FriendState(friendList: initialData);
  }

  Future<void> add() async {
    final List<Friend> response = await ref
        .read(friendRepositoryProvider)
        .getFriendList();

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
