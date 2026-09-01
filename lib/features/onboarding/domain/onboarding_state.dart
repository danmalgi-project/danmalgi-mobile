import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:danmalgi_mobile/features/onboarding/domain/onboarding_step.dart';

part 'onboarding_state.freezed.dart';

@freezed
abstract class OnboardingState with _$OnboardingState {
  const OnboardingState._();

  const factory OnboardingState({
    @Default(false) bool hasStarted,
    @Default(false) bool isNewUserFlow,
    @Default(false) bool isCompleted,
    @Default(false) bool isSaving,
    String? errorMessage,
  }) = _OnboardingState;

  List<OnboardingStep> get steps => [
    OnboardingStep.welcome,
    OnboardingStep.auth,

    if (isNewUserFlow) ...[OnboardingStep.register, OnboardingStep.ready],
  ];
}
