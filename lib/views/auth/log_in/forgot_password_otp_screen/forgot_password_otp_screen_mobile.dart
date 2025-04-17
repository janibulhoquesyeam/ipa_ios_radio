import 'package:adradio/backend/utils/custom_loading_api.dart';
import 'package:dynamic_languages/dynamic_languages.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../controller/auth/login/forgot_password_otp_controller/forgot_password_otp_controller.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/appbar/basic_icon_widget.dart';
import '../../../../widgets/others/title_subtitle_widget.dart';

class ForgotPasswordOtpScreenMobile extends StatelessWidget {
  ForgotPasswordOtpScreenMobile({super.key});

  final controller = Get.put(ForgotPasswordOtpController());
  final forgotPasswordFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        Strings.back,
        centerTitle: false,
        onTap: () {
          Navigator.pop(context);
        },
      ),
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      children: [
        _appLogoWidget(context),
        _titleSubtitleWidget(context),
        _otpWidget(context),
      ],
    );
  }

  _appLogoWidget(BuildContext context) {
    return const BasicIconWidget(isIcon: true);
  }

  _titleSubtitleWidget(BuildContext context) {
    return TitleSubTitleWidget(
      title: Strings.oTPVerification,
      titleFontSize: Dimensions.headingTextSize1,
      subTitle: Strings.oTPVerificationSubtitle,
      subTitleFontSize: Dimensions.headingTextSize5,
      isCenterText: false,
    ).marginSymmetric(horizontal: Dimensions.marginSizeHorizontal);
  }

  _otpWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Dimensions.marginSizeHorizontal * 0.8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.radius * 4),
          topRight: Radius.circular(Dimensions.radius * 4),
        ),
      ),
      child: Column(
        children: [
          _otpInputWidget(context),
          _timerOrResendWidget(context),
          _buttonWidget(context),
        ],
      ),
    );
  }

  _otpInputWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: Dimensions.paddingVerticalSize * 1.5),
      child: Form(
        key: forgotPasswordFormKey,
        child: PinCodeTextField(
          appContext: context,
          backgroundColor: Colors.transparent,
          textStyle: Get.isDarkMode
              ? CustomStyle.darkHeading2TextStyle
              : CustomStyle.lightHeading2TextStyle,
          enableActiveFill: true,
          pastedTextStyle: TextStyle(
            color: Colors.orange.shade600,
            fontWeight: FontWeight.bold,
          ),
          length: 6,
          obscureText: false,
          blinkWhenObscuring: true,
          animationType: AnimationType.fade,
          validator: (v) {
            if (v!.length < 3) {
              return DynamicLanguage.isLoading ? "": DynamicLanguage.key(Strings.pleaseFillOutTheField);
            } else {
              return null;
            }
          },
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.underline,
            fieldHeight: 48,
            fieldWidth: 50,
            inactiveColor: CustomColor.primaryLightTextColor.withOpacity(.2),
            activeColor: CustomColor.primaryLightTextColor,
            selectedColor: CustomColor.primaryLightTextColor,
            inactiveFillColor: CustomColor.whiteColor,
            activeFillColor: CustomColor.whiteColor,
            selectedFillColor: CustomColor.whiteColor,
            borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
          ),
          cursorColor: CustomColor.primaryLightTextColor,
          animationDuration: const Duration(milliseconds: 300),
          errorAnimationController: controller.errorController,
          controller: controller.pinCodeController,
          keyboardType: TextInputType.number,
          onCompleted: (v) {},
          /**/
          onChanged: (value) {
            controller.changeCurrentText(value);
          },
          beforeTextPaste: (text) {
            return true;
          },
        ),
      ),
    );
  }

  _timerOrResendWidget(BuildContext context) {
    return Obx(
      () => controller.enableResend.value
          ? _resendButton(context)
          : _timeWidget(context),
    );
  }

  _buttonWidget(context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.marginSizeVertical,
      ),
      child: Obx(() => controller.isLoading
          ? const CustomLoadingAPI()
          : PrimaryButton(
              title: Strings.submit,
              onPressed: () {
                if (forgotPasswordFormKey.currentState!.validate()) {
                  controller.onSubmit;
                }
              },
            )),
    );
  }

  _timeWidget(BuildContext context) {
    return Obx(
      () => Padding(
        padding: EdgeInsets.only(
          top: Dimensions.paddingVerticalSize,
          bottom: Dimensions.paddingVerticalSize,
        ),
        child: Row(
          mainAxisAlignment: mainCenter,
          children: [
            Icon(
              Icons.watch_later_outlined,
              color: Theme.of(context).primaryColor,
            ),
            horizontalSpace(Dimensions.widthSize * 0.5),
            TitleHeading4Widget(
              text: controller.secondsRemaining.value >= 0 &&
                      controller.secondsRemaining.value <= 9
                  ? '00:0${controller.secondsRemaining.value}'
                  : '00:${controller.secondsRemaining.value}',
              fontWeight: FontWeight.w600,
            )
          ],
        ),
      ),
    );
  }

  _resendButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: Dimensions.paddingVerticalSize,
        bottom: Dimensions.paddingVerticalSize,
      ),
      child: Obx(() => controller.isReSendLoading
          ? const CustomLoadingAPI()
          : InkWell(
              onTap: () {
                controller.resendCodeProcess();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(.1),
                  borderRadius: BorderRadius.circular(Dimensions.radius * 2),
                ),
                child: TitleHeading3Widget(
                  padding: EdgeInsets.symmetric(
                      vertical: Dimensions.paddingVerticalSize * .35,
                      horizontal: Dimensions.paddingHorizontalSize * .65),
                  text: Strings.resend,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            )),
    );
  }
}
