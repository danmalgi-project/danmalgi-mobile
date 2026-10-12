import 'package:danmalgi_mobile/core/extensions/string_extensions.dart';
import 'package:danmalgi_mobile/core/generated/user/v1/user.pb.dart' as pb;
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';

@freezed
sealed class UserProfile with _$UserProfile {
  const UserProfile._();

  const factory UserProfile({
    required int id,
    required String name,
    required String tag,
    String? imageUrl,
  }) = _UserProfile;

  factory UserProfile.fromSearchedUser(pb.SearchedUser proto) => UserProfile(
    id: proto.id.toInt(),
    name: proto.name,
    tag: proto.tag,
    imageUrl: proto.profileImageUrl.nullIfEmpty,
  );
}
