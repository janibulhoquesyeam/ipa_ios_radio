import 'package:adradio/backend/local_storage/local_storage.dart';

import '../../../../backend/model/auth/login_model.dart';
import '../../../../backend/model/auth/send_code_model.dart';
import '../../../../backend/services/auth_service/auth_service.dart';
import '../../../../extensions/custom_extensions.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/basic_screen_imports.dart';

class LoginController extends GetxController with AuthService{
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final forgotPasswordEmailController = TextEditingController();

  get onLogin => loginProcess();
  get onForgotPassword => sendCodeProcess();
  get onRegistration => Routes.registrationScreen.toNamed;

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late LoginModel _loginModel;
  LoginModel get loginModel => _loginModel;

  Future<LoginModel> loginProcess() async {
    _isLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'credentials': emailController.text,
      'password': passwordController.text,
    };
    await loginProcessApi(body: inputBody).then((value) {
      _loginModel = value!;

      emailController.clear();
      passwordController.clear();

      LocalStorage.saveToken(token: _loginModel.data.token);
      if(_loginModel.data.authorization.status){
        Get.toNamed(Routes.emailVerificationScreen, arguments: true);
      }
      else{
        LocalStorage.isLoginSuccess(isLoggedIn: true);
        Routes.navigationScreen.offAllNamed;
      }

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _loginModel;
  }



  /// ------------------------------------- >>

  final _isSendCodeLoading = false.obs;
  bool get isSendCodeLoading => _isSendCodeLoading.value;

  late SendCodeModel _sendCodeModel;
  SendCodeModel get sendCodeModel => _sendCodeModel;

  ///* SendCode in process
  Future<SendCodeModel> sendCodeProcess() async {
    _isSendCodeLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'credentials': forgotPasswordEmailController.text,
    };
    await sendCodeProcessApi(body: inputBody).then((value) {
      _sendCodeModel = value!;
      Get.close(1);
      forgotPasswordEmailController.clear();
      Routes.forgotPasswordOtpScreen.toNamed;
      _isSendCodeLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isSendCodeLoading.value = false;
    update();
    return _sendCodeModel;
  }


}