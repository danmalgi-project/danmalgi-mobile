import 'package:danmalgi_mobile/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class OnboardingPrimaryButton extends StatelessWidget {
  final String label;
  final bool isLoading;
  final void Function()? onPressed;

  const OnboardingPrimaryButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: AppColors.onAccent,
          disabledBackgroundColor: AppColors.surfacePrimary,
          disabledForegroundColor: AppColors.surfaceInverse,
          // textStyle: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
          shape: StadiumBorder(),
        ),
        child: isLoading ? const CircularProgressIndicator() : Text(label),
      ),
    );
  }
}
