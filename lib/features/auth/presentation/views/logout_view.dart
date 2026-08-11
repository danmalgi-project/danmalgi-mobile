import 'package:cached_network_image/cached_network_image.dart';
import 'package:danmalgi_mobile/core/providers/app_user_provider.dart';
import 'package:danmalgi_mobile/core/providers/notification_provider.dart';
import 'package:danmalgi_mobile/core/widgets/cached_circle_avatar.dart';
import 'package:danmalgi_mobile/features/user/data/providers/user_notifier.dart';
import 'package:danmalgi_mobile/features/user/data/providers/user_provider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:danmalgi_mobile/features/auth/data/providers/auth_notifier.dart';
import 'package:image_picker/image_picker.dart';

class LogoutView extends ConsumerWidget {
  const LogoutView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final fcmToken = ref.watch(fcmTokenProvider).value;
    final permissionAsync = ref.watch(notificationPermissionProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (user != null)
              Column(
                children: [
                  GestureDetector(
                    child: CachedCircleAvatar(url: user.imageUrl, radius: 75.0),
                    onTap: () async {
                      final picker = ImagePicker();
                      final image = await picker.pickImage(
                        source: ImageSource.gallery,
                      );
                      if (image == null) return;
                      final bytes = await image.readAsBytes();

                      await ref
                          .read(userNotifierProvider.notifier)
                          .uploadProfileImage(
                            bytes: bytes,
                            mimeType: image.mimeType,
                          );
                    },
                  ),
                  SizedBox(height: 18.0),
                  Text(
                    user.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24.0,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "#${user.tag}",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.0,
                      color: Color(0xFF999999),
                    ),
                  ),
                  // Text(user.id.toString()),
                  // Text(user.email),
                  // Text(user.name),
                  // Text(user.tag),
                  // Text(user.oauthType.toString()),
                  // Text(user.status.toString()),
                  // Text(user.lastLoginTime.toString()),
                ],
              ),
            // if (fcmToken != null) Text(fcmToken),
            // if (permissionAsync.value != null)
            //   Text(permissionAsync.requireValue.name),
            // ElevatedButton(
            //   onPressed: () async {
            //     final picker = ImagePicker();
            //     final image = await picker.pickImage(
            //       source: ImageSource.gallery,
            //     );
            //     if (image == null) return;
            //     final bytes = await image.readAsBytes();

            //     await ref
            //         .read(userNotifierProvider.notifier)
            //         .uploadProfileImage(bytes: bytes, mimeType: image.mimeType);
            //   },
            //   style: ElevatedButton.styleFrom(
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(5.0),
            //     ),
            //     minimumSize: Size(300, 50),
            //     foregroundColor: Colors.white,
            //     backgroundColor: Color(0xFF03C75A),
            //   ),
            //   child: Text(
            //     "프로필 이미지 업로드",
            //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            //   ),
            // ),
            ElevatedButton(
              onPressed: () async =>
                  await ref.read(authNotifierProvider.notifier).logout(),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                minimumSize: Size(300, 50),
                foregroundColor: Colors.white,
                // backgroundColor: Color(0xFF03C75A),
              ),
              child: Text(
                "로그아웃",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
