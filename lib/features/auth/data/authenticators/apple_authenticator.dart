import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:danmalgi_mobile/core/error/app_exception.dart';
import 'package:danmalgi_mobile/features/auth/domain/social_authenticator.dart';
import 'package:danmalgi_mobile/features/auth/domain/social_credential.dart';
import 'package:danmalgi_mobile/features/user/domain/oauth_type.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleAuthenticator implements SocialAuthenticator {
  final WebAuthenticationOptions? _webOptions;
  AppleAuthenticator(this._webOptions);

  @override
  Future<SocialCredential?> signIn() async {
    try {
      final rawNonce = _generateNonce();

      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: _webOptions,
        nonce: _sha256Hex(rawNonce),
      );

      final idToken = credential.identityToken;
      if (idToken == null) {
        throw AppException.unauthenticated(
          message: 'Apple 로그인 실패 (idToken 없음)',
        );
      }
      return SocialCredential(
        type: OAuthType.APPLE,
        idToken: idToken,
        authorizationCode: credential.authorizationCode,
        rawNonce: rawNonce,
      );
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled) return null;
      throw AppException.unauthenticated(
        message: 'Apple 로그인 실패 (${e.code.name})',
      );
    }
  }

  @override
  Future<void> signOut() async {}
}

String _generateNonce([int length = 32]) {
  const charset =
      '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  final random = Random.secure();
  return List.generate(
    length,
    (_) => charset[random.nextInt(charset.length)],
  ).join();
}

String _sha256Hex(String input) =>
    sha256.convert(utf8.encode(input)).toString();
