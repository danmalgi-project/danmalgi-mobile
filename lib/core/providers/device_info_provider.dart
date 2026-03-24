import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final deviceInfoProvider = FutureProvider<String?>((ref) async {
  String? deviceIdentifier;
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  // 나중에 Null 값 처리 필요
  if (Platform.isAndroid) {
    final androidInfo = await deviceInfo.androidInfo;
    deviceIdentifier = androidInfo.id;
  } else if (Platform.isIOS) {
    final iosInfo = await deviceInfo.iosInfo;
    deviceIdentifier = iosInfo.identifierForVendor!;
  } else if (Platform.isLinux) {
    final linuxInfo = await deviceInfo.linuxInfo;
    deviceIdentifier = linuxInfo.machineId!;
  } else if (Platform.isWindows) {
    final windowsInfo = await deviceInfo.windowsInfo;
    deviceIdentifier = windowsInfo.deviceId;
  }
  // else if (kIsWeb) {
  //   var webInfo = await deviceInfo.webBrowserInfo;
  //   deviceIdentifier =
  //       webInfo.vendor! +
  //       webInfo.userAgent! +
  //       webInfo.hardwareConcurrency.toString();
  // }

  return deviceIdentifier;
});
