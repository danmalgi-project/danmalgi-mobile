import 'package:danmalgi_mobile/core/storage/pref_key.dart';
import 'package:danmalgi_mobile/core/storage/pref_store.dart';
import 'package:danmalgi_mobile/core/storage/storage_providers.dart';
import 'package:danmalgi_mobile/features/user/domain/oauth_type.dart';
import 'package:danmalgi_mobile/features/user/domain/user.dart';
import 'package:danmalgi_mobile/features/user/domain/user_status.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_cache.g.dart';

final _userKey = PrefKey.json<User>(
  'user',
  toJson: (u) => {
    'id': u.id,
    'email': u.email,
    'name': u.name,
    'tag': u.tag,
    'imageUrl': u.imageUrl,
    'oauthType': u.oauthType?.name,
    'status': u.status?.name,
    'lastLoginTime': u.lastLoginTime?.millisecondsSinceEpoch,
  },
  fromJson: (j) => User(
    id: j['id'] as int,
    email: j['email'] as String,
    name: j['name'] as String,
    tag: j['tag'] as String,
    imageUrl: j['imageUrl'] as String?,
    oauthType: OAuthType.values.asNameMap()[j['oauthType']],
    status: UserStatus.values.asNameMap()[j['status']],
    lastLoginTime: switch (j['lastLoginTime']) {
      int ms => DateTime.fromMillisecondsSinceEpoch(ms),
      _ => null,
    },
  ),
);

class UserCache {
  final PrefStore _prefs;
  UserCache(this._prefs);

  User? read() {
    final user = _prefs.get(_userKey);
    if (user == null || user.id <= 0 || user.email.isEmpty) return null;
    return user;
  }

  Future<void> write(User user) => _prefs.set(_userKey, user);

  Future<void> clear() => _prefs.remove(_userKey);
}

@Riverpod(keepAlive: true)
UserCache userCache(Ref ref) => UserCache(ref.watch(sessionPrefsProvider));
