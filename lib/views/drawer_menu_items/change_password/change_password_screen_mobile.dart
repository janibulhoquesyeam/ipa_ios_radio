import 'package:adradio/backend/utils/custom_loading_api.dart';

import '../../../../../utils/basic_screen_imports.dart';
import '../../../controller/drawer/change_password_controller/change_password_controller.dart';
import '../../../widgets/inputs/change_password_field_widget.dart';

class ChangePasswordScreenMobile extends StatelessWidget {
  ChangePasswordScreenMobile({
    super.key,
  });

  final controller = Get.put(ChangePasswordController());
  final changePasswordFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppBar(Strings.changePassword),
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return Form(
      key: changePasswordFormKey,
      child: Column(
        children: [
          ChangePasswordFieldsWidget(
            controller: controller,
          ),
          _changePasswordButtonWidget(context)
        ],
      ).paddingSymmetric(horizontal: Dimensions.marginSizeHorizontal * 0.8),
    );
  }

  _changePasswordButtonWidget(BuildContext context) {
    return Obx(() => controller.isLoading
        ? const CustomLoadingAPI()
        : PrimaryButton(
            title: Strings.changePassword,
            onPressed: () {
              if (changePasswordFormKey.currentState!.validate()) {
                controller.passwordChangeProcess();
              }
            },
          ));
  }
}
