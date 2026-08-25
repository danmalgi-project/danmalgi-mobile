import 'package:danmalgi_mobile/core/theme/app_button_styles.dart';
import 'package:danmalgi_mobile/core/theme/app_dimens.dart';
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
  const AuthMain({super.key});

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
              child: ElevatedButton.icon(
                style: AppButtonStyles.inverse,
                icon: SvgPicture.asset('assets/Icons/Google.svg'),
                label: const Text('Sign up with Google'),
                onPressed: () => ref
                    .read(loginViewModelProvider.notifier)
                    .login(oAuthType: OAuthType.GOOGLE),
              ),
            ),
            SizedBox(height: 12),
            const SizedBox(height: AppSpacing.s12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: AppButtonStyles.inverse,
                icon: SvgPicture.asset('assets/Icons/Apple.svg'),
                label: const Text('Sign up with Apple'),
                onPressed: () => ref
                    .read(loginViewModelProvider.notifier)
                    .login(oAuthType: OAuthType.GOOGLE),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
