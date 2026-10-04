import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_settings.freezed.dart';

@freezed
sealed class AccountSettings with _$AccountSettings {
  const factory AccountSettings({
    @Default(true) bool dmPushEnabled,
    @Default(true) bool friendRequestPushEnabled,
  }) = _AccountSettings;
}
