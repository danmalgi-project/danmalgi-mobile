import 'package:danmalgi_mobile/features/auth/presentation/providers/login_view_model.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:danmalgi_mobile/features/user/domain/oauth_type.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginViewModelProvider);
    final isLoading = state.isLoading;

    return Stack(
      children: [
        Scaffold(
          body: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: 256,
                    height: 256,
                    child: Center(
                      child: Text(
                        "단말기 아이콘",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 24.0),
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20.0,
                    bottom: 88.0,
                    right: 20.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () async {
                                // TODO: 기존 데이터가 남아있을 때 로그인을 실패하는 경우가 발생할 수 있을 것 같은데 이는 어떻게 해결할지
                                await ref
                                    .read(loginViewModelProvider.notifier)
                                    .login(oAuthType: OAuthType.GOOGLE);
                              },
                        child: Text("구글 로그인"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.3), // 화면을 반투명하게 덮음
            child: const Center(
              child: CircularProgressIndicator(), // 정중앙 스피너
            ),
          ),
      ],
    );
  }
}
