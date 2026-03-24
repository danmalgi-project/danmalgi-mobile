import 'package:danmalgi_mobile/core/domain/app_auth_state.dart';
import 'package:danmalgi_mobile/core/error/app_exception.dart';
import 'package:danmalgi_mobile/features/user/domain/user.dart';
import 'package:danmalgi_mobile/features/user/domain/user_state.dart';
import 'package:danmalgi_mobile/features/user/domain/user_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:danmalgi_mobile/features/auth/data/providers/auth_notifier.dart';
import 'package:danmalgi_mobile/features/user/data/providers/user_notifier.dart';

final appAuthStatusProvider = Provider<AppAuthState>((ref) {
  final authAsync = ref.watch(authNotifierProvider);
  final userAsync = ref.watch(userNotifierProvider);

  if (authAsync.isLoading) return const AppAuthState.loading();
  if (authAsync.hasError) {
    final error = authAsync.error;
    if (error is AppException) {
      return error.when(
        unauthenticated: (_) => const AppAuthState.unauthenticated(),
        network: (_) => AppAuthState.error(error: error, canRetry: true),
        timeout: (_) => AppAuthState.error(error: error, canRetry: true),
        unknown: (_) => AppAuthState.error(error: error, canRetry: false),
      );
    }
    return AppAuthState.error(error: authAsync.error!, canRetry: true);
  }

  print('auth = ${authAsync.value}');
  final auth = authAsync.value;
  if (auth == null) {
    return const AppAuthState.unauthenticated();
  }

  if (userAsync.isLoading) {
    return const AppAuthState.bootstrapping();
  }
  if (userAsync.hasError) {
    final error = userAsync.error;
    if (error is AppException) {
      return error.when(
        unauthenticated: (_) => const AppAuthState.unauthenticated(),
        network: (_) => AppAuthState.error(error: error, canRetry: true),
        timeout: (_) => AppAuthState.error(error: error, canRetry: true),
        unknown: (_) => AppAuthState.error(error: error, canRetry: false),
      );
    }
    return AppAuthState.error(error: userAsync.error!, canRetry: true);
  }

  final userState = userAsync.value;
  print('userAsync = $userAsync');
  print('userState = ${userAsync.value}');
  print('userStatus = ${userAsync.value?.user.status}');
  if (userState == null) {
    return const AppAuthState.bootstrapping();
  }

  final user = userState.user;
  switch (user.status) {
    case UserStatus.USER_PENDING:
      return AppAuthState.needsRegistration();
    case UserStatus.USER_ACTIVCE:
      return AppAuthState.authenticated(user: user);
    case UserStatus.USER_BLOCKED:
      return AppAuthState.blocked();
    case UserStatus.USER_WITHDRAWAL:
      return AppAuthState.withdrawn();
    default:
      return AppAuthState.error(
        error: StateError('Unknown user status: ${user.status}'),
        canRetry: false,
      );
  }
});
