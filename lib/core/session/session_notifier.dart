import 'dart:async';

import 'package:danmalgi_mobile/core/providers/social_auth_provider.dart';
import 'package:danmalgi_mobile/core/providers/storage_provider.dart';
import 'package:danmalgi_mobile/core/session/session.dart';
import 'package:danmalgi_mobile/features/user/data/providers/user_provider.dart';
import 'package:danmalgi_mobile/features/user/domain/user.dart';
import 'package:danmalgi_mobile/features/user/domain/user_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session_notifier.g.dart';

@Riverpod(keepAlive: true)
class SessionNotifier extends _$SessionNotifier {
  @override
  Future<Session> build() async {
    final token = await ref.watch(secureStorageProvider).getAccessToken();
    if (token == null) return const Session.anonymous();

    final cached = ref.read(localStorageServiceProvider).cachedUserOrNull;
    if (cached != null && cached.status == UserStatus.ACTIVE) {
      unawaited(_refreshInBackground(token));
      return Session.registered(token: token, user: cached);
    }

    final user = await ref.read(userRepositoryProvider).getUserByToken();
    await ref.read(localStorageServiceProvider).setUser(user);
    return Session.registered(token: token, user: user);
  }

  Future<void> commit(Session next) async {
    state = AsyncData(next);

    try {
      switch (next) {
        case Registered(:final token, :final user):
          await ref.read(secureStorageProvider).setAccessToken(token);
          await ref.read(localStorageServiceProvider).setUser(user);
        case Pending():
          break;
        case Anonymous():
          await ref.read(secureStorageProvider).deleteAccessToken();
          await ref.read(localStorageServiceProvider).clearUserData();
      }
    } catch (e) {
      print('[Session] 세션 영속화 실패');
    }
  }

  Future<void> updateUser(User user) async {
    final current = state.value;
    if (current is! Registered) return;
    await commit(Session.registered(token: current.token, user: user));
  }

  Future<void> logout() async {
    try {
      await ref.read(googleSignInProvider).signOut();
    } catch (_) {}
    await commit(const Session.anonymous());
  }

  Future<void> _refreshInBackground(String token) async {
    try {
      final remote = await ref.read(userRepositoryProvider).getUserByToken();
      if (!ref.mounted) return;
      final current = state.value;
      if (current is! Registered || current.user == remote) return;
      await commit(Session.registered(token: token, user: remote));
    } catch (_) {}
  }
}
