import 'package:danmalgi_mobile/core/error/app_exception.dart';
import 'package:danmalgi_mobile/features/auth/domain/social_authenticator.dart';
import 'package:danmalgi_mobile/features/auth/domain/social_credential.dart';
import 'package:danmalgi_mobile/features/user/domain/oauth_type.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in_all_platforms/google_sign_in_all_platforms.dart';

class GoogleAuthenticator implements SocialAuthenticator {
  final GoogleSignIn _googleSignIn;
  GoogleAuthenticator(this._googleSignIn);

  @override
  Future<SocialCredential?> signIn() async {
    await _googleSignIn.signOut();
    try {
      final idToken = (await _googleSignIn.signIn())?.idToken;
      if (idToken == null) return null;
      return SocialCredential(type: OAuthType.GOOGLE, idToken: idToken);
    } on PlatformException catch (e) {
      throw AppException.unauthenticated(message: 'Google 로그인 실패 (${e.code})');
    }
  }

  @override
  Future<void> signOut() => _googleSignIn.signOut();
}
