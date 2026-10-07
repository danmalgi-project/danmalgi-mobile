import 'package:danmalgi_mobile/core/session/app_auth_state.dart';
import 'package:danmalgi_mobile/core/session/app_auth_status_provider.dart';
import 'package:danmalgi_mobile/core/storage/pref_key.dart';
import 'package:danmalgi_mobile/core/storage/pref_store.dart';
import 'package:danmalgi_mobile/core/storage/storage_providers.dart';
import 'package:danmalgi_mobile/features/onboarding/domain/onboarding_state.dart';
import 'package:danmalgi_mobile/features/onboarding/domain/onboarding_step.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_controller.g.dart';

final _onboardingVersionKey = PrefKey.integer('onboardingVersion');

@riverpod
class OnboardingController extends _$OnboardingController {
  static const int currentOnboardingVersion = 1;

  PrefStore get _prefs => ref.read(devicePrefsProvider);

  @override
  OnboardingState build() {
    final savedVersion = ref
        .watch(devicePrefsProvider)
        .get(_onboardingVersionKey);

    return OnboardingState(
      isCompleted: savedVersion >= currentOnboardingVersion,
    );
  }

  void start() {
    if (state.hasStarted) return;
    state = state.copyWith(hasStarted: true);
  }

  Future<void> handleAuthState(AppAuthState authState) async {
    await authState.maybeWhen(
      needsRegistration: () async => startNewUserFlow(),
      unauthenticated: () async =>
          state = state.copyWith(isNewUserFlow: false, hasStarted: false),
      authenticated: (_) async {
        if (!state.isNewUserFlow) {
          await complete();
        }
      },
      orElse: () async {},
    );
  }

  void startNewUserFlow() {
    if (state.isNewUserFlow) return;
    state = state.copyWith(isNewUserFlow: true);
  }

  Future<void> complete() async {
    if (state.isCompleted || state.isSaving) return;

    state = state.copyWith(isSaving: true, errorMessage: null);

    try {
      await _prefs.set(_onboardingVersionKey, currentOnboardingVersion);

      state = state.copyWith(
        isCompleted: true,
        isNewUserFlow: false,
        isSaving: false,
      );
    } catch (error) {
      state = state.copyWith(
        isSaving: false,
        errorMessage: '온보딩 완료 상태를 저장하지 못했습니다.',
      );
    }
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

final onboardingStepProvider = Provider<OnboardingStep>((ref) {
  final auth = ref.watch(appAuthStatusProvider);
  final onboarding = ref.watch(onboardingControllerProvider);

  if (!onboarding.hasStarted) return OnboardingStep.welcome;

  return auth.maybeWhen(
    needsRegistration: () => OnboardingStep.register,
    authenticated: (_) => OnboardingStep.ready,
    orElse: () => OnboardingStep.auth,
  );
});
