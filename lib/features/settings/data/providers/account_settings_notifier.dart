import 'package:danmalgi_mobile/core/providers/app_user_provider.dart';
import 'package:danmalgi_mobile/core/storage/pref_store.dart';
import 'package:danmalgi_mobile/core/storage/storage_providers.dart';
import 'package:danmalgi_mobile/features/settings/data/settings_keys.dart';
import 'package:danmalgi_mobile/features/settings/domain/account_settings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'account_settings_notifier.g.dart';

@Riverpod(keepAlive: true)
class AccountSettingsNotifier extends _$AccountSettingsNotifier {
  @override
  AccountSettings build() {
    final userId = ref.watch(currentUserProvider.select((u) => u?.id));
    if (userId == null) return const AccountSettings();

    final prefs = ref.watch(userPrefsProvider(userId));
    return AccountSettings(
      dmPushEnabled: prefs.get(AccountSettingKeys.dmPushEnabled),
      friendRequestPushEnabled: prefs.get(
        AccountSettingKeys.friendRequestPushEnabled,
      ),
    );
  }

  PrefStore? get _prefs {
    final userId = ref.read(currentUserProvider)?.id;
    return userId == null ? null : ref.read(userPrefsProvider(userId));
  }

  Future<void> setDmPushEnabled(bool enabled) async {
    final prefs = _prefs;
    if (prefs == null) return;
    state = state.copyWith(dmPushEnabled: enabled);
    await prefs.set(AccountSettingKeys.dmPushEnabled, enabled);
    // TODO(server): 설정 RPC가 생기면 여기에 추가
  }
}
