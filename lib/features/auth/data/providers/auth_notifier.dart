import 'dart:async';

import 'package:danmalgi_mobile/core/error/app_exception.dart';
import 'package:danmalgi_mobile/core/providers/app_message_notifier.dart';
import 'package:danmalgi_mobile/features/user/data/providers/user_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in_all_platforms/google_sign_in_all_platforms.dart';

import 'package:danmalgi_mobile/core/providers/social_auth_provider.dart';
import 'package:danmalgi_mobile/core/providers/storage_provider.dart';
import 'package:danmalgi_mobile/features/auth/data/providers/auth_provider.dart';
import 'package:danmalgi_mobile/features/auth/domain/auth_state.dart';
import 'package:danmalgi_mobile/features/user/domain/oauth_type.dart';

class AuthNotifier extends AsyncNotifier<AuthState?> {
  @override
  FutureOr<AuthState?> build() async {
    final String? token = await ref
        .watch(secureStorageProvider)
        .getAccessToken();
    if (token == null) return null;
    return AuthState(accessToken: token);
  }

  void updateState(AuthState? authState) async {
    state = AsyncData(authState);
  }

  Future<void> logout() async {
    // TODO : 다른 OAuth를 사용할 경우 해당 방식으론 사용할 수 없음 Social Auth Service를 개발해야 할 듯
    // 유저 정보나 유저 정보 말고 로컬 OAuth 데이터를 만들어서 해당 소셜 로그아웃 방식을 선택하도록 구현해야할 듯
    try {
      await ref.read(googleSignInProvider).signOut();
    } catch (_) {}

    await ref.read(secureStorageProvider).deleteAccessToken();
    await ref.read(localStorageServiceProvider).clearLocalData();

    // TODO: 해당 코드 제거 필요, invalidateSelf를 진행하면 알아서 리셋될 예정, 코드를 그대로 냅두면 AppAuthStatus에서 참조하기 때문에 순환참조 문제가 발생함
    // ref.invalidate(userNotifierProvider);
    ref.invalidateSelf();
  }
}

final authNotifierProvider = AsyncNotifierProvider<AuthNotifier, AuthState?>(
  AuthNotifier.new,
);
