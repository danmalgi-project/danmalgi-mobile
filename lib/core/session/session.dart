import 'package:danmalgi_mobile/features/user/domain/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'session.freezed.dart';

@freezed
sealed class Session with _$Session {
  const Session._();

  const factory Session.anonymous() = Anonymous;
  const factory Session.pending({required String token}) = Pending;
  const factory Session.registered({
    required String token,
    required User user,
  }) = Registered;

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
