import 'package:danmalgi_mobile/core/generated/user.pbenum.dart' as pb;
import 'package:danmalgi_mobile/features/user/domain/user_status.dart';

extension UserStatusMapper on pb.UserStatus {
  UserStatus fromProto() {
    switch (this) {
      case pb.UserStatus.USER_PENDING:
        return UserStatus.USER_PENDING;
      case pb.UserStatus.USER_ACTIVCE:
        return UserStatus.USER_ACTIVCE;
      case pb.UserStatus.USER_BLOCKED:
        return UserStatus.USER_BLOCKED;
      case pb.UserStatus.USER_WITHDRAWAL:
        return UserStatus.USER_WITHDRAWAL;
      default:
        return UserStatus.USER_PENDING;
    }
  }
}

extension DomainUserStatusMapper on UserStatus {
  pb.UserStatus toProto() {
    switch (this) {
      case UserStatus.USER_PENDING:
        return pb.UserStatus.USER_PENDING;
      case UserStatus.USER_ACTIVCE:
        return pb.UserStatus.USER_ACTIVCE;
      case UserStatus.USER_BLOCKED:
        return pb.UserStatus.USER_BLOCKED;
      case UserStatus.USER_WITHDRAWAL:
        return pb.UserStatus.USER_WITHDRAWAL;
    }
  }
}
