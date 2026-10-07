import 'dart:async';
import 'dart:math';

import 'package:danmalgi_mobile/core/session/session_notifier.dart';
import 'package:danmalgi_mobile/features/user/data/providers/user_provider.dart';
import 'package:danmalgi_mobile/features/user/domain/register_state.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_view_model.g.dart';

@riverpod
class RegisterViewModel extends _$RegisterViewModel {
  final _random = Random();

  @override
  RegisterState build() => RegisterState();

  Future<void> submit() async {
    if (!state.isButtonEnabled) return;

    state = state.copyWith(isSubmitting: true, error: null, tagError: null);

    // signIn이 세션을 바꾸면 라우터가 이 화면을 떠나면서 provider가 dispose되므로,
    // await 이후에는 ref를 쓰지 않도록 필요한 의존성을 미리 잡아둔다.
    final userRepository = ref.read(userRepositoryProvider);
    final session = ref.read(sessionProvider.notifier);
    final profileImage = state.profileImage;

    try {
      final exists = await userRepository.verifyNamedAndTag(
        name: state.nickname!,
        tag: state.tag,
      );

      if (exists) {
        if (!ref.mounted) return;
        // TODO: 랜덤 TAG로 변경할 경우 필요 없도록 변경해야함
        state = RegisterState(
          isSubmitting: false,
          tagError: "*이미 가입되어 있는 코드입니다.",
        );
        return;
      }

      final result = await userRepository.register(
        nickname: state.nickname!,
        tag: state.tag,
      );
      await session.signIn(result);

      if (profileImage != null) {
        final user = await userRepository.uploadProfileImage(
          bytes: profileImage,
        );
        await session.updateUser(user);
      }

      if (!ref.mounted) return;
      state = state.copyWith(isSubmitting: false);
    } catch (e) {
      print(e);
      if (!ref.mounted) return;
      state = state.copyWith(isSubmitting: false, error: '가입에 실패했습니다.');
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
