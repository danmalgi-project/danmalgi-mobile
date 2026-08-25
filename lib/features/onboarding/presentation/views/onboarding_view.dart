import 'dart:async';

import 'package:danmalgi_mobile/core/domain/app_auth_state.dart';
import 'package:danmalgi_mobile/core/providers/app_auth_status_provider.dart';
import 'package:danmalgi_mobile/core/theme/app_colors.dart';
import 'package:danmalgi_mobile/features/onboarding/domain/onboarding_state.dart';
import 'package:danmalgi_mobile/features/onboarding/domain/onboarding_step.dart';
import 'package:danmalgi_mobile/features/onboarding/presentation/providers/onboarding_controller.dart';
import 'package:danmalgi_mobile/features/onboarding/presentation/widgets/onboarding_build_main_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends ConsumerStatefulWidget {
  const OnboardingView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends ConsumerState<OnboardingView> {
  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _goToNextPage() async {
    final state = ref.read(onboardingControllerProvider);

    if (!_pageController.hasClients) return;
    if (_currentIndex >= state.steps.length - 1) return;

    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  Future<void> _completeOnboarding() async {
    await ref.read(onboardingControllerProvider.notifier).complete();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingControllerProvider);

    ref.listen<AppAuthState>(appAuthStatusProvider, (previous, next) {
      unawaited(
        ref.read(onboardingControllerProvider.notifier).handleAuthState(next),
      );
    });

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: state.steps.length,
                // physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                itemBuilder: (context, index) => _buildMain(state.steps[index]),
              ),
            ),
            SmoothPageIndicator(
              controller: _pageController,
              count: state.steps.length,
              effect: const SlideEffect(
                activeDotColor: Colors.white,
                dotColor: Color(0xFF555555),
                dotHeight: 6,
                dotWidth: 6,
              ),
            ),
            SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _buildBottom(state.steps[_currentIndex], state),
            ),

            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildMain(OnboardingStep step) {
    return switch (step) {
      OnboardingStep.welcome => const WelcomeMain(),

      OnboardingStep.auth => AuthMain(),

      OnboardingStep.nickname => WelcomeMain(),

      OnboardingStep.profile => WelcomeMain(),

      OnboardingStep.ready => const WelcomeMain(),
    };
  }

  Widget _buildBottom(OnboardingStep step, OnboardingState state) {
    if (step == OnboardingStep.auth) {
      return const Text(
        '계속 진행하면 이용약관 및 개인정보처리방침에\n동의하는 것으로 간주됩니다.',
        textAlign: TextAlign.center,
        style: TextStyle(color: Color(0xFF8E8E93), fontSize: 14),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: state.isSaving ? null : () => _handlePrimaryAction(step),
        style: ElevatedButton.styleFrom(
          foregroundColor: _buttonTextColor(step),
          backgroundColor: _buttonColor(step),
          // textStyle: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
          shape: StadiumBorder(),
        ),
        child: state.isSaving
            ? const CircularProgressIndicator()
            : Text(_buttonText(step)),
      ),
    );
  }

  Future<void> _handlePrimaryAction(OnboardingStep step) async {
    switch (step) {
      case OnboardingStep.welcome:
        await _goToNextPage();

      case OnboardingStep.nickname:
        await _goToNextPage();

      case OnboardingStep.profile:
        await _goToNextPage();

      case OnboardingStep.ready:
        await _completeOnboarding();

      case OnboardingStep.auth:
        break;
    }
  }

  String _buttonText(OnboardingStep step) {
    return switch (step) {
      OnboardingStep.welcome => "시작하기",

      OnboardingStep.nickname => "설정하기",

      OnboardingStep.profile => "설정하기",

      OnboardingStep.ready => "시작하기",

      OnboardingStep.auth => "",
    };
  }

  Color _buttonColor(OnboardingStep step) {
    return switch (step) {
      OnboardingStep.welcome => AppColors.accent,

      OnboardingStep.nickname => const Color(0xFF4F7CFF),

      OnboardingStep.profile => const Color(0xFF8A6DFF),

      OnboardingStep.ready => const Color(0xFF22A06B),

      OnboardingStep.auth => Colors.transparent,
    };
  }

  Color _buttonTextColor(OnboardingStep step) {
    return switch (step) {
      OnboardingStep.welcome => const Color(0xFF000000),

      OnboardingStep.nickname => const Color(0xFF4F7CFF),

      OnboardingStep.profile => const Color(0xFF8A6DFF),

      OnboardingStep.ready => const Color(0xFF22A06B),

      OnboardingStep.auth => Colors.transparent,
    };
  }
}
