import 'package:danmalgi_mobile/features/user/data/providers/user_provider.dart';
import 'package:danmalgi_mobile/features/user/domain/user_profile.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_friend_view_model.g.dart';

@riverpod
class AddFriendViewModel extends _$AddFriendViewModel {
  @override
  FutureOr<List<UserProfile>?> build() {
    return null;
  }

  Future<void> search(String query) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      final (name, tag) = parseNameTag(query);
      return ref
          .read(userRepositoryProvider)
          .searchedUser(name: name, tag: tag);
    });
  }

  (String, String) parseNameTag(String input) {
    final s = input.trim();
    final i = s.lastIndexOf('#');
    final name = i < 0 ? '' : input.substring(0, i).trim();
    final tag = i < 0 ? '' : input.substring(i + 1).trim();
    if (name.isEmpty || tag.isEmpty) {
      throw const FormatException('이름#태그 형식으로 입력해주세요.');
    }
    return (name, tag);
  }
}
