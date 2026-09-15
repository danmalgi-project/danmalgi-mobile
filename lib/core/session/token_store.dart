import 'package:danmalgi_mobile/core/providers/storage_provider.dart';
import 'package:danmalgi_mobile/core/services/secure_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TokenStore {
  final SecureStorageService _secure;
  TokenStore(this._secure);

  String? _accessToken;
  String? get accessToken => _accessToken;

  Future<String?> restore() async =>
      _accessToken = await _secure.getAccessToken();

  Future<void> save(String accessToken, {bool persist = true}) async {
    _accessToken = accessToken;
    if (persist) await _secure.setAccessToken(accessToken);
  }

  Future<void> clear() async {
    _accessToken = null;
    await _secure.deleteAccessToken();
  }
}

final tokenStoreProvider = Provider<TokenStore>(
  (ref) => TokenStore(ref.watch(secureStorageProvider)),
);
