import 'package:danmalgi_mobile/core/storage/pref_key.dart';
import 'package:flutter/material.dart';

abstract final class DeviceSettingKeys {
  static final themeMode = PrefKey.enumByName(
    'themeMode',
    ThemeMode.values,
    defaultValue: ThemeMode.dark,
  );
}

abstract final class AccountSettingKeys {
  static final dmPushEnabled = PrefKey.flag(
    'dmPushEnabled',
    defaultValue: true,
  );
  static final friendRequestPushEnabled = PrefKey.flag(
    'friendRequestPushEnabled',
    defaultValue: true,
  );
}
