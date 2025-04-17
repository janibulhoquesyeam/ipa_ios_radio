import 'dart:async';

import 'package:adradio/backend/local_storage/local_storage.dart';
import 'package:get/get.dart';

import '../routes/routes.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    _goToScreen();
  }

  _goToScreen() async {
    Timer(const Duration(seconds: 5), () {
      LocalStorage.isLoggedIn()
          ? Get.offAllNamed(Routes.navigationScreen)
          : Get.offAllNamed(Routes.onboardScreen);
    });
  }
}
