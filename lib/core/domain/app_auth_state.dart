import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:danmalgi_mobile/features/user/domain/user.dart';

part 'app_auth_state.freezed.dart';

@freezed
sealed class AppAuthState with _$AppAuthState {
  const factory AppAuthState.loading() = _Loading;

  // TODO: Reasone 추가 (토큰 만료 등등)
  const factory AppAuthState.unauthenticated() = _Unauthenticated;

  const factory AppAuthState.bootstrapping() = _Bootstrapping;

  const factory AppAuthState.authenticated({required User user}) =
      _Authenticated;

  const factory AppAuthState.needsRegistration() = _NeedsRegistration;

  const factory AppAuthState.blocked() = _Blocked;

  const factory AppAuthState.withdrawn() = _Withdrawn;

  const factory AppAuthState.error({
    required Object error,
    @Default(true) bool canRetry,
  }) = _Error;
}
