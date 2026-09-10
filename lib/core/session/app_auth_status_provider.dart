import 'package:danmalgi_mobile/core/session/app_auth_state.dart';
import 'package:danmalgi_mobile/core/error/app_exception.dart';
import 'package:danmalgi_mobile/core/session/session.dart';
import 'package:danmalgi_mobile/core/session/session_notifier.dart';
import 'package:danmalgi_mobile/features/user/domain/user_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appAuthStatusProvider = Provider<AppAuthState>((ref) {
  final async = ref.watch(sessionProvider);

  final session = async.value;
  if (session != null) {
    return switch (session) {
      Anonymous() => const AppAuthState.unauthenticated(),
      Pending() => const AppAuthState.needsRegistration(),
      Registered(:final user) => switch (user.status) {
        UserStatus.ACTIVE => AppAuthState.authenticated(user: user),
        UserStatus.PENDING => const AppAuthState.needsRegistration(),
        UserStatus.BLOCKED => const AppAuthState.blocked(),
        UserStatus.WITHDRAWAL => const AppAuthState.withdrawn(),
        null => const AppAuthState.unauthenticated(),
      },
    };
  }

  final error = async.error;
  if (error != null) {
    if (error is AppException) {
      return error.when(
        unauthenticated: (_) => const AppAuthState.unauthenticated(),
        notFound: (_) => AppAuthState.error(error: error, canRetry: false),
        network: (_) => AppAuthState.error(error: error, canRetry: true),
        timeout: (_) => AppAuthState.error(error: error, canRetry: true),
        unknown: (_) => AppAuthState.error(error: error, canRetry: false),
      );
    }
    return AppAuthState.error(error: error, canRetry: true);
  }

  return const AppAuthState.loading();
});
