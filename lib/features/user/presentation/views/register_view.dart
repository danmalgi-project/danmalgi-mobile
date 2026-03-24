import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:danmalgi_mobile/core/widgets/rounded_text_field.dart';
import 'package:danmalgi_mobile/features/user/domain/register_state.dart';
import 'package:danmalgi_mobile/features/user/presentation/providers/register_view_model.dart';

mixin class RegisterViewState {
  RegisterState registerViewModel(WidgetRef ref) =>
      ref.watch(registerViewModelProvider);
}

mixin class RegisterViewEvent {
  Future<void> submit(WidgetRef ref) async {
    await ref.read(registerViewModelProvider.notifier).submit();
  }
}

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView>
    with RegisterViewState, RegisterViewEvent {
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();

  @override
  void dispose() {
    _nicknameController.dispose();
    _tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 61.h),
                Padding(
                  padding: EdgeInsets.only(left: 8.w),
                  child: Text(
                    "필수정보를\n입력해주세요",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.sp,
                      letterSpacing: -0.25,
                      height: 1.4,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
                Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Text(
                    "닉네임",
                    style: TextStyle(
                      color: Color(0xFF565656),
                      fontSize: 16.sp,
                      letterSpacing: -0.25,
                      height: 1.4,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                RoundedTextField(
                  controller: _nicknameController,
                  onChanged: (value) => ref
                      .read(registerViewModelProvider.notifier)
                      .onNicknameChanged(value),
                  hintText: "닉네임을 입력해주세요",
                  errorText: registerViewModel(ref).nicknameError,
                ),
                SizedBox(height: 24.h),
                Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Text(
                    "태그",
                    style: TextStyle(color: Color(0xFF565656), fontSize: 16.sp),
                  ),
                ),
                SizedBox(height: 12.h),
                RoundedTextField(
                  controller: _tagController,
                  onChanged: (value) => ref
                      .read(registerViewModelProvider.notifier)
                      .onTagChanged(value),
                  hintText: "코드를 입력해주세요",
                  errorText: registerViewModel(ref).tagError,
                ),
                SizedBox(height: 47.h),
                Container(
                  child: (registerViewModel(ref).hasNameTag)
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 2.w),
                              child: Text(
                                "실제로는 이렇게 보여요",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: -0.25,
                                  height: 1.4,
                                ),
                              ),
                            ),
                            SizedBox(height: 14.h),
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 20.h,
                                horizontal: 32.w,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFF333333),
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.lightGreen,
                                  ),
                                  SizedBox(width: 8.w),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${registerViewModel(ref).nickname}#${registerViewModel(ref).tag}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "단말기에 오신걸 환영합니다",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : SizedBox(),
                ),
                Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 60.h,
                  child: ElevatedButton(
                    onPressed: () async =>
                        (registerViewModel(ref).isButtonEnabled)
                        ? await submit(ref)
                        : null,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 19.0),
                      backgroundColor: (registerViewModel(ref).isButtonEnabled)
                          ? Color(0xFF333333)
                          : Color(0xFFD9D9D9),
                      shadowColor: Colors.transparent,
                    ),
                    child: Text(
                      "가입하기",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
