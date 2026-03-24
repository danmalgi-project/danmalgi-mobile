import 'package:fixnum/fixnum.dart';

class RoutePaths {
  // Init
  static const String splash = '/splash';

  // Home
  static const String home = '/';

  // Auth
  static const String login = '/login';
  static const String logout = '/logout';
  static const String register = '/register';

  // DirectMessage
  static const String directMessageChannelList = '/direct-message';
  static const String directMessageChannelDetailTemplate =
      '/direct-message/:channelId';
  static String directMessageChannelDetail(Int64 channelId) =>
      '/direct-message/$channelId';

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
  static const String login = 'login';
  static const String logout = 'logout';
  static const String register = 'register';
  static const String directMessageChannelList = 'direct-message-list';
  static const String directMessageChannelDetail = 'direct-message-detail';
  static const String friend = 'friend';
  static const String addFriend = 'friend-add';
  static const String productDetail = 'product-detail';
}
