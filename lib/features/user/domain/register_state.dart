import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_state.freezed.dart';

@freezed
abstract class RegisterState with _$RegisterState {
  const RegisterState._();

  const factory RegisterState({
    String? nickname,
    @Default('0000') String tag,
    Uint8List? profileImage,
    String? nicknameError,
    String? tagError,
    String? error,
    @Default(false) bool isSubmitting,
  }) = _RegisterState;

  String get _trimmedNickname => nickname?.trim() ?? '';

  bool get hasNickname => _trimmedNickname.isNotEmpty;

  bool get isButtonEnabled =>
      hasNickname && nicknameError == null && !isSubmitting;

  String get displayNickname => hasNickname ? _trimmedNickname : '단말기';
}
