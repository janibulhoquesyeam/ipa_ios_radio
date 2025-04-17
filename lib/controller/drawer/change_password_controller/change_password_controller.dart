import '../../../backend/model/common/common_success_model.dart';
import '../../../backend/services/dashboard_services/dashboard_service.dart';
import '../../../routes/routes.dart';
import '../../../utils/basic_screen_imports.dart';

class ChangePasswordController extends GetxController with DashboardService{
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  _clearInputText() {
    oldPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
  }

  /// ------------------------------------- >>
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late CommonSuccessModel _passwordChangeModel;
  CommonSuccessModel get passwordChangeModel => _passwordChangeModel;

  ///* PasswordChange in process
  Future<CommonSuccessModel> passwordChangeProcess() async {
    _isLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'current_password': oldPasswordController.text,
      'password': newPasswordController.text,
      'password_confirmation': confirmPasswordController.text,
    };
    await passwordChangeProcessApi(body: inputBody).then((value) {
      _passwordChangeModel = value!;
      _clearInputText();
      Get.offAllNamed(Routes.navigationScreen);
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _passwordChangeModel;
  }
}