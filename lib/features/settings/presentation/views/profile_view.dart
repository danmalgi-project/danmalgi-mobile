import 'package:danmalgi_mobile/core/providers/app_user_provider.dart';
import 'package:danmalgi_mobile/core/session/session_notifier.dart';
import 'package:danmalgi_mobile/core/theme/app_colors.dart';
import 'package:danmalgi_mobile/core/theme/app_dimens.dart';
import 'package:danmalgi_mobile/core/theme/app_typography.dart';
import 'package:danmalgi_mobile/core/widgets/cached_circle_avatar.dart';
import 'package:danmalgi_mobile/features/user/data/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(
      requireCurrentUserProvider,
    ); // TODO: 추후 require 말고 다른 방법으로 수정

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '프로필',
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800),
        ),
        actionsPadding: EdgeInsets.only(right: 24.0),
        titleSpacing: 24.0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: AppSpacing.s24),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: Stack(
                      children: [
                        CachedCircleAvatar(url: user.imageUrl, radius: 55.0),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: SizedBox(
                            width: 36,
                            height: 36,
                            child: Material(
                              color: AppColors.accent,
                              shape: CircleBorder(),
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: AppColors.onAccent,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () async {
                      final picker = ImagePicker();
                      final image = await picker.pickImage(
                        source: ImageSource.gallery,
                      );
                      if (image == null) return;
                      final bytes = await image.readAsBytes();

                      // TODO: Profile View Model 부분에 uploadProfileImage 추가될 예정 그 전까지 Repository 불러와서 사용
                      final user = await ref
                          .read(userRepositoryProvider)
                          .uploadProfileImage(
                            bytes: bytes,
                            mimeType: image.mimeType,
                          );
                      await ref.read(sessionProvider.notifier).updateUser(user);
                    },
                  ),
                  SizedBox(height: AppSpacing.s16),
                  Text(user.name, style: AppTypography.titleLg),
                  Text(
                    "#${user.tag}",
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: AppSpacing.s12),
                  Divider(),
                  SizedBox(height: AppSpacing.s12),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.surfacePrimary,
                      foregroundColor: AppColors.surfaceInverse,
                      disabledBackgroundColor: AppColors.surfacePrimary,
                      disabledForegroundColor: AppColors.surfaceInverse,
                      // textStyle: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: AppRadius.brMd,
                      ),
                    ),
                    child: Padding(
                      padding: AppPadding.listButton,
                      child: Row(
                        children: [
                          Icon(Icons.person, size: 18),
                          SizedBox(width: AppSpacing.s8),
                          Text("내 활동 기록", style: AppTypography.subhead),
                          Spacer(),
                          Icon(
                            Icons.chevron_right_rounded,
                            size: 20,
                            color: AppColors.textSecondary,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: AppSpacing.s8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.surfacePrimary,
                      foregroundColor: AppColors.surfaceInverse,
                      disabledBackgroundColor: AppColors.surfacePrimary,
                      disabledForegroundColor: AppColors.surfaceInverse,
                      // textStyle: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: AppRadius.brMd,
                      ),
                    ),
                    child: Padding(
                      padding: AppPadding.listButton,
                      child: Row(
                        children: [
                          Icon(Icons.archive_outlined, size: 18),
                          SizedBox(width: AppSpacing.s8),
                          Text("보관함", style: AppTypography.subhead),
                          Spacer(),
                          Icon(
                            Icons.chevron_right_rounded,
                            size: 20,
                            color: AppColors.textSecondary,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: AppSpacing.s8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.surfacePrimary,
                      foregroundColor: AppColors.surfaceInverse,
                      disabledBackgroundColor: AppColors.surfacePrimary,
                      disabledForegroundColor: AppColors.surfaceInverse,
                      // textStyle: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: AppRadius.brMd,
                      ),
                    ),
                    child: Padding(
                      padding: AppPadding.listButton,
                      child: Row(
                        children: [
                          Icon(Icons.alarm_outlined, size: 18),
                          SizedBox(width: AppSpacing.s8),
                          Text("알림 설정", style: AppTypography.subhead),
                          Spacer(),
                          Icon(
                            Icons.chevron_right_rounded,
                            size: 20,
                            color: AppColors.textSecondary,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: AppSpacing.s8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.surfacePrimary,
                      foregroundColor: AppColors.surfaceInverse,
                      disabledBackgroundColor: AppColors.surfacePrimary,
                      disabledForegroundColor: AppColors.surfaceInverse,
                      // textStyle: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: AppRadius.brMd,
                      ),
                    ),
                    child: Padding(
                      padding: AppPadding.listButton,
                      child: Row(
                        children: [
                          Icon(Icons.settings, size: 18),
                          SizedBox(width: AppSpacing.s8),
                          Text("계정 설정", style: AppTypography.subhead),
                          Spacer(),
                          Icon(
                            Icons.chevron_right_rounded,
                            size: 20,
                            color: AppColors.textSecondary,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: AppSpacing.s8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.surfacePrimary,
                      foregroundColor: AppColors.surfaceInverse,
                      disabledBackgroundColor: AppColors.surfacePrimary,
                      disabledForegroundColor: AppColors.surfaceInverse,
                      // textStyle: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: AppRadius.brMd,
                      ),
                    ),
                    child: Padding(
                      padding: AppPadding.listButton,
                      child: Row(
                        children: [
                          Icon(Icons.dark_mode_outlined, size: 18),
                          SizedBox(width: AppSpacing.s8),
                          Text("테마 설정", style: AppTypography.subhead),
                          Spacer(),
                          Icon(
                            Icons.chevron_right_rounded,
                            size: 20,
                            color: AppColors.textSecondary,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: AppSpacing.s8),
                  ElevatedButton(
                    onPressed: () async =>
                        await ref.read(sessionProvider.notifier).logout(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.surfacePrimary,
                      foregroundColor: AppColors.surfaceInverse,
                      disabledBackgroundColor: AppColors.surfacePrimary,
                      disabledForegroundColor: AppColors.surfaceInverse,
                      // textStyle: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: AppRadius.brMd,
                      ),
                    ),
                    child: Padding(
                      padding: AppPadding.listButton,
                      child: Row(
                        children: [
                          Icon(Icons.logout, size: 18, color: AppColors.danger),
                          SizedBox(width: AppSpacing.s8),
                          Text(
                            "로그아웃",
                            style: AppTypography.subhead.copyWith(
                              color: AppColors.danger,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
