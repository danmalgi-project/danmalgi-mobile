class RegisterState {
  String? nickname;
  String? tag;
  String? nicknameError;
  String? tagError;
  final String? error;

  RegisterState({
    this.nickname,
    this.tag,
    this.nicknameError,
    this.tagError,
    this.error,
  });

  bool get isButtonEnabled =>
      nickname != null &&
      nickname!.isNotEmpty &&
      tag != null &&
      tag!.isNotEmpty &&
      nicknameError == null &&
      tagError == null;

  bool get hasNameTag =>
      nickname != null &&
      nickname!.isNotEmpty &&
      tag != null &&
      tag!.isNotEmpty;

  RegisterState copyWith({
    String? nickname,
    String? tag,
    String? nicknameError,
    String? tagError,
    String? error,
  }) {
    return RegisterState(
      nickname: nickname ?? this.nickname,
      tag: tag ?? this.tag,
      nicknameError: nicknameError,
      tagError: tagError,
      error: error,
    );
  }
}
