import 'package:fixnum/fixnum.dart';

class RoutePaths {
  // Init
  static const String splash = '/splash';

  // Home
  static const String home = '/';

  // Onboarding
  static const String onboarding = '/onboarding';

  // DirectMessage
  static const String directMessageChannelList = '/direct-message';

  // Profile
  static const String profile = '/profile';

  // Chat
  static const String chatTemplate = '/chat/:channelId';
  static String chat(Int64 channelId) => '/chat/$channelId';

  // Friend
  static const String friend = '/friend';
  static const String addFriend = '/friend/add';

  // Nested routes
  static const String userSettings = '/profile/settings';
  static const String userOrders = '/profile/orders';
}

class RouteNames {
  static const String splash = 'splash';
  static const String home = 'home';
  static const String onboarding = 'onboarding';
  static const String directMessageChannelList = 'direct-message-list';
  static const String profile = 'profile';
  static const String chat = 'chat';
  static const String friend = 'friend';
  static const String addFriend = 'friend-add';
  static const String productDetail = 'product-detail';
}
