import 'dart:io';

import 'package:adradio/backend/local_storage/local_storage.dart';
import 'package:adradio/utils/basic_screen_imports.dart';
import 'package:image_picker/image_picker.dart';

import '../../../backend/model/common/common_success_model.dart';
import '../../../backend/model/dashboard/profile_info_model.dart';
import '../../../backend/services/dashboard_services/dashboard_service.dart';
import '../../../routes/routes.dart';

class UpdateProfileController extends GetxController with DashboardService{
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final countryController = TextEditingController();
  final cityController = TextEditingController();
  final sateController = TextEditingController();
  final zipCodeController = TextEditingController();

  RxString userImagePath = ''.obs;

  @override
  void onInit() {
    profileInfoProcess();
    super.onInit();
  }

  //-> Image Picker
  RxBool isImagePathSet = false.obs;
  File? image;
  ImagePicker picker = ImagePicker();

  chooseImageFromGallery() async {
    var pickImage = await picker.pickImage(source: ImageSource.gallery);
    image = File(pickImage!.path);
    if (image!.path.isNotEmpty) {
      userImagePath.value = image!.path;
      isImagePathSet.value = true;
    }
  }

  chooseImageFromCamera() async {
    var pickImage = await picker.pickImage(source: ImageSource.camera);
    image = File(pickImage!.path);
    if (image!.path.isNotEmpty) {
      userImagePath.value = image!.path;
      isImagePathSet.value = true;
    }
  }


  /// ------------------------------------- >>
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late ProfileInfoModel _profileInfoModel;
  ProfileInfoModel get profileInfoModel => _profileInfoModel;

  ///* Get ProfileInfo in process
  Future<ProfileInfoModel> profileInfoProcess() async {
    userImagePath.value = "";
    _isLoading.value = true;
    update();
    await profileInfoProcessApi().then((value) {
      _profileInfoModel = value!;

      var data = _profileInfoModel.data.userInfo;
      firstNameController.text = data.firstname;
      lastNameController.text = data.lastname;
      emailController.text = data.email;
      countryController.text = data.address.country;
      cityController.text = data.address.city;
      sateController.text = data.address.state;
      zipCodeController.text = data.address.zip;

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _profileInfoModel;
  }

  /// ------------------------------------- >>
  final _isUpdateLoading = false.obs;
  bool get isUpdateLoading => _isUpdateLoading.value;

  late CommonSuccessModel _profileUpdateModel;
  CommonSuccessModel get profileUpdateModel => _profileUpdateModel;

  ///* ProfileUpdate in process
  Future<CommonSuccessModel> profileUpdateProcess() async {
    _isUpdateLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'firstname': firstNameController.text,
      'lastname': lastNameController.text,
      'country': countryController.text,
      'state': countryController.text,
      'city': countryController.text,
      'zip': zipCodeController.text,
    };
    await profileUpdateProcessApi(body: inputBody).then((value) {
      _profileUpdateModel = value!;
      userImagePath.value = "";
      Get.offAllNamed(Routes.navigationScreen);
      _isUpdateLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isUpdateLoading.value = false;
    update();
    return _profileUpdateModel;
  }

  ///* ProfileUpdate in process with Image
  Future<CommonSuccessModel> profileUpdateProcessWithImage() async {
    _isUpdateLoading.value = true;
    update();
    Map<String, String> inputBody = {
      'firstname': firstNameController.text,
      'lastname': lastNameController.text,
      'country': countryController.text,
      'state': countryController.text,
      'city': countryController.text,
      'zip': zipCodeController.text,
    };
    await profileUpdateProcessApiWithImage(body: inputBody, filePath: userImagePath.value , fileName: "image").then((value) {
      _profileUpdateModel = value!;
      userImagePath.value = "";
      Get.offAllNamed(Routes.navigationScreen);
      _isUpdateLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isUpdateLoading.value = false;
    update();
    return _profileUpdateModel;
  }

  /// ------------------------------------- >>
  final _isDeleteLoading = false.obs;
  bool get isDeleteLoading => _isDeleteLoading.value;


  late CommonSuccessModel _profileDeleteModel;
  CommonSuccessModel get profileDeleteModel => _profileDeleteModel;

  ///* ProfileDelete in process
  Future<CommonSuccessModel> profileDeleteProcess() async {
    _isDeleteLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {};

    await profileDeleteProcessApi(body: inputBody).then((value) {
      _profileDeleteModel = value!;
      LocalStorage.logout();
      Get.offAllNamed(Routes.loginScreen);
      _isDeleteLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isDeleteLoading.value = false;
    update();
    return _profileDeleteModel;
  }

}