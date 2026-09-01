import 'dart:async';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:danmalgi_mobile/features/user/data/providers/user_notifier.dart';
import 'package:danmalgi_mobile/features/user/data/providers/user_provider.dart';
import 'package:danmalgi_mobile/features/user/domain/register_state.dart';

final registerViewModelProvider =
    NotifierProvider<RegisterViewModel, RegisterState>(RegisterViewModel.new);

// TODO: AsyncNotifer + AsyncValue.guard로 전환 예정
class RegisterViewModel extends Notifier<RegisterState> {
  final _random = Random();

  @override
  RegisterState build() => RegisterState();

  Future<void> submit() async {
    if (!state.isButtonEnabled) return;

    state = state.copyWith(isSubmitting: true, error: null, tagError: null);

    try {
      final exists = await ref
          .read(userRepositoryProvider)
          .verifyNamedAndTag(name: state.nickname!, tag: state.tag!);

      print("${state.nickname!}, ${state.tag!}");

      if (exists) {
        // TODO: 랜덤 TAG로 변경할 경우 필요 없도록 변경해야함
        state = RegisterState(
          isSubmitting: false,
          tagError: "*이미 가입되어 있는 코드입니다.",
        );
        return;
      }

      await ref
          .read(userNotifierProvider.notifier)
          .register(nickname: state.nickname!, tag: state.tag!);

      if (state.profileImage != null) {
        await ref
            .read(userNotifierProvider.notifier)
            .uploadProfileImage(bytes: state.profileImage!);
      }

      state = state.copyWith(isSubmitting: false);
    } catch (e) {
      state = state.copyWith(isSubmitting: false, error: '가입에 실패했습니다.');
      print(e);
    }
  }

  void onProfileImageChanged(Uint8List image) =>
      state = state.copyWith(profileImage: image);

  void onNicknameChanged(String nickname) =>
      state = state.copyWith(nickname: nickname, nicknameError: null);

  void onTagChanged() => state = state.copyWith(
    tag: _random.nextInt(10000).toString().padLeft(4, '0'),
    tagError: null,
  );
}
