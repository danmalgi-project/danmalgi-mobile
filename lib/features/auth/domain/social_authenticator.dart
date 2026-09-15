import 'package:danmalgi_mobile/features/auth/domain/social_credential.dart';

abstract interface class SocialAuthenticator {
  Future<SocialCredential?> signIn();

  Future<void> signOut();
}
