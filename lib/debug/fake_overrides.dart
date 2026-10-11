import 'package:danmalgi_mobile/debug/fake_friend.dart';
import 'package:danmalgi_mobile/features/friend/presentation/providers/friend_view_model.dart';
import 'package:danmalgi_mobile/features/friend/presentation/providers/relationship_view_model.dart';

const kUseFakeData = bool.fromEnvironment('FAKE_DATA');

final fakeOverrides = [
  friendViewModelProvider.overrideWith(FakeFriendViewModel.new),
  relationshipViewModelProvider.overrideWith(FakeRelationshipViewModel.new),
];
