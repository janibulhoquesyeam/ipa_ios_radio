import 'package:adradio/utils/basic_screen_imports.dart';
import 'package:adradio/utils/basic_widget_imports.dart';
import 'package:dynamic_languages/dynamic_languages.dart';

class CustomSnackBar1 {
  static success(String message) {
    return Get.snackbar(
        DynamicLanguage.isLoading ? "" : DynamicLanguage.key(Strings.success),
        DynamicLanguage.isLoading ? "" : DynamicLanguage.key(message),
        backgroundColor: Colors.green,
        colorText: Colors.white);
  }

  static error(String message) {
    return Get.snackbar(
        DynamicLanguage.isLoading ? "" : DynamicLanguage.key(Strings.alert),
        DynamicLanguage.isLoading ? "" : DynamicLanguage.key(message),
        backgroundColor: Colors.red,
        colorText: Colors.white);
  }
}

class CustomSnackBar{
  static success(String message) {
    return Get.snackbar(DynamicLanguage.isLoading ? "": DynamicLanguage.key(Strings.success), message,
        margin: EdgeInsets.symmetric(
            horizontal: Dimensions.marginSizeHorizontal * 0.5,
            vertical: Dimensions.marginSizeVertical * 0.5),
        backgroundColor: CustomColor.blackColor,
        colorText: CustomColor.whiteColor,
        leftBarIndicatorColor: CustomColor.greenColor,
        progressIndicatorBackgroundColor: Colors.red,
        isDismissible: true,
        animationDuration: const Duration(seconds: 1),
        snackPosition: SnackPosition.BOTTOM,
        borderRadius: 5.0,
        mainButton: TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(DynamicLanguage.isLoading ? "": DynamicLanguage.key(Strings.dismiss))),
        // boxShadows: BoxShadow()
        icon: const Icon(
          Icons.check_circle_rounded,
          color: CustomColor.greenColor,
        ));
  }
  static error(String message) {
    return Get.snackbar(DynamicLanguage.isLoading ? "": DynamicLanguage.key(Strings.alert), message,
        margin: EdgeInsets.symmetric(
            horizontal: Dimensions.marginSizeHorizontal * 0.5,
            vertical: Dimensions.marginSizeVertical * 0.5),
        backgroundColor: CustomColor.blackColor,
        colorText: CustomColor.whiteColor,
        leftBarIndicatorColor: CustomColor.redColor,
        progressIndicatorBackgroundColor: CustomColor.redColor,
        isDismissible: true,
        animationDuration: const Duration(seconds: 1),
        snackPosition: SnackPosition.BOTTOM,
        borderRadius: 5.0,
        mainButton: TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(DynamicLanguage.isLoading ? "": DynamicLanguage.key(Strings.dismiss))),
        // boxShadows: BoxShadow()
        icon: const Icon(
          Icons.warning,
          color: CustomColor.redColor,
        ));
  }
}

class CustomSnackBar2{
  static success(String message) {
    return ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Column(
      crossAxisAlignment: crossStart,
      children: [
        const TitleHeading3Widget(
          text: Strings.success,
          color: Colors.green,
        ),
        verticalSpace(5),
        TitleHeading4Widget(
          text: message,
          color: Colors.white,
        ),
      ],
    )));
  }

  static error(String message) {
    return ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Column(
      crossAxisAlignment: crossStart,
      children: [
        const TitleHeading3Widget(
          text: Strings.alert,
          color: Colors.red,
        ),
        verticalSpace(5),
        TitleHeading4Widget(
          text: message,
          color: Colors.white,
        ),
      ],
    )));
  }
}
