import 'package:danmalgi_mobile/core/domain/app_auth_state.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:danmalgi_mobile/core/providers/app_auth_status_provider.dart';
import 'package:danmalgi_mobile/core/providers/logger_provider.dart';
import 'package:danmalgi_mobile/core/providers/notification_provider.dart';
import 'package:danmalgi_mobile/core/router/route_paths.dart';
import 'package:danmalgi_mobile/core/widgets/splash_view.dart';
import 'package:danmalgi_mobile/features/auth/presentation/views/login_view.dart';
import 'package:danmalgi_mobile/features/auth/presentation/views/logout_view.dart';
import 'package:danmalgi_mobile/features/directmessage/presentation/views/direct_message_channel_list_view.dart';
import 'package:danmalgi_mobile/features/directmessage/presentation/views/direct_message_channel_view.dart';
import 'package:danmalgi_mobile/features/friend/presentation/views/add_relationship_view.dart';
import 'package:danmalgi_mobile/features/friend/presentation/views/friend_view.dart';
import 'package:danmalgi_mobile/features/home/presentation/views/home_view.dart';
import 'package:danmalgi_mobile/features/home/presentation/widgets/scaffold_with_nav_bar.dart';
import 'package:danmalgi_mobile/features/user/presentation/views/register_view.dart';

final routerProvider = Provider.autoDispose<GoRouter>((ref) {
  final routerKey = GlobalKey<NavigatorState>(debugLabel: 'routerKey');

  final listenable = ValueNotifier<AppAuthState>(AppAuthState.loading());
  ref.onDispose(listenable.dispose);

  final logger = ref.watch(appLoggerServiceProvider);
  ref.listen(appAuthStatusProvider, (previous, next) async {
    logger.d('🔄 Auth state change: $previous → $next');
    if (previous != next) {
      listenable.value = next;
    } else {
      logger.d('🚫 Skipping ValueNotifier update (same state type)');
    }
  });

  return GoRouter(
    navigatorKey: routerKey,
    initialLocation: RoutePaths.splash,
    refreshListenable: listenable,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: RoutePaths.splash,
        name: RouteNames.splash,
        builder: (context, state) => SplashView(),
      ),
      GoRoute(
        path: RoutePaths.login,
        name: RouteNames.login,
        builder: (context, state) => LoginView(),
      ),
      GoRoute(
        path: RoutePaths.register,
        name: RouteNames.register,
        builder: (context, state) => RegisterView(),
      ),
      GoRoute(
        path: RoutePaths.directMessageChannelDetailTemplate,
        name: RouteNames.directMessageChannelDetail,
        builder: (context, state) {
          final channelId = int.parse(state.pathParameters['channelId']!);
          return DirectMessageChannelView(channelId: channelId);
        },
      ),
      GoRoute(
        path: RoutePaths.addFriend,
        name: RouteNames.addFriend,
        builder: (context, state) => AddRelationshipView(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            ScaffoldWithNavBar(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            // 채널 전환 과정에서 refresh를 진행하기 때문에 미리 생성되어 있어야함
            preload: true,
            routes: [
              GoRoute(
                path: RoutePaths.directMessageChannelList,
                name: RouteNames.directMessageChannelList,
                builder: (context, state) => DirectMessageChannelListView(),
              ),
            ],
          ),
          // StatefulShellBranch(
          //   // 채널 전환 과정에서 refresh를 진행하기 때문에 미리 생성되어 있어야함
          //   preload: true,
          //   routes: [
          //     GoRoute(
          //       path: RoutePaths.home,
          //       name: RouteNames.home,
          //       builder: (context, state) {
          //         return HomePage();
          //       },
          //     ),
          //   ],
          // ),
          StatefulShellBranch(
            // 채널 전환 과정에서 refresh를 진행하기 때문에 미리 생성되어 있어야함
            preload: true,
            routes: [
              GoRoute(
                path: RoutePaths.friend,
                name: RouteNames.friend,
                builder: (context, state) => FriendView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.logout,
                name: RouteNames.logout,
                builder: (context, state) => LogoutView(),
              ),
            ],
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final currentPath = state.uri.path;
      final appAuthState = listenable.value;

      final bool isAuthPage =
          currentPath == RoutePaths.login ||
          currentPath == RoutePaths.register ||
          currentPath == RoutePaths.splash;

      return appAuthState.when(
        loading: () {
          // 초기 판정 중에는 splash에 머무르게
          return currentPath == RoutePaths.splash ? null : RoutePaths.splash;
        },
        bootstrapping: () {
          // 토큰은 있는데 user 복구 중 → splash(또는 별도 “복구중” 페이지) 유지
          return currentPath == RoutePaths.splash ? null : RoutePaths.splash;
        },
        unauthenticated: () {
          // 로그인 화면만 허용
          return currentPath == RoutePaths.login ? null : RoutePaths.login;
        },
        needsRegistration: () {
          // 가입 완료 페이지로 강제
          return currentPath == RoutePaths.register
              ? null
              : RoutePaths.register;
        },
        authenticated: (user) {
          // 이미 인증됐는데 auth 페이지에 있으면 메인으로 보냄
          if (isAuthPage) return RoutePaths.directMessageChannelList;
          return null;
        },
        blocked: () {
          return currentPath == RoutePaths.login ? null : RoutePaths.login;
        },
        withdrawn: () {
          return currentPath == RoutePaths.login ? null : RoutePaths.login;
        },
        error: (error, canRetry) {
          return currentPath == RoutePaths.login ? null : RoutePaths.login;
        },
      );
    },
  );
});
