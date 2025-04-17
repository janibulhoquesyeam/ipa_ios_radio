import '../../controller/settings/basic_settings_controller.dart';
import '../../utils/basic_screen_imports.dart';

class BasicIconWidget extends StatelessWidget {
  const BasicIconWidget({super.key, this.isIcon = true, this.primary = true});

  final bool isIcon, primary;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BasicSettingsController>();
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            controller.isLoading
                ? const SizedBox.shrink()
                : Image.network(
                    isIcon
                        ? controller.basicIcon.value
                        : controller.basicLogo.value,
                    height: MediaQuery.of(context).size.height * (primary ? .13 : .08),
                    width:
                        MediaQuery.of(context).size.width * (isIcon ? .2 : .35),
                  ).marginOnly(
                    left: Dimensions.marginSizeHorizontal * (primary ? 1 : 0),
                    top: Dimensions.marginSizeVertical * (primary ? 1.4 : 0),
                  ),
          ],
        ));
  }
}
