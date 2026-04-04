import 'package:danmalgi_mobile/core/generated/user/v1/user.pbenum.dart' as pb;
import 'package:danmalgi_mobile/features/user/domain/oauth_type.dart';

extension OAuthTypeMapper on pb.OauthType {
  OAuthType fromProto() {
    switch (this) {
      // TODO: authorization 에서 OAuthType을 return 하도록 수정되면 다시 NAVER->NAVER, KAKAO->KAKAO로 수정할 예정
      // TODO: 또 OAuth를 어디까지 지원할지 protobuf non-nullable에 대해서 어떻게 대처할지 알아봐야 할 듯 (ERROR나 NONE을 추가한다던가)
      case pb.OauthType.GOOGLE:
        return OAuthType.GOOGLE;
      case pb.OauthType.NAVER:
        return OAuthType.GOOGLE;
      case pb.OauthType.KAKAO:
        return OAuthType.GOOGLE;
      default:
        return OAuthType.ERROR;
    }
  }
}

extension DomainOAuthTypeMapper on OAuthType {
  pb.OauthType toProto() {
    switch (this) {
      case OAuthType.GOOGLE:
        return pb.OauthType.GOOGLE;
      case OAuthType.NAVER:
        return pb.OauthType.NAVER;
      case OAuthType.KAKAO:
        return pb.OauthType.KAKAO;
      case OAuthType.ERROR:
        return pb.OauthType.GOOGLE;
    }
  }
}
