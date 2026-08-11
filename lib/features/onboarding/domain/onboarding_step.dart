enum OnboardingStep { welcome, auth, nickname, profile, ready }

const commonSteps = [OnboardingStep.welcome, OnboardingStep.auth];

const newUserSteps = [
  OnboardingStep.welcome,
  OnboardingStep.auth,
  OnboardingStep.nickname,
  OnboardingStep.profile,
  OnboardingStep.ready,
];
