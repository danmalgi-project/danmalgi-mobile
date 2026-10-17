import 'package:danmalgi_mobile/core/extensions/string_extensions.dart';
import 'package:danmalgi_mobile/core/generated/dm/v1/dm.pb.dart';
import 'package:danmalgi_mobile/core/theme/app_colors.dart';
import 'package:danmalgi_mobile/core/theme/app_dimens.dart';
import 'package:danmalgi_mobile/core/widgets/cached_circle_avatar.dart';
import 'package:danmalgi_mobile/features/directmessage/domain/direct_message_channel_x.dart';
import 'package:flutter/material.dart';

class DirectMessageChannelAvatar extends StatelessWidget {
  final DirectMessageChannel channel;
  final int? myId;

  final double radius;
  final Color ringColor;

  const DirectMessageChannelAvatar({
    super.key,
    required this.channel,
    this.myId,
    this.radius = AppAvatarSize.md,
    this.ringColor = AppColors.surfacePrimary,
  });

  @override
  Widget build(BuildContext context) {
    final members = channel.membersExcept(myId);
    return switch (channel.type) {
      DirectMessageType.group
          when channel.channelImageUrl.nullIfEmpty == null &&
              members.length >= 2 =>
        _AvatarStack(
          back: (
            url: members.first.profileImageUrl,
            seed: members.first.id.toInt(),
          ),
          front: (
            url: members.last.profileImageUrl,
            seed: members.last.id.toInt(),
          ),
          radius: radius,
          ringColor: ringColor,
        ),
      DirectMessageType.group => CachedCircleAvatar(
        url: channel.channelImageUrl,
        seed: channel.dmId.toInt(),
        radius: radius,
      ),
      DirectMessageType.direct => CachedCircleAvatar(
        url: members.firstOrNull?.profileImageUrl,
        seed: members.firstOrNull?.id.toInt(),
        radius: radius,
      ),
    };
  }
}

typedef _AvatarSource = ({String? url, int? seed});

class _AvatarStack extends StatelessWidget {
  final _AvatarSource back;
  final _AvatarSource front;
  final double radius;
  final Color ringColor;

  const _AvatarStack({
    required this.back,
    required this.front,
    required this.radius,
    required this.ringColor,
  });

  static const _innerRatio = 32 / 48;
  static const _ringRatio = 2 / 48;

  @override
  Widget build(BuildContext context) {
    final size = radius * 2;
    final innerRadius = radius * _innerRatio;
    final ring = size * _ringRatio;

    return SizedBox.square(
      dimension: size,
      child: Stack(
        fit: StackFit.loose,
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: CachedCircleAvatar(
              url: back.url,
              seed: back.seed,
              radius: innerRadius,
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ringColor,
              ),
              child: Padding(
                padding: EdgeInsets.all(ring),
                child: CachedCircleAvatar(
                  url: front.url,
                  seed: front.seed,
                  radius: innerRadius,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
