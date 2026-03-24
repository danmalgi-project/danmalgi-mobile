import 'package:danmalgi_mobile/core/generated/auth.pbgrpc.dart';
import 'package:danmalgi_mobile/core/generated/user.pb.dart' as pb;
import 'package:danmalgi_mobile/core/services/local_storage_service.dart';
import 'package:danmalgi_mobile/core/services/secure_storage_service.dart';
import 'package:danmalgi_mobile/features/auth/domain/auth_state.dart';
import 'package:danmalgi_mobile/features/user/data/extensions/oauth_type_mapper.dart';
import 'package:danmalgi_mobile/features/user/data/repositories/user_repository.dart';
import 'package:danmalgi_mobile/features/user/domain/oauth_type.dart';
import 'package:danmalgi_mobile/features/user/domain/user.dart';

class AuthRepository {
  final AuthServiceClient client;

  final SecureStorageService secureStorage;
  final LocalStorageService localStorage;
  final String deviceId;

  AuthRepository(
    this.client,
    this.secureStorage,
    this.localStorage,
    this.deviceId,
  );

  Future<AuthState> authorization({
    required String idToken,
    required OAuthType oAuthType,
  }) async {
    final request = AuthorizationRequest(
      idToken: idToken,
      oauthType: oAuthType.toProto(),
      deviceId: deviceId,
    );

    final response = await client.authorization(request);

    final token = response.accessToken;
    await secureStorage.setAccessToken(token);

    final signedUser = User.fromProto(response.user);
    await localStorage.setUser(signedUser);

    return AuthState(accessToken: token);
  }
}
