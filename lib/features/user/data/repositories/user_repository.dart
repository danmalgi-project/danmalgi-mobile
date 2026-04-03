import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart';

import 'package:danmalgi_mobile/core/generated/auth.pbgrpc.dart';
import 'package:danmalgi_mobile/core/generated/user.pbgrpc.dart' as pb;
import 'package:danmalgi_mobile/core/services/local_storage_service.dart';
import 'package:danmalgi_mobile/features/user/domain/user.dart';

class UserRepository {
  final pb.UserServiceClient client;
  final AuthServiceClient authClient;

  final LocalStorageService localStorage;

  UserRepository(this.client, this.authClient, this.localStorage);

  Future<User> getUserByToken() async {
    final response = await client.getUserByToken(Empty());
    return User.fromProto(response.user);
  }

  Future<bool> verifyNamedAndTag({
    required String name,
    required String tag,
  }) async {
    try {
      final request = pb.VerifyNameAndTagRequest(name: name, tag: tag);

      await client.verifyNameAndTag(request);

      return false;
    } catch (e) {
      return true;
    }
  }

  Future<User> register({required String nickname, required String tag}) async {
    final request = RegisterRequest(nickname: nickname, tag: tag);

    final response = await authClient.register(request);

    final user = User.fromProto(
      response.user,
    ).copyWith(lastLoginTime: DateTime.now());

    await localStorage.setUser(user);

    return user;
  }

  Future<void> upsertFCMToken({required String fcmToken}) async {
    final request = UpsertFcmTokenRequest(fcmToken: fcmToken);

    await authClient.upsertFcmToken(request);
  }
}
