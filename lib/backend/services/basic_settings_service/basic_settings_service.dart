import 'package:dynamic_languages/dynamic_languages.dart';

import '../../model/settings/basic_settings_model.dart';
import '../../utils/api_method.dart';
import '../../utils/custom_snackbar.dart';
import '../api_endpoint.dart';

mixin BasicSettingsService{

  ///* Get BasicSettings api services
  Future<BasicSettingsModel?> basicSettingsGetProcessApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: true).get(
        "${ApiEndpoint.basicSettingsUrl}?lang=${DynamicLanguage.selectedLanguage.value}"
      );
      if (mapResponse != null) {
        BasicSettingsModel result = BasicSettingsModel.fromJson(mapResponse);
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from BasicSettings api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }
}