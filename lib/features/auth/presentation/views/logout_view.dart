import 'package:danmalgi_mobile/core/providers/app_user_provider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:danmalgi_mobile/features/auth/data/providers/auth_notifier.dart';

class LogoutView extends ConsumerWidget {
  const LogoutView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (user != null)
              Column(
                children: [
                  Text(user.id.toString()),
                  Text(user.email),
                  Text(user.name),
                  Text(user.tag),
                  Text(user.oauthType.toString()),
                  Text(user.status.toString()),
                  Text(user.lastLoginTime.toString()),
                ],
              ),

            ElevatedButton(
              onPressed: () async =>
                  await ref.read(authNotifierProvider.notifier).logout(),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                minimumSize: Size(300, 50),
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFF03C75A),
              ),
              child: Text(
                "네이버 로그아웃",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
