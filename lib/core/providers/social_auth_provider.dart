import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in_all_platforms/google_sign_in_all_platforms.dart';

final googleSignInProvider = Provider<GoogleSignIn>((ref) {
  return GoogleSignIn(
    params: GoogleSignInParams(
      clientId: dotenv.get("GID_SERVER_CLIENT_ID"),
      clientSecret: (!Platform.isAndroid || !Platform.isIOS)
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
