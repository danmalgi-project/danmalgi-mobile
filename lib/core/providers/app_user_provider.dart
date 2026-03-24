import 'package:danmalgi_mobile/core/domain/app_auth_state.dart';
import 'package:danmalgi_mobile/core/providers/app_auth_status_provider.dart';
import 'package:danmalgi_mobile/features/user/domain/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentUserProvider = Provider<User?>(
  (ref) => ref
      .watch(appAuthStatusProvider)
      .maybeWhen(authenticated: (user) => user, orElse: () => null),
);

final requireCurrentUserProvider = Provider<User>((ref) {
  final user = ref.watch(currentUserProvider);

  if (user == null) {
    // 배포 전 개발단에서 처리해야할 문제
    throw StateError(
      '비정상적인 접근: 로그인이 보장된 구역에서만 requireCurrentUserProvider를 사용해야 합니다.',
    );
  }

  return user;
});
