import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:danmalgi_mobile/features/user/data/providers/user_notifier.dart';
import 'package:danmalgi_mobile/features/user/data/providers/user_provider.dart';
import 'package:danmalgi_mobile/features/user/domain/register_state.dart';

final registerViewModelProvider =
    NotifierProvider<RegisterViewModel, RegisterState>(RegisterViewModel.new);

// TODO: AsyncNotifer + AsyncValue.guard로 전환 예정
class RegisterViewModel extends Notifier<RegisterState> {
  @override
  RegisterState build() => RegisterState();

  Future<void> submit() async {
    try {
      if (!state.isButtonEnabled) return;
      final exists = await ref
          .read(userRepositoryProvider)
          .verifyNamedAndTag(name: state.nickname!, tag: state.tag!);

      print("${state.nickname!}, ${state.tag!}");

      if (exists) {
        state = RegisterState(tagError: "*이미 가입되어 있는 코드입니다.");
      } else {
        print("중복 없음 회원가입 진행");
        await ref
            .read(userNotifierProvider.notifier)
            .register(nickname: state.nickname!, tag: state.tag!);
      }
    } catch (e) {
      print(e);
    }
  }

  void onNicknameChanged(String nickname) =>
      state = state.copyWith(nickname: nickname, nicknameError: null);
  void onTagChanged(String tag) =>
      state = state.copyWith(tag: tag, tagError: null);
}
