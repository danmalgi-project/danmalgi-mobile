import 'dart:async';

import 'package:danmalgi_mobile/core/error/app_exception.dart';
import 'package:danmalgi_mobile/core/providers/social_auth_provider.dart';
import 'package:danmalgi_mobile/core/providers/storage_provider.dart';
import 'package:danmalgi_mobile/core/session/auth_credentials.dart';
import 'package:danmalgi_mobile/core/session/session.dart';
import 'package:danmalgi_mobile/features/user/data/providers/user_provider.dart';
import 'package:danmalgi_mobile/features/user/domain/user.dart';
import 'package:danmalgi_mobile/features/user/domain/user_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session_notifier.g.dart';

@Riverpod(keepAlive: true)
class SessionNotifier extends _$SessionNotifier {
  AuthCredentials get _tokens => ref.read(authCredentialsProvider);

  @override
  Future<Session> build() async {
    final token = await ref.watch(secureStorageProvider).getAccessToken();
    _tokens.token = token;
    if (token == null) return const Session.anonymous();

    final cached = ref.read(localStorageServiceProvider).cachedUserOrNull;
    if (cached != null && cached.status == UserStatus.ACTIVE) {
      unawaited(_refreshInBackground(token));
      return Session.registered(token: token, user: cached);
    }

    try {
      final user = await ref.read(userRepositoryProvider).getUserByToken();
      final session = Session.registered(token: token, user: user);
      await _apply(session);
      return session;
    } on AppException catch (e) {
      final expired = e.maybeWhen(
        unauthenticated: (_) => true,
        orElse: () => false,
      );
      if (!expired) rethrow;
      await _apply(const Session.anonymous());
      return const Session.anonymous();
    }
  }

  Future<void> commit(Session next) async {
    state = AsyncData(next);
    await _apply(next);
  }

  Future<void> _apply(Session next) async {
    _tokens.token = next.token;
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
