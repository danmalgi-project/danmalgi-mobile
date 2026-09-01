import 'package:danmalgi_mobile/features/auth/data/providers/auth_notifier.dart';
import 'package:danmalgi_mobile/features/user/presentation/providers/register_view_model.dart';
import 'package:danmalgi_mobile/features/user/presentation/widgets/register_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterView extends ConsumerWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(registerViewModelProvider);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const RegisterForm(),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () async => (state.isButtonEnabled)
                    ? await ref
                          .read(registerViewModelProvider.notifier)
                          .submit()
                    : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 19.0),

                  // backgroundColor: (registerViewModel(ref).isButtonEnabled)
                  //     ? Color(0xFF333333)
                  //     : Color(0xFFD9D9D9),
                  // shadowColor: Colors.transparent,
                ),
                child: const Text(
                  "가입하기",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    // color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: TextButton(
                onPressed: () async =>
                    await ref.read(authNotifierProvider.notifier).logout(),
                child: const Text(
                  "다른 계정으로 가입하기",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    // color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
