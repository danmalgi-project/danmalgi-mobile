import 'package:danmalgi_mobile/core/router/root_navigator_key_provider.dart';
import 'package:danmalgi_mobile/features/voice/data/providers/active_voice_session_provider.dart';
import 'package:danmalgi_mobile/features/voice/presentation/providers/voice_call_animation_provider.dart';
import 'package:danmalgi_mobile/features/voice/presentation/views/voice_call_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VoiceCallRoute extends PageRoute<void> {
  final int channelId;

  VoiceCallRoute({required this.channelId});

  @override
  bool get opaque => false;
  @override
  bool get maintainState => true;
  @override
  Color? get barrierColor => null;
  @override
  String? get barrierLabel => null;
  @override
  Duration get transitionDuration => const Duration(milliseconds: 280);

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) => VoiceCallView(channelId: channelId);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) => child;
}

void openVoiceCall(WidgetRef ref, int channelId) {
  final navigator = ref.read(rootNavigatorKeyProvider).currentState;
  if (navigator == null) return;

  ref.read(activeVoiceSessionProvider.notifier).start(channelId);

  final container = ProviderScope.containerOf(navigator.context, listen: false);
  if (container.read(voiceCallAnimationProvider) != null) return;

  final route = VoiceCallRoute(channelId: channelId);
  navigator.push(route);
  container.read(voiceCallAnimationProvider.notifier).update(route.animation);

  route.completed.whenComplete(() {
    if (container.read(voiceCallAnimationProvider) == route.animation) {
      container.read(voiceCallAnimationProvider.notifier).update(null);
    }
  });
}
