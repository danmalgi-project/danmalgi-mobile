import 'package:danmalgi_mobile/core/generated/user/v1/user.pbenum.dart' as pb;
import 'package:danmalgi_mobile/features/user/domain/user_status.dart';

extension UserStatusMapper on pb.UserStatus {
  UserStatus fromProto() {
    switch (this) {
      case pb.UserStatus.USER_PENDING:
        return UserStatus.PENDING;
      case pb.UserStatus.USER_ACTIVE:
        return UserStatus.ACTIVE;
      case pb.UserStatus.USER_BLOCKED:
        return UserStatus.BLOCKED;
      case pb.UserStatus.USER_WITHDRAWAL:
        return UserStatus.WITHDRAWAL;
      default:
        return UserStatus.PENDING;
    }
  }
}

extension DomainUserStatusMapper on UserStatus {
  pb.UserStatus toProto() {
    switch (this) {
      case UserStatus.PENDING:
        return pb.UserStatus.USER_PENDING;
      case UserStatus.ACTIVE:
        return pb.UserStatus.USER_ACTIVE;
      case UserStatus.BLOCKED:
        return pb.UserStatus.USER_BLOCKED;
      case UserStatus.WITHDRAWAL:
        return pb.UserStatus.USER_WITHDRAWAL;
    }
  }
}
