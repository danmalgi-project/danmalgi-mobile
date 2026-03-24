import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:danmalgi_mobile/core/services/notification_service.dart';

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});

// Initialization provider - call this once at app startup
final notificationInitProvider = FutureProvider<void>((ref) async {
  final service = ref.watch(notificationServiceProvider);
  await service.initialize();
});

// FCM Token provider - reactive to changes
final fcmTokenProvider = StreamProvider<String?>((ref) {
  final messaging = FirebaseMessaging.instance;

  return Stream.multi((controller) {
    // Add initial token
    messaging.getToken().then((token) {
      if (token != null) {
        controller.add(token);
      }
    });

    // Listen for refreshes
    final subscription = messaging.onTokenRefresh.listen((token) {
      controller.add(token);
    });

    // Cleanup
    controller.onCancel = () => subscription.cancel();
  });
});

// Permission status provider
final notificationPermissionProvider = FutureProvider<AuthorizationStatus>((
  ref,
) async {
  final settings = await FirebaseMessaging.instance.getNotificationSettings();
  return settings.authorizationStatus;
});

// Message stream provider for foreground messages
final foregroundMessageProvider = StreamProvider<RemoteMessage>((ref) {
  return FirebaseMessaging.onMessage;
});
