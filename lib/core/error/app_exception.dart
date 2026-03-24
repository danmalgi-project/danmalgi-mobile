import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_exception.freezed.dart';

@freezed
sealed class AppException with _$AppException implements Exception {
  // 네트워크 단절 (개발 서버 다운 등)
  const factory AppException.network({
    @Default('네트워크 연결이 끊겼습니다.') String message,
  }) = _Network;

  // 타임아웃
  const factory AppException.timeout({
    @Default('요청 시간이 초과되었습니다.') String message,
  }) = _Timeout;

  // 인증 만료 (401 등)
  const factory AppException.unauthenticated({
    @Default('인증이 만료되었습니다. 다시 로그인해주세요.') String message,
  }) = _Unauthenticated;

  // 서버 에러 또는 알 수 없는 에러
  const factory AppException.unknown(String message) = _Unknown;
}
