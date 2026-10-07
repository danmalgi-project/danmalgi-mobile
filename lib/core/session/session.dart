import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:danmalgi_mobile/features/user/domain/user.dart';

part 'session.freezed.dart';

typedef AuthResult = ({User user, String accessToken});

@freezed
sealed class Session with _$Session {
  const Session._();

  const factory Session.anonymous() = Anonymous;
  const factory Session.pending() = Pending;
  const factory Session.registered({required User user}) = Registered;

  String? get token => switch (this) {
    Anonymous() => null,
    Pending(:final token) => token,
    Registered(:final token) => token,
  };

  User? get user => switch (this) {
    Registered(:final user) => user,
    _ => null,
  };
}
