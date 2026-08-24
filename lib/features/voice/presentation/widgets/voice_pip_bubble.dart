import 'package:danmalgi_mobile/core/providers/app_user_provider.dart';
import 'package:danmalgi_mobile/core/widgets/cached_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VoicePipBubble extends ConsumerWidget {
  const VoicePipBubble({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    return Container(
      color: const Color(0xFF1C1C1E),
      child: Center(
        child: CachedCircleAvatar(
          url: currentUser?.imageUrl,
          radius: 36.0,
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
