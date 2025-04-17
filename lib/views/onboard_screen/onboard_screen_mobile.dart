import 'package:adradio/backend/utils/custom_loading_api.dart';

import '../../controller/settings/basic_settings_controller.dart';
import '../../routes/routes.dart';
import '../../utils/basic_screen_imports.dart';

class OnboardScreenMobile extends StatelessWidget {
  OnboardScreenMobile({super.key});

  // final controller = Get.put(OnboardController());
  final controller = Get.find<BasicSettingsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.isLoading
          ? const CustomLoadingAPI()
          : _bodyWidget(context)),
    );
  }

  _bodyWidget(BuildContext context) {
    return Obx(() => Container(
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  controller.onboard[controller.onboardIndex.value]),
              fit: BoxFit.cover,
            ),
          ),
          child: _buttonWidget(context),
        ));
  }

  _buttonWidget(context) {
    return Column(
      mainAxisAlignment: mainEnd,
      children: [
        InkWell(
          onTap: () {
            debugPrint(">> TEST >>\nvalue >> ${controller.onboardIndex.value}\nlength >> ${controller.onboard.length}");
            if(controller.onboard.length == (controller.onboardIndex.value+1)) {
              Get.toNamed(Routes.loginScreen);
            }else{
              controller.onboardIndex.value ++ ;
            }
          },
          child: CircleAvatar(
            radius: Dimensions.radius * 5,
            backgroundColor: CustomColor.whiteColor.withOpacity(0.10),
            child: CircleAvatar(
              backgroundColor: CustomColor.whiteColor.withOpacity(0.30),
              radius: Dimensions.radius * 4,
              child: CircleAvatar(
                backgroundColor: CustomColor.whiteColor,
                radius: Dimensions.radius * 3,
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: CustomColor.primaryLightColor,
                ),
              ),
            ),
          ),
        ),
        verticalSpace(Dimensions.heightSize * 4),
      ],
    );
  }
}
