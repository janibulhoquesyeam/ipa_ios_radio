import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../backend/utils/custom_loading_api.dart';
import '../../controller/livetv_controller/livetv_controller.dart';

class livetvweb_screen extends StatelessWidget {
  livetvweb_screen({Key? key}) : super(key: key);

  // Get the instance of the controller
  final LivetvController controller = Get.put(LivetvController());

  // Define the URL in the UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.isLoading.value
          ? const CustomLoadingAPI()
          : WebViewWidget(
              controller: controller.webViewController!)), // Use the controller's WebViewController
    );
  }
}




