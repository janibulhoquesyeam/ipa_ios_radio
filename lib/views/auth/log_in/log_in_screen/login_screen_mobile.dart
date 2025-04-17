import 'dart:ui';

import 'package:adradio/backend/utils/custom_loading_api.dart';
import 'package:adradio/widgets/inputs/primary_input_widget.dart';
import 'package:dynamic_languages/dynamic_languages.dart';
import 'package:flutter/gestures.dart';

import '../../../../controller/auth/login/login_controller/login_controller.dart';
import '../../../../custom_assets/assets.gen.dart';
import '../../../../utils/basic_widget_imports.dart';
import '../../../../widgets/appbar/basic_icon_widget.dart';
import '../../../../widgets/buttons/primary_button.dart';
import '../../../../widgets/others/title_subtitle_widget.dart';

class LoginScreenMobile extends StatelessWidget {
  LoginScreenMobile({super.key});

  final signInformKey = GlobalKey<FormState>();
  final forgotPasswordFormKey = GlobalKey<FormState>();
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primaryLightScaffoldBackgroundColor,
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Dimensions.marginSizeVertical),
      child: ListView(
        children: [
          _appLogoWidget(context),
          _welcomeTextWidget(context),
          _inputAndButtonWidget(context),
        ],
      ),
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
          top: Dimensions.paddingVerticalSize * .5),
      child: TitleSubTitleWidget(
        title: Strings.loginInformation.tr,
        titleFontSize: Dimensions.headingTextSize1,
        subTitle: Strings.loginSubtitle.tr,
      ),
    );
  }

  _inputAndButtonWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _loginWidget(context),
        _buttonWidget(context),
        _doNotHaveAnAccount(context),
        // _continueAsGuestUser(context),
        verticalSpace(20),
      ],
    );
  }

  _loginWidget(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: Dimensions.paddingHorizontalSize),
      child: Form(
        key: signInformKey,
        child: Padding(
          padding: EdgeInsets.only(top: Dimensions.paddingVerticalSize),
          child: Column(
            children: [
              PrimaryInputWidget(
                controller: controller.emailController,
                hintText: Strings.enterEmailAddress,
                label: Strings.emailAddress,
                suffixIconPath: Assets.icon.emailIcon,
              ),
              verticalSpace(Dimensions.heightSize * .75),
              PrimaryInputWidget(
                controller: controller.passwordController,
                hintText: Strings.enterPassword,
                label: Strings.password,
                isPasswordField: true,
                fillColor: CustomColor.primaryLightScaffoldBackgroundColor,
              ),
              verticalSpace(Dimensions.heightSize * .5),
              Row(
                mainAxisAlignment: mainEnd,
                children: [
                  InkWell(
                    onTap: () {
                      _showForgotPasswordDialog(context);
                    },
                    child: Text(
                      DynamicLanguage.isLoading ? "": DynamicLanguage.key(Strings.forgotPassword),
                      style: Get.isDarkMode
                          ? CustomStyle.darkHeading5TextStyle.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.normal,
                            )
                          : CustomStyle.lightHeading5TextStyle.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.normal,
                            ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _showForgotPasswordDialog(BuildContext context) {
    Get.dialog(
      BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5,
          sigmaY: 5,
        ),
        child: Dialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius),
          ),
          child: Form(
            key: forgotPasswordFormKey,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  mainAxisSize: mainMin,
                  children: [
                    TitleSubTitleWidget(
                      title: Strings.forgotPassword,
                      subTitle: Strings.forgotPasswordSubtitle,
                      subTitleFontSize: Dimensions.headingTextSize5,
                    ).paddingOnly(
                      right: Dimensions.paddingHorizontalSize * 0.5,
                      left: Dimensions.paddingHorizontalSize * 0.5,
                      top: Dimensions.paddingVerticalSize,
                      bottom: Dimensions.paddingVerticalSize * 0.68,
                    ),
                    PrimaryInputWidget(
                      controller: controller.forgotPasswordEmailController,
                      hintText: Strings.enterEmailAddress,
                      label: Strings.emailAddress,
                      fillColor:
                          CustomColor.primaryLightScaffoldBackgroundColor,
                      suffixIconPath: Assets.icon.emailIcon,
                      textInputType: TextInputType.emailAddress,
                    ).paddingOnly(
                      right: Dimensions.paddingHorizontalSize * 0.75,
                      left: Dimensions.paddingHorizontalSize * 0.75,
                    ),
                    verticalSpace(Dimensions.marginBetweenInputBox),
                    Obx(() => controller.isSendCodeLoading
                        ? const CustomLoadingAPI()
                        : PrimaryButton(
                            title: Strings.forgotPassword.replaceAll('?', ''),
                            fontSize: Dimensions.headingTextSize4,
                            onPressed: () {
                              if (forgotPasswordFormKey.currentState!
                                  .validate()) {
                                controller.onForgotPassword;
                              }
                            },
                            borderColor: CustomColor.primaryLightColor,
                            buttonColor: CustomColor.primaryLightColor,
                          )).paddingOnly(
                      right: Dimensions.paddingHorizontalSize * 0.75,
                      left: Dimensions.paddingHorizontalSize * 0.75,
                      bottom: Dimensions.paddingVerticalSize * 0.75,
                    ),
                  ],
                ),
                Positioned(
                  right: -15,
                  top: -15,
                  child: InkWell(
                    onTap: () {
                      Get.close(1);
                    },
                    child: CircleAvatar(
                      radius: Dimensions.radius * 1.4,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: const Icon(
                        Icons.close_rounded,
                        color: CustomColor.whiteColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

  _buttonWidget(context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.marginSizeVertical * .8,
        horizontal: Dimensions.paddingHorizontalSize,
      ),
      child: Obx(() => controller.isLoading
          ? const CustomLoadingAPI()
          : PrimaryButton(
              buttonColor: Theme.of(context).primaryColor,
              title: Strings.login,
              onPressed: () {
                if (signInformKey.currentState!.validate()) {
                  controller.onLogin;
                }
              },
              borderColor: Theme.of(context).primaryColor,
            )),
    );
  }

  _doNotHaveAnAccount(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Dimensions.marginSizeVertical * .1),
      child: Center(
        child: RichText(
          text: TextSpan(
            text: DynamicLanguage.isLoading ? "" : DynamicLanguage.key(Strings.doNotHaveAnAccount) + " ",
            style: Get.isDarkMode
                ? CustomStyle.darkHeading5TextStyle.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: Dimensions.headingTextSize6,
                    color: CustomColor.primaryDarkTextColor.withOpacity(.45),
                  )
                : CustomStyle.lightHeading5TextStyle.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: Dimensions.headingTextSize6,
                    color: CustomColor.primaryLightTextColor.withOpacity(.45),
                  ),
            children: [
              TextSpan(
                text: DynamicLanguage.isLoading ? "" : DynamicLanguage.key(Strings.registerNow),
                style: Get.isDarkMode
                    ? CustomStyle.darkHeading5TextStyle.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: Dimensions.headingTextSize6,
                      )
                    : CustomStyle.lightHeading5TextStyle.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: Dimensions.headingTextSize6,
                      ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    controller.onRegistration;
                  },
              )
            ],
          ),
        ),
      ),
    );
  }

  // _continueAsGuestUser(BuildContext context) {
  //   return Padding(
  //     padding: EdgeInsets.only(top: Dimensions.marginSizeVertical * 4),
  //     child: Center(
  //       child: InkWell(
  //         onTap: () {
  //           // controller.onContinueAsGuestUser;
  //         },
  //         child: Container(
  //           padding: EdgeInsets.symmetric(
  //             vertical: Dimensions.paddingVerticalSize * .25,
  //             horizontal: Dimensions.paddingHorizontalSize * .5,
  //           ),
  //           decoration: BoxDecoration(
  //             border: Border.all(
  //               color: CustomColor.primaryLightTextColor.withOpacity(.20),
  //               width: 1,
  //             ),
  //             borderRadius: BorderRadius.circular(Dimensions.radius * 2.8),
  //           ),
  //           child: TitleHeading4Widget(
  //             text: Strings.continueAsGuestUser,
  //             color: CustomColor.primaryLightTextColor.withOpacity(.35),
  //             fontWeight: FontWeight.w500,
  //             fontSize: Dimensions.headingTextSize6,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
