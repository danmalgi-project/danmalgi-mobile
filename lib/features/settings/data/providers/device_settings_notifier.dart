import 'package:danmalgi_mobile/core/storage/pref_store.dart';
import 'package:danmalgi_mobile/core/storage/storage_providers.dart';
import 'package:danmalgi_mobile/features/settings/data/settings_keys.dart';
import 'package:danmalgi_mobile/features/settings/domain/device_settings.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_settings_notifier.g.dart';

@Riverpod(keepAlive: true)
class DeviceSettingsNotifier extends _$DeviceSettingsNotifier {
  PrefStore get _prefs => ref.read(devicePrefsProvider);

  @override
  DeviceSettings build() {
    final prefs = ref.watch(devicePrefsProvider);
    return DeviceSettings(
      themeMode: prefs.get(DeviceSettingKeys.themeMode),
      audioOutputId: prefs.get(DeviceSettingKeys.audioOutputId),
    );
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = state.copyWith(themeMode: mode);
    await _prefs.set(DeviceSettingKeys.themeMode, mode);
  }

  Future<void> setAudioOutputId(String? id) async {
    state = state.copyWith(audioOutputId: id);
    await _prefs.set(DeviceSettingKeys.audioOutputId, id);
  }
}
