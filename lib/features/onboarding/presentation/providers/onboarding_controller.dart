import 'package:danmalgi_mobile/core/domain/app_auth_state.dart';
import 'package:danmalgi_mobile/core/providers/storage_provider.dart';
import 'package:danmalgi_mobile/core/services/local_storage_service.dart';
import 'package:danmalgi_mobile/features/onboarding/domain/onboarding_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_controller.g.dart';

@riverpod
class OnboardingController extends _$OnboardingController {
  static const int currentOnboardingVersion = 1;

  LocalStorageService get _storage => ref.read(localStorageServiceProvider);

  @override
  OnboardingState build() {
    final savedVersion = _storage.onBoardingVersion ?? 0;
    final isNewUserFLow = _storage.isNewUserFlow ?? false;

    return OnboardingState(
      isCompleted: savedVersion >= currentOnboardingVersion,
      isNewUserFlow: isNewUserFLow,
    );
  }

  Future<void> handleAuthState(AppAuthState authState) async {
    await authState.maybeWhen(
      needsRegistration: () async {
        await startNewUserFlow();
      },
      authenticated: (_) async {
        // 신규 사용자는 회원가입 이후에도 추가 설정이 남아 있으므로
        // 여기에서 바로 완료시키지 않습니다.
        if (!state.isNewUserFlow) {
          await complete();
        }
      },
      orElse: () async {},
    );
  }

  Future<void> startNewUserFlow() async {
    if (state.isNewUserFlow) return;

    state = state.copyWith(isNewUserFlow: true, errorMessage: null);

    try {
      await _storage.setNewUserFlow(true);
    } catch (error) {
      state = state.copyWith(errorMessage: '온보딩 진행 상태를 저장하지 못했습니다.');
    }
  }

  Future<void> complete() async {
    if (state.isCompleted || state.isSaving) return;

    state = state.copyWith(isSaving: true, errorMessage: null);

    try {
      await _storage.setOnBoardingVersion(currentOnboardingVersion);

      await _storage.setNewUserFlow(false);

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
