import 'dart:async';

import 'package:danmalgi_mobile/core/error/app_exception.dart';
import 'package:danmalgi_mobile/core/providers/app_message_notifier.dart';
import 'package:danmalgi_mobile/core/providers/social_auth_provider.dart';
import 'package:danmalgi_mobile/core/providers/storage_provider.dart';
import 'package:danmalgi_mobile/features/auth/data/providers/auth_notifier.dart';
import 'package:danmalgi_mobile/features/auth/data/providers/auth_provider.dart';
import 'package:danmalgi_mobile/features/user/domain/oauth_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in_all_platforms/google_sign_in_all_platforms.dart';

class LoginViewModel extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() => null;

  Future<void> login({required OAuthType oAuthType}) async {
    state = const AsyncLoading(); // 👈 이 로딩은 버튼 스피너만 돌립니다!

    try {
      // 1. 소셜 로그인 및 서버 인증 로직 수행
      // (기존 auth_notifier.dart에 있던 switch문 로직을 이리로 옮깁니다)
      String? idToken;

      switch (oAuthType) {
        case OAuthType.GOOGLE:
          // double check
          await ref.read(googleSignInProvider).signOut();
          // TODO: 로그아웃 순서를 제대로 파악해야함. 인터넷이 없거나 로그아웃을 실패했을 경우 기존 계정을 남길지 아니면 아예 로그아웃시켜서 정상화 후에 다시 로그인 시킬지 선택 (전자는 구현하기 어렵고 후자를 선택할 가능성이 높음)
          await _clearSession();

          final GoogleSignInCredentials? credentials = await ref
              .read(googleSignInProvider)
              .signIn();

          if (credentials != null) {
            idToken = credentials.idToken;
          }

          print(idToken);
          break;
        case OAuthType.KAKAO:
          // TODO: Handle this case.
          break;
        case OAuthType.NAVER:
          // TODO: Handle this case.
          break;
        case OAuthType.ERROR:
          break;
      }

      if (idToken == null) {
        throw AppException.unauthenticated(message: "소셜 로그인 인증 에러");
      }

      final authState = await ref
          .read(authRepositoryProvider)
          .authorization(idToken: idToken, oAuthType: oAuthType);

      // 2. 성공 시, 전역 상태(AuthNotifier)를 업데이트합니다.
      // 이 순간 GoRouter가 감지하고 홈 화면으로 이동시킵니다.
      ref.read(authNotifierProvider.notifier).updateState(authState);

      state = const AsyncData(null);
    } on AppException catch (e) {
      ref.read(appMessageNotifierProvider.notifier).show(e.message);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  // 로그인 기능에 사용될 예정 (더블 체크 용도)
  Future<void> _clearSession() async {
    try {
      await ref.read(googleSignInProvider).signOut();
    } catch (_) {}

    await ref.read(secureStorageProvider).deleteAccessToken();
    await ref.read(localStorageServiceProvider).clearLocalData();
  }
}

final loginViewModelProvider = AsyncNotifierProvider<LoginViewModel, void>(
  LoginViewModel.new,
);
