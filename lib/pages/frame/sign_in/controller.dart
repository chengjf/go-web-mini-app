import 'package:flutter/material.dart';
import 'package:go_web_mini_app/common/apis/apis.dart';
import 'package:go_web_mini_app/common/entities/entities.dart';
import 'package:go_web_mini_app/common/routers/routes.dart';
import 'package:go_web_mini_app/common/store/store.dart';
import 'package:go_web_mini_app/common/utils/utils.dart';
import 'package:go_web_mini_app/common/widgets/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'index.dart';

class SignInController extends GetxController {
  final state = SignInState();

  final _publicKeyLoaded = false.obs;

  String? _publicKey;

  SignInController();

  // username的控制器
  final TextEditingController usernameController = TextEditingController();
  // 密码的控制器
  final TextEditingController passController = TextEditingController();

  // final MyRepository repository;
  // SignInController({@required this.repository}) : assert(repository != null);

  // 跳转 注册界面
  handleNavSignUp() {
    Get.toNamed(AppRoutes.SIGN_UP);
  }

  // 忘记密码
  handleFogotPassword() {
    toastInfo(msg: '忘记密码');
  }

  // 执行登录操作
  handleSignIn() async {
    // if (!duIsEmail(_emailController.value.text)) {
    //   toastInfo(msg: '请正确输入邮件');
    //   return;
    // }
    if (!duCheckStringLength(passController.value.text, 6)) {
      // toastInfo(msg: '密码不能小于6位');
      EasyLoading.showError('密码不能小于6位');
      return;
    }
    print("_publicKeyLoaded.value ${_publicKeyLoaded.value}");
    print("${_publicKey}");
    if (!_publicKeyLoaded.value) {
      EasyLoading.showError('公钥还未加载');
      return;
    }

    UserLoginRequestEntity params = UserLoginRequestEntity(
      username: usernameController.value.text,
      password: rsaEncrypt(_publicKey!, passController.value.text),
    );

    UserLoginResponseEntity userLoginResponseEntity = await UserAPI.login(
      params: params,
    );
    await UserStore.to.setToken(userLoginResponseEntity.token);

    Get.offAndToNamed(AppRoutes.Application);
  }

  Future<void> fetchPublicKey() async {
    try {
      Loading.show("获取公钥");
      final response = await UserAPI.getPublicKey();
      _publicKey = response;
      _publicKeyLoaded.value = true;
      print("publicKeyLoaded ${_publicKeyLoaded.value}");
    } catch (e) {
      // errorMessage.value = 'Failed to load public key: ${e.toString()}';
      print(e);
    } finally {
      Loading.dismiss();
    }
  }

  @override
  void onReady() {
    super.onReady();
    this.fetchPublicKey();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passController.dispose();
    super.dispose();
  }
}
