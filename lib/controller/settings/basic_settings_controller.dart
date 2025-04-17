import 'package:adradio/backend/services/basic_settings_service/basic_settings_service.dart';

import '../../backend/model/settings/basic_settings_model.dart';
import '../../backend/utils/api_method.dart';
import '../../extensions/custom_extensions.dart';
import '../../utils/basic_screen_imports.dart';

class BasicSettingsController extends GetxController with BasicSettingsService {
  @override
  void onInit() {
    basicSettingsGetProcess();
    super.onInit();
  }

  RxString basicLogo = "".obs;
  RxString basicIcon = "".obs;

  RxString splash = "".obs;
  RxInt onboardIndex = 0.obs;
  List<String> onboard = [];

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late BasicSettingsModel _basicSettingsModel;
  BasicSettingsModel get basicSettingsModel => _basicSettingsModel;

  Future<BasicSettingsModel> basicSettingsGetProcess() async {
    _isLoading.value = true;
    update();
    await basicSettingsGetProcessApi().then((value) {
      _basicSettingsModel = value!;

      var data = _basicSettingsModel.data;

      String defaultImage =
          "${data.appImagePaths.baseUrl}/${data.appImagePaths.defaultImage}";

      basicLogo.value = "${data.imagePaths.basePath}/${data.imagePaths.pathLocation}/${data.allLogo.siteLogoDark}";
      basicIcon.value = "${data.imagePaths.basePath}/${data.imagePaths.pathLocation}/${data.allLogo.siteFavDark}";

      splash.value = data.splashScreen.isNotEmpty
          ? data.splashScreen.first.image.isNotEmpty
              ? "${data.appImagePaths.baseUrl}/${data.appImagePaths.pathLocation}/${data.splashScreen.first.image}"
              : defaultImage
          : defaultImage;

      if(data.onboardScreens.isNotEmpty){
        for (var element in data.onboardScreens) {
          if(element.image.isNotEmpty) {
            onboard.add("${data.appImagePaths.baseUrl}/${data.appImagePaths.pathLocation}/${element.image}");
          }else{
            onboard.add(defaultImage);
          }
        }}
      else{
        onboard.add(defaultImage);
      }

      CustomColor.primaryLightColor = HexColor(_basicSettingsModel.data.basicSettings.baseColor);
      CustomColor.secondaryLightColor = HexColor(_basicSettingsModel.data.basicSettings.secondaryColor);

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _basicSettingsModel;
  }
}
