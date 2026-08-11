import 'package:danmalgi_mobile/core/theme/app_colors.dart';
import 'package:danmalgi_mobile/features/auth/presentation/providers/login_view_model.dart';
import 'package:danmalgi_mobile/features/onboarding/presentation/widgets/welcome_card_widget.dart';
import 'package:danmalgi_mobile/features/user/domain/oauth_type.dart';
import 'package:flutter/material.dart';

import 'package:danmalgi_mobile/features/onboarding/presentation/widgets/onboarding_main_layout.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class WelcomeMain extends StatelessWidget {
  const WelcomeMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(top: 256, child: WelcomeCardWidget()),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFFE500),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset("assets/Icons/Icon-call_end.svg"),
              ),
            ),
            SizedBox(height: 32),
            OnboardingMainFrame(
              title: '모든 대화,\n한 곳에서.',
              description: '채팅, 음성통화, 화면공유까지',
              body: null,
            ),
          ],
        ),
      ],
    );
  }
}

class AuthMain extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(top: 36),
      child: OnboardingMainFrame(
        title: '로그인',
        description: '소셜 계정으로 간편하게 시작하세요',
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  // TODO: 기존 데이터가 남아있을 때 로그인을 실패하는 경우가 발생할 수 있을 것 같은데 이는 어떻게 해결할지
                  await ref
                      .read(loginViewModelProvider.notifier)
                      .login(oAuthType: OAuthType.GOOGLE);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppPrimitiveColors.white,
                  foregroundColor: AppPrimitiveColors.black,
                  disabledBackgroundColor: AppPrimitiveColors.white.withValues(
                    alpha: 0.6,
                  ),
                  disabledForegroundColor: AppPrimitiveColors.black.withValues(
                    alpha: 0.4,
                  ),
                  overlayColor: AppPrimitiveColors.black.withValues(
                    alpha: 0.05,
                  ),
                  elevation: 0,
                  shape: StadiumBorder(),
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
            SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  // TODO: 기존 데이터가 남아있을 때 로그인을 실패하는 경우가 발생할 수 있을 것 같은데 이는 어떻게 해결할지
                  await ref
                      .read(loginViewModelProvider.notifier)
                      .login(oAuthType: OAuthType.GOOGLE);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppPrimitiveColors.white,
                  foregroundColor: AppPrimitiveColors.black,
                  disabledBackgroundColor: AppPrimitiveColors.white.withValues(
                    alpha: 0.6,
                  ),
                  disabledForegroundColor: AppPrimitiveColors.black.withValues(
                    alpha: 0.4,
                  ),
                  overlayColor: AppPrimitiveColors.black.withValues(
                    alpha: 0.05,
                  ),
                  elevation: 0,
                  shape: StadiumBorder(),
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
          ],
        ),
      ),
    );
  }
}
