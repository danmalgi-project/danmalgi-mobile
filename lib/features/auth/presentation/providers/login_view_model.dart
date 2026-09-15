import 'dart:async';

import 'package:danmalgi_mobile/core/error/app_exception.dart';
import 'package:danmalgi_mobile/core/providers/app_message_notifier.dart';
import 'package:danmalgi_mobile/core/providers/local_user_settings_service_provider.dart';
import 'package:danmalgi_mobile/core/session/session_notifier.dart';
import 'package:danmalgi_mobile/features/auth/data/providers/auth_provider.dart';
import 'package:danmalgi_mobile/features/auth/data/providers/social_provider.dart';
import 'package:danmalgi_mobile/features/user/domain/oauth_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_view_model.g.dart';

@riverpod
class LoginViewModel extends _$LoginViewModel {
  @override
  FutureOr<void> build() {}

  Future<void> login({required OAuthType oAuthType}) async {
    if (state.isLoading) return;
    final authenticator = ref.read(socialAuthenticatorProvider)[oAuthType];
    if (authenticator == null) return;

    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      final credential = await authenticator.signIn();
      if (credential == null) return;

      final deviceId = await ref.read(deviceIdProvider.future);
      final result = await ref
          .read(authRepositoryProvider)
          .authorization(credential: credential, deviceId: deviceId);
      await ref.read(sessionProvider.notifier).signIn(result);
    });

    if (!ref.mounted) return;
    if (result case AsyncError(:final error)) {
      ref
          .read(appMessageNotifierProvider.notifier)
          .show(error is AppException ? error.message : '로그인에 실패했습니다.');
    }
    state = result;
  }
}
