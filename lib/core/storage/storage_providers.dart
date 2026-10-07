import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:danmalgi_mobile/core/services/secure_storage_service.dart';
import 'package:danmalgi_mobile/core/storage/pref_store.dart';

part 'storage_providers.g.dart';

@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) =>
    throw UnimplementedError('main()에서 override 해야 합니다.');

@Riverpod(keepAlive: true)
SecureStorageService secureStorage(Ref ref) =>
    SecureStorageService(const FlutterSecureStorage());

@Riverpod(keepAlive: true)
PrefStore devicePrefs(Ref ref) =>
    PrefStore(ref.watch(sharedPreferencesProvider), 'device');

@Riverpod(keepAlive: true)
PrefStore sessionPrefs(Ref ref) =>
    PrefStore(ref.watch(sharedPreferencesProvider), 'session');

@Riverpod(keepAlive: true)
PrefStore userPrefs(Ref ref, int userId) =>
    PrefStore(ref.watch(sharedPreferencesProvider), 'user.$userId');
