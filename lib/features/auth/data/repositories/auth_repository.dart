import 'package:danmalgi_mobile/core/generated/auth/v1/auth.pbgrpc.dart';
import 'package:danmalgi_mobile/core/session/session.dart';
import 'package:danmalgi_mobile/features/auth/domain/social_credential.dart';
import 'package:danmalgi_mobile/features/user/data/extensions/oauth_type_mapper.dart';
import 'package:danmalgi_mobile/features/user/domain/user.dart';

class AuthRepository {
  final AuthServiceClient client;

  AuthRepository(this.client);

  Future<AuthResult> authorization({
    required SocialCredential credential,
    required String deviceId,
  }) async {
    final request = AuthorizationRequest(
      idToken: credential.idToken,
      oauthType: credential.type.toProto(),
      deviceId: deviceId,
    );

    final response = await client.authorization(request);
    final user = User.fromProto(response.user);

    return (user: user, accessToken: response.accessToken);
  }
}
