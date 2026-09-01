import 'package:danmalgi_mobile/features/user/domain/user_status.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:danmalgi_mobile/features/user/domain/oauth_type.dart';
import 'package:danmalgi_mobile/features/user/domain/user.dart';

class LocalStorageService {
  final SharedPreferences _prefs;

  LocalStorageService(this._prefs);

  // User
  static const _keyId = 'id';
  static const _keyEmail = 'email';
  static const _keyName = 'name';
  static const _keyTag = 'tag';
  static const _keyImageUrl = 'imageUrl';
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

  Future setImageUrl(String imageUrl) async {
    await _prefs.setString(_keyImageUrl, imageUrl);
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

  String? get imageUrl => _prefs.getString(_keyImageUrl);

  OAuthType? get oAuthType {
    final raw = _prefs.getString(_keyOAuthType);
    return raw == null ? null : OAuthType.values.asNameMap()[raw];
  }

  UserStatus? get status {
    final raw = _prefs.getString(_keyUserStatus);
    return raw == null ? null : UserStatus.values.asNameMap()[raw];
  }

  DateTime? get lastLoginTime {
    final ts = _prefs.getInt(_keyLastLoginTime);
    return ts == null ? null : DateTime.fromMillisecondsSinceEpoch(ts);
  }

  Future setUser(User user) async {
    await setId(user.id);
    await setEmail(user.email);
    await setName(user.name);
    await setTag(user.tag);
    await setImageUrl(user.imageUrl ?? "");
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
    final imageUrl = this.imageUrl;

    if (id == null || id <= 0) return null;
    if (email == null || email.isEmpty) return null;
    if (status == null) return null;

    return User(
      id: id,
      name: name ?? "",
      email: email,
      tag: tag ?? "",
      imageUrl: imageUrl,
      oauthType: oauthType,
      status: status,
      lastLoginTime: lastLoginTime,
    );
  }

  Future clearUserData() async {
    await _prefs.remove(_keyId);
    await _prefs.remove(_keyEmail);
    await _prefs.remove(_keyName);
    await _prefs.remove(_keyTag);
    await _prefs.remove(_keyImageUrl);
    await _prefs.remove(_keyOAuthType);
    await _prefs.remove(_keyUserStatus);
    await _prefs.remove(_keyLastLoginTime);
  }

  // OnBoarding
  static const String _keyOnBoardingVersion = 'onboardingVersion';

  Future setOnBoardingVersion(int version) async {
    await _prefs.setInt(_keyOnBoardingVersion, version);
  }

  int? get onBoardingVersion => _prefs.getInt(_keyOnBoardingVersion);

  // ETC
  Future clearLocalData() async {
    await _prefs.clear();
    await _prefs.reload();
  }
}
