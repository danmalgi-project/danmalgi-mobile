import 'package:danmalgi_mobile/core/generated/user/v1/user.pbenum.dart' as pb;
import 'package:danmalgi_mobile/features/user/domain/oauth_type.dart';

extension OAuthTypeMapper on pb.OauthType {
  OAuthType fromProto() {
    switch (this) {
      case pb.OauthType.GOOGLE:
        return OAuthType.GOOGLE;
      case pb.OauthType.APPLE:
        return OAuthType.APPLE;
      default:
        return OAuthType.GOOGLE;
    }
  }
}

extension DomainOAuthTypeMapper on OAuthType {
  pb.OauthType toProto() {
    switch (this) {
      case OAuthType.GOOGLE:
        return pb.OauthType.GOOGLE;
      case OAuthType.APPLE:
        return pb.OauthType.APPLE;
    }
  }
}
