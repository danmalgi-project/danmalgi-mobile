import 'package:danmalgi_mobile/features/user/domain/user_status.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:danmalgi_mobile/features/user/domain/oauth_type.dart';
import 'package:danmalgi_mobile/features/user/domain/user.dart';

class LocalStorageService {
  final SharedPreferences _prefs;

  LocalStorageService(this._prefs);

  static const _keyId = 'id';
  static const _keyEmail = 'email';
  static const _keyName = 'name';
  static const _keyTag = 'tag';
  static const _keyOAuthType = 'oAuthType';
  static const _keyUserStatus = 'userStatus';
  static const _keyLastLoginTime = 'lastLoginTime';

  Future setId(int id) async {
    await _prefs.setInt(_keyId, id);
  }

  Future setEmail(String email) async {
    await _prefs.setString(_keyEmail, email);
  }

  Future setName(String name) async {
    await _prefs.setString(_keyName, name);
  }

  Future setTag(String tag) async {
    await _prefs.setString(_keyTag, tag);
  }

  Future setOAuthType(OAuthType oauthType) async {
    await _prefs.setString(_keyOAuthType, oauthType.name);
  }

  Future setStatus(UserStatus status) async {
    await _prefs.setString(_keyUserStatus, status.name);
  }

  Future setLastLoginTime(DateTime time) async {
    await _prefs.setInt(_keyLastLoginTime, time.millisecondsSinceEpoch);
  }

  int? get id => _prefs.getInt(_keyId);

  String? get email => _prefs.getString(_keyEmail);

  String? get name => _prefs.getString(_keyName);

  String? get tag => _prefs.getString(_keyTag);

  // TODO: 추후 리스트 형태로 변경 & Null 값 에러 핸들링 추가
  OAuthType? get oAuthType =>
      OAuthType.values.byName(_prefs.getString(_keyOAuthType) ?? "GOOGLE");

  UserStatus? get status => UserStatus.values.byName(
    _prefs.getString(_keyUserStatus) ?? "USER_PENDING",
  );

  DateTime? get lastLoginTime {
    final timestamp = _prefs.getInt(_keyLastLoginTime) ?? 0;
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  Future setUser(User user) async {
    await setId(user.id);
    await setEmail(user.email);
    await setName(user.name);
    await setTag(user.tag);
    // TODO: OAuthType 에러 핸들링 필요
    await setOAuthType(user.oauthType ?? OAuthType.GOOGLE);
    await setStatus(user.status ?? UserStatus.PENDING);
    await setLastLoginTime(DateTime.now());
  }

  User? get cachedUserOrNull {
    final id = this.id;
    final email = this.email;
    final oauthType = this.oAuthType;
    final status = this.status;

    if (id == null || id <= 0) return null;

    if (email == null || email.isEmpty) return null;

    return User(
      id: id,
      name: name ?? "",
      email: email,
      tag: tag ?? "",
      oauthType: oauthType,
      status: status,
      lastLoginTime: lastLoginTime,
    );
  }

  Future clearLocalData() async {
    await _prefs.clear();
    await _prefs.reload();
  }
}
