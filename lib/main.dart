import 'dart:async';
import 'dart:io' show Platform;
import 'dart:ui';

import 'package:danmalgi_mobile/core/logging/app_logging.dart';
import 'package:danmalgi_mobile/core/logging/provider_logger.dart';
import 'package:danmalgi_mobile/core/router/router.dart';
import 'package:danmalgi_mobile/core/services/notification_service.dart';
import 'package:danmalgi_mobile/core/storage/storage_providers.dart';
import 'package:danmalgi_mobile/core/theme/app_theme.dart';
import 'package:danmalgi_mobile/core/widgets/app_message_wrapper.dart';
import 'package:danmalgi_mobile/features/settings/data/providers/device_settings_notifier.dart';
import 'package:danmalgi_mobile/features/voice/presentation/views/voice_pip_overlay.dart';
import 'package:danmalgi_mobile/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

final providerContainer = ProviderContainer();

final _log = Logger('app');

Future<void> main() async {
  setupLogging();
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    _log.severe('Flutter Error', details.exception, details.stack);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    _log.severe('처리되지 않은 에러', error, stack);
    return true;
  };

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (!Platform.isWindows) {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  // AppLogger.initialize();

  await dotenv.load(fileName: ".env");

  await Permission.notification.request();

  final prefs = await SharedPreferences.getInstance();
  await _migrateLegacyPrefs(prefs);

  runApp(
    ProviderScope(
      observers: [ProviderLogger()],
      overrides: [sharedPreferencesProvider.overrideWith((ref) => prefs)],
      child: MyApp(),
    ),
  );
}

Future<void> _migrateLegacyPrefs(SharedPreferences prefs) async {
  final legacy = prefs.getInt('onboardingVersion');
  if (legacy != null) {
    await prefs.setInt('device.onboardingVersion', legacy);
  }

  for (final k in const [
    'onboardingVersion',
    'id',
    'email',
    'name',
    'tag',
    'imageUrl',
    'oAuthType',
    'userStatus',
    'lastLoginTime',
  ]) {
    await prefs.remove(k);
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(
      deviceSettingsProvider.select((s) => s.themeMode),
    );

    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.trackpad,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
        },
      ),
      theme: AppTheme.dark,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      builder: (context, child) => Stack(
        children: [
          Positioned.fill(child: AppMessageWrapper(child: child!)),
          const VoicePipOverlay(),
        ],
      ),
    );
  }
}
