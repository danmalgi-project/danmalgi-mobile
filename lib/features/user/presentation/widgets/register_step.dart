import 'package:danmalgi_mobile/core/theme/app_colors.dart';
import 'package:danmalgi_mobile/core/theme/app_dimens.dart';
import 'package:danmalgi_mobile/core/theme/app_typography.dart';
import 'package:danmalgi_mobile/core/widgets/rounded_text_field.dart';
import 'package:danmalgi_mobile/features/auth/data/providers/auth_notifier.dart';
import 'package:danmalgi_mobile/features/onboarding/presentation/providers/onboarding_controller.dart';
import 'package:danmalgi_mobile/features/onboarding/presentation/widgets/onboarding_main_layout.dart';
import 'package:danmalgi_mobile/features/onboarding/presentation/widgets/onboarding_primary_button.dart';
import 'package:danmalgi_mobile/features/user/presentation/providers/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class RegisterForm extends ConsumerStatefulWidget {
  const RegisterForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  final _nicknameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(registerViewModelProvider);
    return Padding(
      padding: EdgeInsets.only(top: 36),
      child: OnboardingMainFrame(
        title: '회원가입',
        description: '친구들이 이 이름으로 나를 찾을 수 있어요',
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                width: 80,
                height: 80,
                child: Material(
                  color: AppColors.surfaceInput,
                  shape: CircleBorder(),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () async {
                      final picker = ImagePicker();
                      final image = await picker.pickImage(
                        source: ImageSource.gallery,
                      );
                      if (image == null) return;
                      final bytes = await image.readAsBytes();
                      ref
                          .read(registerViewModelProvider.notifier)
                          .onProfileImageChanged(bytes);
                    },
                    child: state.profileImage != null
                        ? CircleAvatar(
                            radius: 40,
                            child: Image.memory(state.profileImage!),
                          )
                        : Icon(
                            Icons.add_rounded,
                            color: AppColors.surfaceInverse,
                          ),
                  ),
                ),
              ),
            ),
            SizedBox(height: AppSpacing.s24),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.xl),
                color: AppColors.accent,
              ),
              padding: EdgeInsets.all(AppSpacing.s24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RoundedTextField(
                    controller: _nicknameController,
                    onChanged: (value) {
                      ref
                          .read(registerViewModelProvider.notifier)
                          .onNicknameChanged(value);
                      ref
                          .read(registerViewModelProvider.notifier)
                          .onTagChanged();
                    },
                    contentPadding: EdgeInsets.symmetric(
                      vertical: AppSpacing.s16,
                      horizontal: AppSpacing.s12,
                    ),
                    hintText: "닉네임을 입력해주세요",
                    errorText: state.nicknameError,
                  ),
                  SizedBox(height: AppSpacing.s16),
                  if (state.hasNickname) ...[
                    RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: [
                          TextSpan(
                            text: state.displayNickname,
                            style: AppTypography.titleSm.copyWith(
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: " #${state.tag}",
                            style: AppTypography.titleSm.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: AppSpacing.s8),
                  ],
                  Text(
                    "코드는 자동으로 생성됩니다",
                    style: AppTypography.caption.copyWith(color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSpacing.s24),
            Text(
              "친구 추가는 닉네임#코드로 검색해서 요청할 수 있어요\n예시: 피그마#1111",
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterFooter extends ConsumerWidget {
  const RegisterFooter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(registerViewModelProvider);

    return OnboardingPrimaryButton(
      label: '가입하기',
      isLoading: state.isSubmitting,
      onPressed: state.isButtonEnabled
          ? () => ref.read(registerViewModelProvider.notifier).submit()
          : null,
    );
  }
}
