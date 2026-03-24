class AuthState {
  final String accessToken;

  AuthState({required this.accessToken});

  AuthState copyWith({String? accessToken}) {
    return AuthState(accessToken: accessToken ?? this.accessToken);
  }
}
