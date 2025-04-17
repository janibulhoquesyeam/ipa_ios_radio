import 'package:adradio/backend/utils/custom_loading_api.dart';

import '../../../../controller/auth/login/reset_password/reset_password_controller.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/appbar/basic_icon_widget.dart';
import '../../../../widgets/inputs/primary_input_widget.dart';
import '../../../../widgets/others/title_subtitle_widget.dart';

class ResetPasswordScreenMobile extends StatelessWidget {
  ResetPasswordScreenMobile({super.key});

  final controller = Get.put(ResetPasswordController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(Routes.loginScreen);
        return true;
      },
      child: Scaffold(
        appBar: const PrimaryAppBar(
          '',
          showBackButton: false,
        ),
        body: _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      children: [
        _appLogoWidget(context),
        _titleSubtitleWidget(context),
        _inputFieldWidget(context),
        _buttonWidget(context),
      ],
    );
  }

  _titleSubtitleWidget(BuildContext context) {
    return TitleSubTitleWidget(
      title: Strings.resetPassword,
      titleFontSize: Dimensions.headingTextSize1,
      subTitle: Strings.resetPasswordSubtitle,
      subTitleFontSize: Dimensions.headingTextSize5,
      isCenterText: false,
    ).marginSymmetric(horizontal: Dimensions.marginSizeHorizontal);
  }

  _appLogoWidget(BuildContext context) {
    return const BasicIconWidget(isIcon: true);
  }

  _inputFieldWidget(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          verticalSpace(Dimensions.heightSize * 2.5),
          PrimaryInputWidget(
            controller: controller.newPassword,
            hintText: Strings.enterNewPassword,
            label: Strings.newPassword,
            fillColor: CustomColor.whiteColor,
            isPasswordField: true,
            textInputType: TextInputType.text,
          ).marginSymmetric(
            horizontal: Dimensions.marginSizeHorizontal,
          ),
          verticalSpace(Dimensions.heightSize * .5),
          PrimaryInputWidget(
            controller: controller.confirmPassword,
            hintText: Strings.enterConfirmPassword,
            label: Strings.confirmPassword,
            fillColor: CustomColor.whiteColor,
            isPasswordField: true,
            textInputType: TextInputType.text,
          ).marginSymmetric(
            horizontal: Dimensions.marginSizeHorizontal,
          ),
        ],
      ),
    );
  }

  _buttonWidget(context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.marginSizeVertical * 1.66,
      ),
      child: Obx(() => controller.isLoading
          ? const CustomLoadingAPI()
          : PrimaryButton(
              title: Strings.resetPassword,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  controller.onResetPassword;
                }
              },
            )).marginSymmetric(horizontal: Dimensions.marginSizeHorizontal),
    );
  }
}
