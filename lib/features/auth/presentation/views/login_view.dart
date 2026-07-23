import 'dart:ui';

import 'package:danmalgi_mobile/core/theme/app_colors.dart';
import 'package:danmalgi_mobile/features/auth/presentation/providers/login_view_model.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:danmalgi_mobile/features/user/domain/oauth_type.dart';
import 'package:flutter_svg/svg.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginViewModelProvider);
    final isLoading = state.isLoading;

    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppPrimitiveColors.white,
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/Login/shape2.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/Login/shape1.png',
                    fit: BoxFit.cover,
                  ),
                ),

                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 38.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "단말기에 로그인하세요.",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 30.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          "원하는 로그인을 선택하세요",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 40.0),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () async {
                                    // TODO: 기존 데이터가 남아있을 때 로그인을 실패하는 경우가 발생할 수 있을 것 같은데 이는 어떻게 해결할지
                                    await ref
                                        .read(loginViewModelProvider.notifier)
                                        .login(oAuthType: OAuthType.GOOGLE);
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppPrimitiveColors.white,
                              foregroundColor: AppPrimitiveColors.black,
                              disabledBackgroundColor: AppPrimitiveColors.white
                                  .withValues(alpha: 0.6),
                              disabledForegroundColor: AppPrimitiveColors.black
                                  .withValues(alpha: 0.4),
                              overlayColor: AppPrimitiveColors.black.withValues(
                                alpha: 0.05,
                              ),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 18),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset("assets/Icons/Google.svg"),
                                SizedBox(width: 8.0),
                                Text(
                                  "Sign up with Google",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () async {
                                    // TODO: 기존 데이터가 남아있을 때 로그인을 실패하는 경우가 발생할 수 있을 것 같은데 이는 어떻게 해결할지
                                    await ref
                                        .read(loginViewModelProvider.notifier)
                                        .login(oAuthType: OAuthType.GOOGLE);
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppPrimitiveColors.white,
                              foregroundColor: AppPrimitiveColors.black,
                              disabledBackgroundColor: AppPrimitiveColors.white
                                  .withValues(alpha: 0.6),
                              disabledForegroundColor: AppPrimitiveColors.black
                                  .withValues(alpha: 0.4),
                              overlayColor: AppPrimitiveColors.black.withValues(
                                alpha: 0.05,
                              ),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 18),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset("assets/Icons/Apple.svg"),
                                SizedBox(width: 8.0),
                                Text(
                                  "Sign up with Apple",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 150),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        if (isLoading)
          Container(
            color: AppPrimitiveColors.black.withValues(
              alpha: 0.3,
            ), // 화면을 반투명하게 덮음
            child: const Center(
              child: CircularProgressIndicator(), // 정중앙 스피너
            ),
          ),
      ],
    );
  }
}
