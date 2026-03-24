import 'dart:async';

import 'package:danmalgi_mobile/features/user/domain/user_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:danmalgi_mobile/core/providers/storage_provider.dart';
import 'package:danmalgi_mobile/features/auth/data/providers/auth_notifier.dart';
import 'package:danmalgi_mobile/features/user/data/providers/user_provider.dart';
import 'package:danmalgi_mobile/features/user/domain/user.dart';
import 'package:danmalgi_mobile/features/user/domain/user_state.dart';

class UserNotifier extends AsyncNotifier<UserState?> {
  @override
  FutureOr<UserState?> build() async {
    final User? user = ref.watch(localStorageServiceProvider).cachedUserOrNull;

    if (user != null) return UserState(user: user);
    print('[UserNotifier] needsRecover');

    final auth = await ref.watch(authNotifierProvider.future);
    if (auth == null) return null;

    print('[UserNotifier] calling getUserByToken...');
    final remoteUser = await ref.read(userRepositoryProvider).getUserByToken();
    print(remoteUser);

    return UserState(user: remoteUser);
  }

  Future<void> register({required String nickname, required String tag}) async {
    state = const AsyncLoading();

    try {
      final user = await ref
          .read(userRepositoryProvider)
          .register(nickname: nickname, tag: tag);
      state = AsyncData(UserState(user: user));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  // Future<void> refresh() async {
  //   state = const AsyncLoading();

  //   state = await AsyncValue.guard(() async {
  //     final user = await ref.read(userRepositoryProvider).getUserByToken();
  //
  //     return UserState(user: user);
  //   });
  // }
}

final userNotifierProvider = AsyncNotifierProvider<UserNotifier, UserState?>(
  UserNotifier.new,
);
