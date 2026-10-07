import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:danmalgi_mobile/core/error/app_exception.dart';
import 'package:danmalgi_mobile/core/session/session.dart';
import 'package:danmalgi_mobile/core/session/token_store.dart';
import 'package:danmalgi_mobile/core/session/user_cache.dart';
import 'package:danmalgi_mobile/features/auth/data/providers/social_provider.dart';
import 'package:danmalgi_mobile/features/user/data/providers/user_provider.dart';
import 'package:danmalgi_mobile/features/user/domain/user.dart';
import 'package:danmalgi_mobile/features/user/domain/user_status.dart';

part 'session_notifier.g.dart';

@Riverpod(keepAlive: true)
class SessionNotifier extends _$SessionNotifier {
  TokenStore get _store => ref.read(tokenStoreProvider);
  UserCache get _cache => ref.read(userCacheProvider);

  @override
  Future<Session> build() async {
    final token = await _store.restore();
    if (token == null) return const Session.anonymous();

    final cached = _cache.read();
    if (cached != null && cached.status == UserStatus.ACTIVE) {
      unawaited(_refreshInBackground(token));
      return Session.registered(user: cached);
    }

    try {
      final user = await ref.read(userRepositoryProvider).getUserByToken();
      await _cache.write(user);
      return Session.registered(user: user);
    } on AppException catch (e) {
      final expired = e.maybeWhen(
        unauthenticated: (_) => true,
        orElse: () => false,
      );
      if (!expired) rethrow;
      await _clearLocal();
      return const Session.anonymous();
    }
  }

  Future<void> signIn(AuthResult result) async {
    final pending = result.user.isPending;
    await _store.save(result.accessToken, persist: !pending);
    if (pending) {
      state = const AsyncData(Session.pending());
      return;
    }
    await _cache.write(result.user);
    state = AsyncData(Session.registered(user: result.user));
  }

  Future<void> updateUser(User user) async {
    if (state.value is! Registered) return;
    await _cache.write(user);
    state = AsyncData(Session.registered(user: user));
  }

  Future<void> logout() async {
    await _clearLocal();
    state = const AsyncData(Session.anonymous());
    for (final authenticator in ref.read(socialAuthenticatorProvider).values) {
      try {
        authenticator.signOut();
      } catch (_) {}
    }
  }

  Future<void> _clearLocal() async {
    await _store.clear();
    await _cache.clear();
  }

  Future<void> _refreshInBackground(String token) async {
    try {
      final remote = await ref.read(userRepositoryProvider).getUserByToken();
      if (!ref.mounted) return;
      final current = state.value;
      if (current is! Registered || current.user == remote) return;
      await updateUser(remote);
    } catch (_) {}
  }
}
