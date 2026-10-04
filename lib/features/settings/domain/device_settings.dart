import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_settings.freezed.dart';

@freezed
sealed class DeviceSettings with _$DeviceSettings {
  const factory DeviceSettings({
    @Default(ThemeMode.dark) ThemeMode themeMode,
    String? audioOutputId,
  }) = _DeviceSettings;
}
