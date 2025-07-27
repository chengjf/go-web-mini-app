import 'package:go_web_mini_app/common/entities/entities.dart';
import 'package:go_web_mini_app/common/entities/public_key.dart';
import 'package:go_web_mini_app/common/utils/utils.dart';

/// 用户
class UserAPI {
  /// 登录
  static Future<UserLoginResponseEntity> login({
    UserLoginRequestEntity? params,
  }) async {
    var response = await HttpUtil().post(
      '/base/login',
      data: params?.toJson(),
    );
     var data = ApiResponse<UserLoginResponseEntity>.fromJson(
        response, (json) => UserLoginResponseEntity.fromJson(json));
    return data.data!;
  }

  /// 注册
  static Future<UserRegisterRequestEntity> register({
    UserRegisterRequestEntity? params,
  }) async {
    var response = await HttpUtil().post(
      '/user/register',
      data: params?.toJson(),
    );
    return UserRegisterRequestEntity.fromJson(response);
  }

  /// Profile
  static Future<UserLoginResponseEntity> profile() async {
    var response = await HttpUtil().post(
      '/user/profile',
    );
    return UserLoginResponseEntity.fromJson(response);
  }

  /// Logout
  static Future logout() async {
    return await HttpUtil().post(
      '/user/logout',
    );
  }

  static Future<String> getPublicKey() async {
    var response = await HttpUtil().get("/base/publicKey");
    var data = ApiResponse<PublicKey>.fromJson(
        response, (json) => PublicKey.fromJson(json));
    return data.data!.publicKey!;
  }
}
