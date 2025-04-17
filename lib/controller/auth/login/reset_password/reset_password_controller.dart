import '../../../../backend/model/common/common_success_model.dart';
import '../../../../backend/services/auth_service/auth_service.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../views/congratulation/congratulation_screen.dart';
import '../login_controller/login_controller.dart';

class ResetPasswordController extends GetxController with AuthService{
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();

  @override
  void dispose() {
    confirmPassword.dispose();
    newPassword.dispose();
    super.dispose();
  }

  get onResetPassword => resetPasswordProcess();

  _onResetPassword() {
    Get.to(
      CongratulationScreen(
        route: Routes.loginScreen,
        subTitle: _resetPasswordModel.message.success.first,
        title: Strings.congratulations,
      ),
    );
  }


  /// ------------------------------------- >>
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late CommonSuccessModel _resetPasswordModel;
  CommonSuccessModel get resetPasswordModel => _resetPasswordModel;

  ///* ResetPassword in process
  Future<CommonSuccessModel> resetPasswordProcess() async {
    _isLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'token': Get.find<LoginController>().sendCodeModel.data.token,
      'password': newPassword.text,
      'password_confirmation': confirmPassword.text,
    };
    await resetPasswordProcessApi(body: inputBody).then((value) {
      _resetPasswordModel = value!;
      newPassword.clear();
      confirmPassword.clear();
      _onResetPassword();
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _resetPasswordModel;
  }

}