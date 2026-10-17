import 'package:danmalgi_mobile/debug/fake_direct_message.dart';
import 'package:danmalgi_mobile/debug/fake_friend.dart';
import 'package:danmalgi_mobile/features/directmessage/data/providers/direct_message_channel_repository_provider.dart';
import 'package:danmalgi_mobile/features/friend/presentation/providers/add_friend_view_model.dart';
import 'package:danmalgi_mobile/features/friend/presentation/providers/friend_view_model.dart';
import 'package:danmalgi_mobile/features/friend/presentation/providers/relationship_view_model.dart';

const kUseFakeData = bool.fromEnvironment('FAKE_DATA');

final fakeOverrides = [
  friendViewModelProvider.overrideWith(FakeFriendViewModel.new),
  relationshipViewModelProvider.overrideWith(FakeRelationshipViewModel.new),
  addFriendViewModelProvider.overrideWith(FakeAddFriendViewModel.new),
  directMessageChannelRepositoryProvider.overrideWith(
    (ref) => FakeDirectMessageChannelRepository(),
  ),
];
