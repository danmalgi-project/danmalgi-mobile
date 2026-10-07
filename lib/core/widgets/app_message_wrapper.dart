import 'package:danmalgi_mobile/core/providers/app_message_notifier.dart';
import 'package:danmalgi_mobile/core/providers/app_user_provider.dart';
import 'package:danmalgi_mobile/core/providers/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppMessageWrapper extends ConsumerWidget {
  final Widget child;

  const AppMessageWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);

    if (currentUser != null) {
      ref.watch(notificationInitProvider);
      ref.watch(fcmTokenProvider);
      ref.watch(notificationPermissionProvider);
    }

    ref.listen(appMessageNotifierProvider, (previous, next) {
      if (next != null) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next), behavior: SnackBarBehavior.floating),
        );
      }
    });

    ref.listen(currentUserProvider, (previous, next) {
      // 로그아웃 → 로그인 전환 시
      if (previous == null && next != null) {
        ref.read(notificationServiceProvider).retryTokenUpload();
      }
    });

    ref.listen(notificationInitProvider, (previous, next) {
      next.when(
        error: (err, stack) => print('❌ Notification 초기화 실패: $err'),
        data: (void data) => print('✅ Notification 초기화 성공'),
        loading: () {},
      );
    });

    return child;
  }
}
