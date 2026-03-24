import 'package:danmalgi_mobile/core/generated/friend.pb.dart';

class FriendState {
  final List<Friend> friendList;
  final String? error;

  FriendState({required this.friendList, this.error});

  FriendState copyWith({List<Friend>? friendList, String? error}) {
    return FriendState(
      friendList: friendList ?? this.friendList,
      error: error ?? this.error,
    );
  }
}
