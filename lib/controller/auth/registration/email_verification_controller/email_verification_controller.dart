import 'dart:async';
import 'package:adradio/backend/model/common/common_success_model.dart';
import 'package:adradio/controller/auth/login/login_controller/login_controller.dart';
import 'package:adradio/controller/auth/registration/registration_controller/registration_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../backend/local_storage/local_storage.dart';
import '../../../../backend/services/auth_service/auth_service.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../views/congratulation/congratulation_screen.dart';

class EmailVerificationController extends GetxController with AuthService {
  final bool fromLoginScreen = Get.arguments;

  final pinCodeController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  var currentText = ''.obs;

  get onSubmit => mailVerifyProcess();

  _onSubmitEmailCode() {
    LocalStorage.isLoginSuccess(isLoggedIn: true);
    Get.to(
      CongratulationScreen(
        route: Routes.navigationScreen,
        subTitle: _mailVerifyModel.message.success.first,
        title: Strings.congratulations,
      ),
    );
  }

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
    debugPrint(">> Test >>");
    debugPrint(">> $fromLoginScreen");
    debugPrint(">> ${fromLoginScreen ? "Login": "Registration"}");

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

  late CommonSuccessModel _mailVerifyModel;
  CommonSuccessModel get mailVerifyModel => _mailVerifyModel;

  ///* MailVerify in process
  Future<CommonSuccessModel> mailVerifyProcess() async {
    _isLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'token': fromLoginScreen
          ? Get.find<LoginController>().loginModel.data.authorization.token
          : Get.find<RegistrationController>()
              .registrationModel
              .data
              .authorization
              .token,
      'code': pinCodeController.text,
    };
    await mailVerifyProcessApi(body: inputBody).then((value) {
      _mailVerifyModel = value!;
      pinCodeController.clear();
      _onSubmitEmailCode();
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _mailVerifyModel;
  }

  /// ------------------------------------- >>
  final _isResendLoading = false.obs;
  bool get isResendLoading => _isResendLoading.value;

  late CommonSuccessModel _mailResendModel;
  CommonSuccessModel get mailResendModel => _mailResendModel;

  ///* Get MailResend in process
  Future<CommonSuccessModel> mailResendProcess() async {
    pinCodeController.clear();
    _isResendLoading.value = true;
    update();
    await mailResendProcessApi(fromLoginScreen
            ? Get.find<LoginController>().loginModel.data.authorization.token
            : Get.find<RegistrationController>()
                .registrationModel
                .data
                .authorization
                .token)
        .then((value) {
      _mailResendModel = value!;

      resendCode();

      _isResendLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isResendLoading.value = false;
    update();
    return _mailResendModel;
  }
}
