import 'package:danmalgi_mobile/features/user/domain/oauth_type.dart';

class SocialCredential {
  final OAuthType type;
  final String idToken;
  const SocialCredential({required this.type, required this.idToken});
}
