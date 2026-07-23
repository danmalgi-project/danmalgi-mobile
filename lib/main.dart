import 'dart:async';
import 'dart:ui';

import 'package:danmalgi_mobile/core/providers/app_message_notifier.dart';
import 'package:danmalgi_mobile/core/theme/app_theme.dart';
import 'package:danmalgi_mobile/core/widgets/app_message_wrapper.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:danmalgi_mobile/core/providers/storage_provider.dart';
import 'package:danmalgi_mobile/core/router/router.dart';
import 'package:danmalgi_mobile/core/services/notification_service.dart';
import 'package:danmalgi_mobile/firebase_options.dart';

final providerContainer = ProviderContainer();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // AppLogger.initialize();

  await dotenv.load(fileName: ".env");

  await Permission.notification.request();

  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWith((ref) => prefs)],
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      routerConfig: router,
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
      themeMode: ThemeMode.dark,
      builder: (context, child) => AppMessageWrapper(child: child!),
    );
  }
}
