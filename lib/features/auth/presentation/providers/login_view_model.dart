import 'dart:async';

import 'package:danmalgi_mobile/core/error/app_exception.dart';
import 'package:danmalgi_mobile/core/providers/app_message_notifier.dart';
import 'package:danmalgi_mobile/core/providers/local_user_settings_service_provider.dart';
import 'package:danmalgi_mobile/core/providers/social_auth_provider.dart';
import 'package:danmalgi_mobile/core/session/session_notifier.dart';
import 'package:danmalgi_mobile/features/auth/data/providers/auth_provider.dart';
import 'package:danmalgi_mobile/features/user/domain/oauth_type.dart';
import 'package:flutter/services.dart';
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

          try {
            final GoogleSignInCredentials? credentials = await ref
                .read(googleSignInProvider)
                .signIn();

            if (credentials != null) {
              idToken = credentials.idToken;
              print(
                '[GoogleSignIn] success, idToken length: ${idToken?.length}',
              );
            } else {
              print(
                '[GoogleSignIn] signIn() returned null credentials — user likely cancelled, or lightweightSignIn/signInOnline both failed silently',
              );
            }
          } on PlatformException catch (e, st) {
            print(
              '[GoogleSignIn] PlatformException code=${e.code} message=${e.message} details=${e.details}',
            );
          } catch (e, st) {
            print('[GoogleSignIn] unexpected error: $e\n$st');
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

      final deviceId = await ref.read(deviceIdProvider.future);

      final session = await ref
          .read(authRepositoryProvider)
          .authorization(
            idToken: idToken,
            deviceId: deviceId,
            oAuthType: oAuthType,
          );
      await ref.read(sessionProvider.notifier).commit(session);

      state = const AsyncData(null);
    } on AppException catch (e) {
      ref.read(appMessageNotifierProvider.notifier).show(e.message);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final loginViewModelProvider = AsyncNotifierProvider<LoginViewModel, void>(
  LoginViewModel.new,
);
