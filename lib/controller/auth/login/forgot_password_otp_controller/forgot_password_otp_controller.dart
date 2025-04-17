
import 'dart:async';
import 'package:adradio/backend/model/common/common_success_model.dart';
import 'package:adradio/controller/auth/login/login_controller/login_controller.dart';

import '../../../../backend/services/auth_service/auth_service.dart';
import '../../../../extensions/custom_extensions.dart';

import '../../../../routes/routes.dart';
import '../../../../utils/basic_screen_imports.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgotPasswordOtpController extends GetxController  with AuthService{
  final pinCodeController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  var currentText = ''.obs;

  get onSubmit => verifyCodeProcess();

  changeCurrentText(value) {
    currentText.value = value;
  }

  @override
  void dispose() {
    pinCodeController.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    errorController = StreamController<ErrorAnimationType>();
    timerInit();
    super.onInit();
  }

  timerInit() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining.value != 0) {
        secondsRemaining.value--;
      } else {
        enableResend.value = true;
      }
    });
  }

  RxInt secondsRemaining = 59.obs;
  RxBool enableResend = false.obs;
  Timer? timer;

  resendCode() {
    secondsRemaining.value = 59;
    enableResend.value = false;
    timerInit();
  }

  /// ------------------------------------- >>
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late CommonSuccessModel _verifyCodeModel;
  CommonSuccessModel get verifyCodeModel => _verifyCodeModel;

  ///* VerifyCode in process
  Future<CommonSuccessModel> verifyCodeProcess() async {
    _isLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'token': Get.find<LoginController>().sendCodeModel.data.token,
      'code': pinCodeController.text,
    };
    await verifyCodeProcessApi(body: inputBody).then((value) {
      _verifyCodeModel = value!;

      pinCodeController.clear();
      Routes.resetPasswordScreen.toNamed;

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _verifyCodeModel;
  }


  /// ------------------------------------- >>
  final _isReSendLoading = false.obs;
  bool get isReSendLoading => _isReSendLoading.value;

  late CommonSuccessModel _resendCodeModel;
  CommonSuccessModel get resendCodeModel => _resendCodeModel;

  ///* Get ResendCode in process
  Future<CommonSuccessModel> resendCodeProcess() async {
    pinCodeController.clear();
    _isReSendLoading.value = true;
    update();
    await resendCodeProcessApi(Get.find<LoginController>().sendCodeModel.data.token).then((value) {
      _resendCodeModel = value!;
      resendCode();
      _isReSendLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isReSendLoading.value = false;
    update();
    return _resendCodeModel;
  }

}