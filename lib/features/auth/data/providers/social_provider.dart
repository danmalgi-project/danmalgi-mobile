import 'dart:io';

import 'package:danmalgi_mobile/features/auth/data/authenticators/google_authenticator.dart';
import 'package:danmalgi_mobile/features/auth/domain/social_authenticator.dart';
import 'package:danmalgi_mobile/features/user/domain/oauth_type.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in_all_platforms/google_sign_in_all_platforms.dart';

final socialAuthenticatorProvider =
    Provider<Map<OAuthType, SocialAuthenticator>>(
      (ref) => {
        OAuthType.GOOGLE: GoogleAuthenticator(ref.watch(googleSignInProvider)),
      },
    );

final googleSignInProvider = Provider<GoogleSignIn>((ref) {
  return GoogleSignIn(
    params: GoogleSignInParams(
      clientId: dotenv.get("GID_SERVER_CLIENT_ID"),
      clientSecret: (!Platform.isAndroid && !Platform.isIOS)
          ? dotenv.get("GID_SERVER_CLIENT_SECRET")
          : null,
      redirectPort: 8000,
      scopes: [
        'https://www.googleapis.com/auth/userinfo.profile',
        'https://www.googleapis.com/auth/userinfo.email',
        'openid',
      ],
    ),
  );
});
