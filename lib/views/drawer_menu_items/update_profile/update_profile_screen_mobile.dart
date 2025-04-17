import 'dart:ui';

import 'package:adradio/backend/utils/custom_loading_api.dart';

import '../../../../custom_assets/assets.gen.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/inputs/primary_input_widget.dart';
import '../../../controller/drawer/update_profile_controller/update_profile_controller.dart';
import '../../../widgets/others/custom_container.dart';
import '../../../widgets/others/image_picker_sheet.dart';
import '../../../widgets/others/image_picker_widget.dart';

class UpdateProfileScreenMobile extends StatelessWidget {
  UpdateProfileScreenMobile({super.key});

  final controller = Get.put(UpdateProfileController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: PrimaryAppBar(
        Strings.updateProfile.tr,
        centerTitle: false,
        action: [
          TextButton(
              onPressed: (){
                _showDeleteDialog(context);
              },
              child: const TitleHeading3Widget(
                text: Strings.deleteProfile,
                color: CustomColor.redColor,
              )
          )
        ],
      ),
      body: Obx(() => controller.isLoading || controller.isDeleteLoading
          ? const CustomLoadingAPI()
          : _bodyWidget(context)),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        _updateProfileInfoWidget(context),
        _updateProfileFieldsWidget(context),
      ],
    );
  }

  _updateProfileInfoWidget(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => ImagePickerWidget(
            isImagePathSet: controller.isImagePathSet.value,
            imagePath: controller.userImagePath.value,
            onImagePick: () {
              _showImagePickerBottomSheet(context);
            },
          ),
        ),
      ],
    ).paddingOnly(top: Dimensions.paddingVerticalSize * 2);
  }

  _showImagePickerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: double.infinity,
          child: ImagePickerSheet(
            fromCamera: () {
              Get.back();
              controller.chooseImageFromCamera();
            },
            fromGallery: () {
              Get.back();
              controller.chooseImageFromGallery();
            },
          ),
        );
      },
    );
  }

  _updateProfileFieldsWidget(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _firstNameAndLastNameWidget(context),
          _emailAddressWidget(context),
          _addressAndCityWidget(context),
          _stateAndZipCodeWidget(context),
          _updateButtonWidget(context),
        ],
      ),
    );
  }

  _firstNameAndLastNameWidget(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PrimaryInputWidget(
              controller: controller.firstNameController,
              hintText: Strings.firstName,
              label: Strings.firstName,
              fillColor: CustomColor.whiteColor,
              textInputType: TextInputType.text,
              suffixIconPath: Assets.icon.accountCircle),
        ),
        horizontalSpace(Dimensions.widthSize),
        Expanded(
          child: PrimaryInputWidget(
              controller: controller.lastNameController,
              hintText: Strings.lastName,
              label: Strings.lastName,
              fillColor: CustomColor.whiteColor,
              textInputType: TextInputType.text,
              suffixIconPath: Assets.icon.accountCircle),
        ),
      ],
    ).paddingOnly(
        bottom: Dimensions.paddingVerticalSize * 0.5,
        left: Dimensions.paddingHorizontalSize,
        right: Dimensions.paddingHorizontalSize,
        top: Dimensions.paddingVerticalSize);
  }

  _emailAddressWidget(BuildContext context) {
    return PrimaryInputWidget(
      readOnly: true,
      controller: controller.emailController,
      hintText: Strings.enterEmailAddress,
      label: Strings.emailAddress,
      fillColor: CustomColor.whiteColor,
      textInputType: TextInputType.text,
      suffixIconPath: Assets.icon.emailVerifiedIcon,
      suffixIconColor: CustomColor.emailVerifiedColor,
    ).paddingSymmetric(horizontal: Dimensions.paddingHorizontalSize);
  }

  _addressAndCityWidget(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PrimaryInputWidget(
              controller: controller.countryController,
              hintText: Strings.enterCountry,
              label: Strings.country,
              fillColor: CustomColor.whiteColor,
              textInputType: TextInputType.text,
              suffixIconPath: Assets.icon.accountCircle),
        ),
        horizontalSpace(Dimensions.widthSize),
        Expanded(
          child: PrimaryInputWidget(
              controller: controller.cityController,
              hintText: Strings.enterCity,
              label: Strings.city,
              fillColor: CustomColor.whiteColor,
              textInputType: TextInputType.text,
              suffixIconPath: Assets.icon.cityIcon),
        ),
      ],
    ).paddingSymmetric(
        horizontal: Dimensions.paddingHorizontalSize,
        vertical: Dimensions.paddingVerticalSize * 0.25);
  }

  _stateAndZipCodeWidget(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PrimaryInputWidget(
              controller: controller.sateController,
              hintText: Strings.enterState,
              label: Strings.state,
              fillColor: CustomColor.whiteColor,
              textInputType: TextInputType.text,
              suffixIconPath: Assets.icon.stateIcon),
        ),
        horizontalSpace(Dimensions.widthSize),
        Expanded(
          child: PrimaryInputWidget(
              controller: controller.zipCodeController,
              hintText: Strings.zipCode,
              label: Strings.zipCode,
              fillColor: CustomColor.whiteColor,
              textInputType: TextInputType.number,
              suffixIconPath: Assets.icon.zipCodeIcon),
        ),
      ],
    ).paddingSymmetric(
        horizontal: Dimensions.paddingHorizontalSize,
        vertical: Dimensions.paddingVerticalSize * 0.25);
  }

  _updateButtonWidget(BuildContext context) {
    return Obx(() => controller.isUpdateLoading
        ? const CustomLoadingAPI()
        : PrimaryButton(
            title: Strings.updateProfile,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                if (controller.userImagePath.value.isEmpty) {
                  controller.profileUpdateProcess();
                } else {
                  controller.profileUpdateProcessWithImage();
                }
              }
            },
          )).paddingOnly(
        right: Dimensions.paddingHorizontalSize,
        left: Dimensions.paddingHorizontalSize,
        top: Dimensions.paddingVerticalSize * 0.5,
        bottom: Dimensions.paddingVerticalSize * 1.5);
  }


  _showDeleteDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5,
            sigmaY: 5,
          ),
          child: Dialog(
            backgroundColor: CustomColor.primaryLightScaffoldBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingHorizontalSize,
                  vertical: Dimensions.paddingVerticalSize),
              child: Column(
                crossAxisAlignment: crossStart,
                mainAxisSize: mainMin,
                children: [
                  const TitleHeading1Widget(
                    text: Strings.deleteProfile,
                    textAlign: TextAlign.start,
                  ),
                  verticalSpace(Dimensions.heightSize),
                  const TitleHeading3Widget(
                    text: Strings.deleteAlert,
                    textAlign: TextAlign.center,
                    opacity: 0.60,
                  ),
                  verticalSpace(Dimensions.heightSize),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Get.close(1);
                          },
                          child: CustomContainer(
                            height: Dimensions.buttonHeight * 0.7,
                            borderRadius: Dimensions.radius * 0.8,
                            color: Get.isDarkMode
                                ? CustomColor.primaryBGLightColor
                                .withOpacity(0.15)
                                : CustomColor.primaryBGDarkColor
                                .withOpacity(0.15),
                            child: const TitleHeading4Widget(
                              text: Strings.cancel,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      horizontalSpace(Dimensions.widthSize),
                      Expanded(
                        child: Obx(() =>
                        controller.isDeleteLoading
                            ? const CustomLoadingAPI()
                            : InkWell(
                          onTap: () {
                            controller
                                .profileDeleteProcess();
                          },
                          child: CustomContainer(
                            height: Dimensions.buttonHeight * 0.7,
                            borderRadius: Dimensions.radius * 0.8,
                            color: Theme.of(context).primaryColor,
                            child: const TitleHeading4Widget(
                              text: Strings.okay,
                              color: CustomColor.whiteColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )),
                      ),
                    ],
                  ).paddingSymmetric(
                      horizontal: Dimensions.paddingHorizontalSize * 0.5,
                      vertical: Dimensions.paddingVerticalSize * 0.5),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}
