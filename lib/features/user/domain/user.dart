import 'package:danmalgi_mobile/features/user/data/extensions/user_status_mapper.dart';
import 'package:danmalgi_mobile/features/user/domain/user_status.dart';
import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:danmalgi_mobile/core/generated/user.pb.dart' as pb;
import 'package:danmalgi_mobile/features/user/data/extensions/oauth_type_mapper.dart';
import 'package:danmalgi_mobile/features/user/domain/oauth_type.dart';

part 'user.freezed.dart';

@freezed
sealed class User with _$User {
  const factory User({
    required int id,
    required String email,
    required String name,
    required String tag,
    OAuthType? oauthType,
    UserStatus? status,
    DateTime? lastLoginTime,
  }) = _User;

  factory User.fromProto(pb.User proto) {
    return User(
      id: proto.id.toInt(),
      email: proto.email,
      name: proto.name,
      tag: proto.tag,
      oauthType: proto.oauthType.fromProto(),
      status: proto.status.fromProto(),
      lastLoginTime: null,
    );
  }
}
