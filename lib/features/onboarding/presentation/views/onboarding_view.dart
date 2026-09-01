import 'dart:async';

import 'package:danmalgi_mobile/core/domain/app_auth_state.dart';
import 'package:danmalgi_mobile/core/providers/app_auth_status_provider.dart';
import 'package:danmalgi_mobile/core/theme/app_colors.dart';
import 'package:danmalgi_mobile/features/auth/presentation/widgets/auth_step.dart';
import 'package:danmalgi_mobile/features/onboarding/domain/onboarding_state.dart';
import 'package:danmalgi_mobile/features/onboarding/domain/onboarding_step.dart';
import 'package:danmalgi_mobile/features/onboarding/presentation/providers/onboarding_controller.dart';
import 'package:danmalgi_mobile/features/onboarding/presentation/widgets/ready_step.dart';
import 'package:danmalgi_mobile/features/onboarding/presentation/widgets/welcome_step.dart';
import 'package:danmalgi_mobile/features/user/presentation/providers/register_view_model.dart';
import 'package:danmalgi_mobile/features/user/presentation/widgets/register_step.dart';
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

  @override
  void initState() {
    super.initState();
    final steps = ref.read(onboardingControllerProvider).steps;
    final index = steps.indexOf(ref.read(onboardingStepProvider));
    _pageController = PageController(initialPage: index < 0 ? 0 : index);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      unawaited(
        ref
            .read(onboardingControllerProvider.notifier)
            .handleAuthState(ref.read(appAuthStatusProvider)),
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _completeOnboarding() async {
    await ref.read(onboardingControllerProvider.notifier).complete();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingControllerProvider);

    final step = ref.watch(onboardingStepProvider);

    ref.listen<AppAuthState>(appAuthStatusProvider, (previous, next) {
      unawaited(
        ref.read(onboardingControllerProvider.notifier).handleAuthState(next),
      );
    });

    ref.listen<OnboardingStep>(onboardingStepProvider, (prev, next) {
      final index = ref.read(onboardingControllerProvider).steps.indexOf(next);
      if (index < 0 || !_pageController.hasClients) return;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
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
                physics: const NeverScrollableScrollPhysics(),
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
              child: _buildBottom(step),
            ),

            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildMain(OnboardingStep step) => switch (step) {
    OnboardingStep.welcome => const WelcomeForm(),
    OnboardingStep.auth => AuthForm(),
    OnboardingStep.register => RegisterForm(),
    OnboardingStep.ready => const ReadyForm(),
  };

  Widget _buildBottom(OnboardingStep step) => switch (step) {
    OnboardingStep.welcome => WelcomeFooter(
      onNext: () => ref.read(onboardingControllerProvider.notifier).start(),
    ),
    OnboardingStep.auth => const AuthFooter(),
    OnboardingStep.register => const RegisterFooter(),
    OnboardingStep.ready => ReadyFooter(
      onNext: () => ref.read(onboardingControllerProvider.notifier).complete(),
    ),
  };
}
