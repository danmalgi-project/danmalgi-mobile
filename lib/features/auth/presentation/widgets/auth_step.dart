import 'package:danmalgi_mobile/core/theme/app_button_styles.dart';
import 'package:danmalgi_mobile/core/theme/app_colors.dart';
import 'package:danmalgi_mobile/core/theme/app_dimens.dart';
import 'package:danmalgi_mobile/core/theme/app_typography.dart';
import 'package:danmalgi_mobile/features/auth/presentation/providers/login_view_model.dart';
import 'package:danmalgi_mobile/features/onboarding/presentation/widgets/onboarding_main_layout.dart';
import 'package:danmalgi_mobile/features/user/domain/oauth_type.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

const _google = (
  icon: 'assets/Icons/Google.svg',
  label: 'Sign up with Google',
  type: OAuthType.GOOGLE,
);
const _apple = (
  icon: 'assets/Icons/Apple.svg',
  label: 'Sign up with Apple',
  type: OAuthType.APPLE,
);

class AuthForm extends ConsumerWidget {
  const AuthForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(loginViewModelProvider).isLoading;

    final options = defaultTargetPlatform == TargetPlatform.iOS
        ? [_apple, _google]
        : [_google, _apple];

    return Padding(
      padding: EdgeInsets.only(top: 36),
      child: OnboardingMainFrame(
        title: '로그인',
        description: '소셜 계정으로 간편하게 시작하세요',
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (final (i, o) in options.indexed) ...[
              if (i > 0) const SizedBox(height: AppSpacing.s12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: AppButtonStyles.inverse,
                  icon: SvgPicture.asset(o.icon),
                  label: Text(o.label),
                  onPressed: isLoading
                      ? null
                      : () => ref
                            .read(loginViewModelProvider.notifier)
                            .login(oAuthType: o.type),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class AuthFooter extends StatelessWidget {
  const AuthFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '계속 진행하면 이용약관 및 개인정보처리방침에\n동의하는 것으로 간주됩니다.',
      textAlign: TextAlign.center,
      style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
    );
  }
}
