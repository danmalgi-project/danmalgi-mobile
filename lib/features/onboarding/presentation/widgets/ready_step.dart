import 'package:danmalgi_mobile/features/onboarding/presentation/widgets/onboarding_primary_button.dart';
import 'package:flutter/material.dart';

import 'package:danmalgi_mobile/features/onboarding/presentation/widgets/onboarding_main_layout.dart';
import 'package:flutter_svg/svg.dart';

class ReadyForm extends StatelessWidget {
  const ReadyForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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

class ReadyFooter extends StatelessWidget {
  final void Function()? onNext;

  const ReadyFooter({super.key, this.onNext});

  @override
  Widget build(BuildContext context) {
    return OnboardingPrimaryButton(
      label: '시작하기',
      isLoading: false,
      onPressed: onNext,
    );
  }
}
