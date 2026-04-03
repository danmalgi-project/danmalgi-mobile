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
    final auth = await ref.watch(authNotifierProvider.future);
    print('[UserNotifier] auth: $auth');

    if (auth == null) {
      print('[UserNotifier] auth null → null 반환');
      return null;
    }

    final User? cachedUser = ref
        .watch(localStorageServiceProvider)
        .cachedUserOrNull;

    if (cachedUser != null) {
      Future.microtask(() => _syncWithServer());
      return UserState(user: cachedUser);
    }
    print('[UserNotifier] needsRecover');

    print('[UserNotifier] calling getUserByToken...');
    try {
      final remoteUser = await ref
          .read(userRepositoryProvider)
          .getUserByToken();
      return UserState(user: remoteUser);
    } catch (e) {
      print('[UserNotifier] getUserByToken 실패: $e');
      await ref.read(authNotifierProvider.notifier).logout();
      return null;
    }
  }

  Future<void> _syncWithServer() async {
    try {
      final remoteUser = await ref
          .read(userRepositoryProvider)
          .getUserByToken();

      // TODO: User를 nullable로 받지 않고 아마 에러 핸들링으로 추후 작업해서 catch 부분에서 logout 처리해야할 듯
      // if (remoteUser == null) {
      //   await ref.read(authNotifierProvider.notifier).logout();
      //   return;
      // }

      final cachedUser = ref.read(localStorageServiceProvider).cachedUserOrNull;

      // 서버와 다르면 캐시 업데이트
      if (cachedUser != remoteUser) {
        await ref.read(localStorageServiceProvider).setUser(remoteUser);
        // state 갱신
        state = AsyncData(UserState(user: remoteUser));
      }
    } catch (e) {
      print('[UserNotifier] 백그라운드 동기화 실패: $e');
      // 백그라운드 실패는 무시 (캐시 데이터 유지)
    }
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
