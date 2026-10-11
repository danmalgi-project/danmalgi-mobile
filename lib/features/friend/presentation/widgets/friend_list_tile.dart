import 'package:danmalgi_mobile/core/generated/friend/v1/friend.pb.dart';
import 'package:danmalgi_mobile/core/theme/app_dimens.dart';
import 'package:danmalgi_mobile/core/widgets/cached_circle_avatar.dart';
import 'package:danmalgi_mobile/features/friend/presentation/widgets/name_with_tag.dart';
import 'package:danmalgi_mobile/features/user/domain/user.dart';
import 'package:flutter/material.dart';

class FriendListTile extends StatelessWidget {
  final Friend friend;
  final VoidCallback onTap;

  const FriendListTile({super.key, required this.friend, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final user = User.fromProto(friend.user);

    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.brMd,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.s12),
        child: Row(
          spacing: AppSpacing.s12,
          children: [
            CachedCircleAvatar(radius: 24, url: user.imageUrl),
            Expanded(child: NameWithTag(user: user)),
          ],
        ),
      ),
    );
  }
}
