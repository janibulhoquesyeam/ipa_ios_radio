import 'dart:ui';

import 'package:adradio/backend/utils/custom_loading_api.dart';
import 'package:adradio/controller/settings/basic_settings_controller.dart';
import 'package:dynamic_languages/dynamic_languages.dart';
import 'package:iconsax/iconsax.dart';

import '../../controller/drawer/update_profile_controller/update_profile_controller.dart';
import '../../controller/navigation_controller/navigation_controller.dart';
import '../../custom_assets/assets.gen.dart';
import '../../routes/routes.dart';
import '../../utils/basic_widget_imports.dart';
import '../appbar/basic_icon_widget.dart';
import '../others/custom_container.dart';
import '../text_labels/title_heading5_widget.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.clipart.drawerBackground.path),
                fit: BoxFit.contain,
                alignment: Alignment.bottomCenter,
              ),
              color: Get.isDarkMode
                  ? CustomColor.blackColor
                  : CustomColor.whiteColor),
          child: _allItemListView(context),
        ),
      ),
    );
  }

  buildMenuItem(
    BuildContext context, {
    required String title,
    required IconData imagePath,
    required VoidCallback onTap,
    double scaleImage = 1,
  }) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: Dimensions.paddingHorizontalSize,
          ),
          child: ListTile(
            dense: true,
            leading: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius * .5),
                  color: CustomColor.primaryLightColor),
              // ignore: deprecated_member_use
              child: Icon(imagePath, color: CustomColor.whiteColor),
            ),
            title: TitleHeading4Widget(
              fontWeight: FontWeight.w600,
              text: title,
            ),
            onTap: onTap,
          ),
        ),
      ],
    );
  }

  _drawerItems(BuildContext context) {
    return Column(
      children: [
        buildMenuItem(
          context,
          imagePath: Icons.person_outline,
          title: Strings.updateProfile.tr,
          onTap: () {
            Get.toNamed(Routes.updateProfileScreen);
          },
        ),
        buildMenuItem(
          context,
          imagePath: Icons.photo_outlined,
          title: Strings.gallery.tr,
          onTap: () {
            Get.toNamed(Routes.galleryScreen);
          },
        ),
        buildMenuItem(
          context,
          imagePath: Icons.groups_outlined,
          title: Strings.team.tr,
          onTap: () {
            Get.toNamed(Routes.teamScreen);
          },
        ),
        buildMenuItem(
          context,
          imagePath: Icons.feed_outlined,
          title: Strings.blog.tr,
          onTap: () {
            Get.toNamed(Routes.flutterWebScreen, arguments: {
              'url': Get.find<BasicSettingsController>()
                  .basicSettingsModel
                  .data
                  .webLinks
                  .blog,
              'title': Strings.blog
            });
          },
        ),
        Obx(() {
          return Padding(
            padding: EdgeInsets.only(
              left: Dimensions.paddingHorizontalSize,
            ),
            child: ListTile(
              dense: true,
              leading: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius * .5),
                    color: CustomColor.primaryLightColor),
                child: const Icon(
                  Icons.language,
                  color: Colors.white,
                ),
              ),
              title: const TitleHeading4Widget(
                padding: EdgeInsets.zero,
                fontWeight: FontWeight.w600,
                text: Strings.language,
              ),
              trailing: DropdownButton<String>(
                value: DynamicLanguage.selectedLanguage.value,
                underline: Container(),
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: CustomColor.primaryLightColor,
                  size: Dimensions.iconSizeDefault,
                ),
                elevation: 16,
                style: CustomStyle.lightHeading5TextStyle.copyWith(
                    fontSize: Dimensions.headingTextSize6,
                    fontWeight: FontWeight.w500,
                    color: CustomColor.primaryLightColor),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    DynamicLanguage.changeLanguage(newValue);
                    Get.offAllNamed(Routes.navigationScreen);
                  }
                },
                items: DynamicLanguage.languages.map<DropdownMenuItem<String>>(
                  (language) {
                    return DropdownMenuItem<String>(
                      value: language.code,
                      child: Text(language.code.toUpperCase()),
                    );
                  },
                ).toList(),
              ),
            ),
          );
        }),
        buildMenuItem(
          context,
          imagePath: Icons.key,
          title: Strings.changePassword.tr,
          onTap: () {
            Get.toNamed(Routes.changePasswordScreen);
          },
        ),
        buildMenuItem(
          context,
          imagePath: Icons.help_center_outlined,
          title: Strings.helpCenter.tr,
          onTap: () {
            Get.toNamed(Routes.flutterWebScreen, arguments: {
              'url': Get.find<BasicSettingsController>()
                  .basicSettingsModel
                  .data
                  .webLinks
                  .contactUs,
              'title': Strings.helpCenter
            });
          },
        ),
        buildMenuItem(
          context,
          imagePath: Icons.policy_outlined,
          title: Strings.privacyAndPolicy.tr,
          onTap: () {
            Get.toNamed(Routes.flutterWebScreen, arguments: {
              'url': Get.find<BasicSettingsController>()
                  .basicSettingsModel
                  .data
                  .webLinks
                  .privacyPolicy,
              'title': Strings.privacyAndPolicy
            });
          },
        ),
        buildMenuItem(
          context,
          imagePath: Icons.info_outline_rounded,
          title: Strings.aboutUs.tr,
          onTap: () {
            Get.toNamed(Routes.flutterWebScreen, arguments: {
              'url': Get.find<BasicSettingsController>()
                  .basicSettingsModel
                  .data
                  .webLinks
                  .aboutUs,
              'title': Strings.aboutUs
            });
          },
        ),
        buildMenuItem(
          context,
          imagePath: Icons.logout,
          title: Strings.logout.tr,
          onTap: () {
            _showLogoutDialog(context);
          },
        ),
        verticalSpace(Dimensions.heightSize * 2)
      ],
    );
  }

  _allItemListView(BuildContext context) {
    return Obx(() => ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Row(
              mainAxisAlignment: mainStart,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: EdgeInsets.all(Dimensions.paddingHorizontalSize),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Icon(
                          Iconsax.arrow_left,
                          color: Get.isDarkMode
                              ? CustomColor.whiteColor
                              : CustomColor.blackColor,
                          size: Dimensions.iconSizeLarge,
                        )),
                  ),
                ),
                const BasicIconWidget(isIcon: false, primary: false)
              ],
            ),
            Get.find<UpdateProfileController>().isLoading
                ? const SizedBox.shrink()
                : Padding(
                    padding: EdgeInsets.only(
                      left: Dimensions.paddingHorizontalSize,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _userImage(context),
                        TitleHeading2Widget(
                            text: Get.find<UpdateProfileController>()
                                .profileInfoModel
                                .data
                                .userInfo
                                .fullName),
                        SizedBox(
                          height: Dimensions.heightSize * 0.2,
                        ),
                        TitleHeading5Widget(
                          text: Get.find<UpdateProfileController>()
                              .profileInfoModel
                              .data
                              .userInfo
                              .email,
                          fontWeight: FontWeight.w500,
                          opacity: 0.4,
                        ),
                      ],
                    ),
                  ),
            verticalSpace(Dimensions.heightSize * 0.75),
            _drawerItems(context),
          ],
        ));
  }

  _userImage(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
            color: CustomColor.whiteColor.withOpacity(0.05), width: 7),
      ),
      child: Center(
        child: CircleAvatar(
          radius: Dimensions.radius * 5.5,
          backgroundColor: CustomColor.primaryLightColor,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: Dimensions.radius * 5.1,
            child: CircleAvatar(
                radius: Dimensions.radius * 4.8,
                backgroundColor: Colors.blueAccent.withOpacity(.1),
                backgroundImage: Image.network(
                  Get.find<UpdateProfileController>()
                      .profileInfoModel
                      .data
                      .userInfo
                      .userImage,
                ).image),
          ),
        ),
      ),
    ).marginOnly(right: Dimensions.marginSizeVertical);
  }

  _showLogoutDialog(BuildContext context) {
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
                    text: Strings.logoutAlert,
                    textAlign: TextAlign.start,
                  ),
                  verticalSpace(Dimensions.heightSize),
                  const TitleHeading3Widget(
                    text: Strings.areYouSure,
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
                            Get.find<NavigationController>().isLogOutLoading
                                ? const CustomLoadingAPI()
                                : InkWell(
                                    onTap: () {
                                      Get.find<NavigationController>()
                                          .logOutProcess();
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
