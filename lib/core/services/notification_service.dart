import 'dart:io' show Platform;

import 'package:danmalgi_mobile/core/logging/app_logging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logging/logging.dart';

class NotificationService {
  static final _log = Logger('core.NotificationService');

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  final Future<void> Function(String token)? onTokenUpdated;

  NotificationService({this.onTokenUpdated});

  String? _fcmToken;
  String? get fcmToken => _fcmToken;
  // Initialize everything in one place
  Future<void> initialize() async {
    // FCM has no Windows plugin implementation; Windows is debug-only for us.
    if (Platform.isWindows) return;

    // Request permissions first
    await _requestPermissions();

    // Setup local notifications for foreground
    await _setupLocalNotifications();

    // Get and save FCM token
    await _setupFCMToken();

    // Handle incoming messages
    _setupMessageHandlers();

    _log.info('Notification initialized');
  }

  Future<void> _requestPermissions() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false, // Set true for quiet permissions on iOS
    );
    _log.info('Permission status: ${settings.authorizationStatus}');

    // On iOS, you might want to request additional permissions
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      _log.info('✅ User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      _log.info('⚠️ User granted provisional permission');
    } else {
      _log.warning('❌ User declined or has not accepted permission');
    }
  }

  Future<void> _setupLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false, // Already requested above
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    await _localNotifications.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );
    // Create a notification channel for Android
    const androidChannel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );
    await _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(androidChannel);
  }

  Future<void> _setupFCMToken() async {
    final token = await _messaging.getToken();
    if (token != null) {
      await onTokenUpdated?.call(token);
    }

    _messaging.onTokenRefresh.listen((newToken) {
      onTokenUpdated?.call(newToken);
    });
  }

  Future<void> retryTokenUpload() async {
    if (_fcmToken != null) {
      await onTokenUpdated?.call(_fcmToken!);
    }
  }

  void _setupMessageHandlers() {
    // Handle foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Handle when app is opened from notification
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);

    // Check if app was opened from terminated state
    _checkInitialMessage();
  }

  Future<void> _checkInitialMessage() async {
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleNotificationTap(initialMessage);
    }
  }

  void _handleForegroundMessage(RemoteMessage message) {
    _log.fine('Foreground message received: ${message.messageId}');

    // Show local notification when app is in foreground
    final notification = message.notification;
    final android = message.notification?.android;
    if (notification != null) {
      _localNotifications.show(
        id: notification.hashCode,
        title: notification.title,
        body: notification.body,
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            channelDescription:
                'This channel is used for important notifications.',
            importance: Importance.high,
            priority: Priority.high,
            icon: android?.smallIcon ?? '@mipmap/ic_launcher',
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: message.data.toString(),
      );
    }
  }

  void _handleNotificationTap(RemoteMessage message) {
    _log.fine('Notification tapped: ${message.data}');
    // Navigate to specific screen based on message.data
    // We'll use Riverpod to handle this navigation
  }

  void _onNotificationTapped(NotificationResponse response) {
    _log.fine('Local notification tapped: ${response.payload}');
    // Handle navigation here too
  }
}

// Background message handler (must be top-level function)
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  setupLogging();
  await Firebase.initializeApp();
  Logger(
    'core.NotificationService',
  ).fine('Background message received: ${message.messageId}');
}
