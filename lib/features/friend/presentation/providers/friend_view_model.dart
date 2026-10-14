import 'package:danmalgi_mobile/core/generated/friend/v1/friend.pb.dart';
import 'package:danmalgi_mobile/core/providers/app_user_provider.dart';
import 'package:danmalgi_mobile/features/friend/data/providers/friend_providers.dart';
import 'package:danmalgi_mobile/features/friend/domain/friend_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'friend_view_model.g.dart';

@riverpod
class FriendViewModel extends _$FriendViewModel {
  @override
  FutureOr<FriendState> build() async {
    ref.watch(currentUserProvider); // Bind lifecycle to auth state

    final List<Friend> initialData = await ref
        .read(friendRepositoryProvider)
        .getFriendList();

    return FriendState(friendList: initialData);
  }
}
