import 'package:adradio/backend/utils/custom_loading_api.dart';
import 'package:dynamic_languages/dynamic_languages.dart';
import 'package:flutter/gestures.dart';

import '../../../../backend/utils/custom_snackbar.dart';
import '../../../../controller/auth/registration/registration_controller/registration_controller.dart';
import '../../../../custom_assets/assets.gen.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/appbar/basic_icon_widget.dart';
import '../../../../widgets/inputs/check_box_widget.dart';
import '../../../../widgets/inputs/primary_input_widget.dart';
import '../../../../widgets/others/title_subtitle_widget.dart';

class RegistrationScreenMobile extends StatelessWidget {
  RegistrationScreenMobile({super.key});

  final controller = Get.put(RegistrationController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primaryLightScaffoldBackgroundColor,
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        verticalSpace(isTablet()
            ? Dimensions.marginSizeVertical * .01
            : Dimensions.marginSizeVertical),
        _appLogoWidget(context),
        _welcomeTextWidget(context),
        _fieldsWidget(context),
      ],
    );
  }

  _appLogoWidget(BuildContext context) {
    return const BasicIconWidget(isIcon: true);
  }

  _welcomeTextWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: Dimensions.paddingHorizontalSize,
          right: Dimensions.paddingHorizontalSize,
          top: Dimensions.paddingVerticalSize * .25),
      child: TitleSubTitleWidget(
        title: Strings.registrationTitle.tr,
        subTitle: Strings.registrationSubtitle.tr,
      ),
    );
  }

  _fieldsWidget(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.only(
          top: Dimensions.paddingHorizontalSize * .75,
        ),
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            _inputFieldWidget(context),
            _agreedWidget(context),
            _buttonWidget(context),
            _alreadyHaveAccountWidget(context),
            verticalSpace(Dimensions.heightSize),
          ],
        ),
      ),
    );
  }

  _inputFieldWidget(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: PrimaryInputWidget(
                    controller: controller.firstNameController,
                    hintText: Strings.enterName,
                    label: Strings.firstName,
                    textInputType: TextInputType.text,
                    fillColor: CustomColor.whiteColor,
                    suffixIconPath: Assets.icon.accountCircle)),
            horizontalSpace(Dimensions.widthSize),
            Expanded(
                child: PrimaryInputWidget(
                    controller: controller.lastNameController,
                    hintText: Strings.enterName,
                    label: Strings.lastName,
                    textInputType: TextInputType.text,
                    fillColor: CustomColor.whiteColor,
                    suffixIconPath: Assets.icon.accountCircle)),
          ],
        ).paddingSymmetric(
          horizontal: Dimensions.paddingHorizontalSize,
        ),
        verticalSpace(Dimensions.heightSize * .5),
        PrimaryInputWidget(
                controller: controller.emailAddressController,
                hintText: Strings.enterEmailAddress,
                label: Strings.emailAddress,
                textInputType: TextInputType.emailAddress,
                fillColor: CustomColor.whiteColor,
                suffixIconPath: Assets.icon.emailIcon)
            .paddingSymmetric(
          horizontal: Dimensions.paddingHorizontalSize,
        ),
        verticalSpace(Dimensions.heightSize * .5),
        PrimaryInputWidget(
          controller: controller.passwordController,
          hintText: Strings.enterPassword,
          label: Strings.password,
          fillColor: CustomColor.whiteColor,
          isPasswordField: true,
          textInputType: TextInputType.text,
        ).paddingSymmetric(
          horizontal: Dimensions.paddingHorizontalSize,
        ),
      ],
    );
  }

  _agreedWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: Dimensions.paddingVerticalSize * .5,
          left: Dimensions.paddingVerticalSize * .9),
      child: FittedBox(
        child: Row(
          crossAxisAlignment: crossStart,
          children: [
            CheckBoxWidget(
              isChecked: controller.agreed,
              onChecked: (value) {
                controller.agreed.value = value;
              },
            ),
          ],
        ),
      ),
    );
  }

  _alreadyHaveAccountWidget(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: DynamicLanguage.isLoading ? "" : DynamicLanguage.key(Strings.alreadyHaveAnAccount) + " ",
          style: Get.isDarkMode
              ? CustomStyle.darkHeading5TextStyle.copyWith(
                  color: CustomColor.primaryLightTextColor.withOpacity(.45),
                  fontSize: Dimensions.headingTextSize6,
                  fontWeight: FontWeight.w500)
              : CustomStyle.lightHeading5TextStyle.copyWith(
                  color: CustomColor.primaryLightTextColor.withOpacity(.45),
                  fontSize: Dimensions.headingTextSize6,
                  fontWeight: FontWeight.w500),
          children: [
            TextSpan(
              text: DynamicLanguage.isLoading ? "" : DynamicLanguage.key(Strings.loginNow),
              style: Get.isDarkMode
                  ? CustomStyle.darkHeading5TextStyle.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: Dimensions.headingTextSize6,
                      fontWeight: FontWeight.w600)
                  : CustomStyle.lightHeading5TextStyle.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: Dimensions.headingTextSize6,
                      fontWeight: FontWeight.w600),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  controller.onLogin;
                },
            )
          ],
        ),
      ),
    );
  }

  _buttonWidget(context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.marginSizeVertical,
        horizontal: Dimensions.paddingHorizontalSize,
      ),
      child: Obx(() => controller.isLoading
          ? const CustomLoadingAPI()
          : PrimaryButton(
              title: Strings.register,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  if (controller.agreed.value == true) {
                    controller.onRegistration;
                  } else {
                    CustomSnackBar.error(
                        Strings.pleaseAcceptTermsAndConditions.tr);
                  }
                }
              },
            )),
    );
  }
}
