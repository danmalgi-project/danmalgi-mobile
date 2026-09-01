import 'package:danmalgi_mobile/core/domain/app_auth_state.dart';
import 'package:danmalgi_mobile/core/router/root_navigator_key_provider.dart';
import 'package:danmalgi_mobile/core/router/router_refresh_notifier.dart';
import 'package:danmalgi_mobile/features/chat/presentation/views/chat_view.dart';
import 'package:danmalgi_mobile/features/onboarding/presentation/providers/onboarding_controller.dart';
import 'package:danmalgi_mobile/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:danmalgi_mobile/core/providers/app_auth_status_provider.dart';
import 'package:danmalgi_mobile/core/providers/logger_provider.dart';
import 'package:danmalgi_mobile/core/router/route_paths.dart';
import 'package:danmalgi_mobile/core/widgets/splash_view.dart';
import 'package:danmalgi_mobile/features/auth/presentation/views/logout_view.dart';
import 'package:danmalgi_mobile/features/directmessage/presentation/views/direct_message_channel_list_view.dart';
import 'package:danmalgi_mobile/features/friend/presentation/views/add_relationship_view.dart';
import 'package:danmalgi_mobile/features/friend/presentation/views/friend_view.dart';
import 'package:danmalgi_mobile/features/home/presentation/views/home_view.dart';
import 'package:danmalgi_mobile/features/home/presentation/widgets/scaffold_with_nav_bar.dart';
import 'package:danmalgi_mobile/features/user/presentation/views/register_view.dart';

enum _Zone { splash, onboarding, main }

final routerProvider = Provider<GoRouter>((ref) {
  final routerKey = ref.watch(rootNavigatorKeyProvider);

  final refresh = RouterRefreshNotifier(ref, [
    appAuthStatusProvider,
    onboardingControllerProvider.select((s) => s.isCompleted),
  ]);

  ref.onDispose(refresh.dispose);

  AppAuthState lastStableState = const AppAuthState.loading();

  return GoRouter(
    navigatorKey: routerKey,
    initialLocation: RoutePaths.splash,
    refreshListenable: refresh,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: RoutePaths.splash,
        name: RouteNames.splash,
        builder: (context, state) => SplashView(),
      ),
      GoRoute(
        path: RoutePaths.onboarding,
        name: RouteNames.onboarding,
        builder: (context, state) => OnboardingView(),
      ),
      GoRoute(
        path: RoutePaths.chatTemplate,
        name: RouteNames.chat,
        builder: (context, state) {
          final channelId = int.parse(state.pathParameters['channelId']!);
          return ChatView(channelId: channelId);
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
                path: RoutePaths.home,
                name: RouteNames.home,
                builder: (context, state) {
                  return HomeView();
                },
              ),
            ],
          ),
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
      final authState = ref.read(appAuthStatusProvider);
      final onboardingDone = ref.read(onboardingControllerProvider).isCompleted;

      final bool isTransient = authState.maybeWhen(
        loading: () => true,
        bootstrapping: () => true,
        orElse: () => false,
      );
      if (!isTransient) lastStableState = authState;
      final effective = isTransient ? lastStableState : authState;

      final zone = effective.when(
        loading: () => _Zone.splash,
        bootstrapping: () => _Zone.splash,
        unauthenticated: () => _Zone.onboarding,
        needsRegistration: () => _Zone.onboarding,
        authenticated: (_) => onboardingDone ? _Zone.main : _Zone.onboarding,
        blocked: () => _Zone.onboarding,
        withdrawn: () => _Zone.onboarding,
        error: (_, __) => _Zone.onboarding,
      );

      final bool isOutsideMain =
          currentPath == RoutePaths.onboarding ||
          currentPath == RoutePaths.splash;

      return switch (zone) {
        _Zone.splash =>
          currentPath == RoutePaths.splash ? null : RoutePaths.splash,
        _Zone.onboarding =>
          currentPath == RoutePaths.onboarding ? null : RoutePaths.onboarding,
        _Zone.main => isOutsideMain ? RoutePaths.home : null,
      };
    },
  );
});
