import 'package:get/get.dart';

import '../controller/drawer/update_profile_controller/update_profile_controller.dart';
import '../controller/navigation_controller/navigation_controller.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UpdateProfileController());
    Get.put(NavigationController());
  }
}
