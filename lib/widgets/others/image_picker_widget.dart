import 'dart:io';

import 'package:flutter_svg/svg.dart';

import '../../controller/drawer/update_profile_controller/update_profile_controller.dart';
import '../../custom_assets/assets.gen.dart';
import '../../utils/basic_screen_imports.dart';

class ImagePickerWidget extends StatelessWidget {
  final VoidCallback? onImagePick;
  final bool isImagePathSet;
  final bool isPicker;
  final String? imagePath;

  const ImagePickerWidget({
    super.key,
    this.onImagePick,
    this.isImagePathSet = false,
    this.imagePath,
    this.isPicker = true,
  });

  @override
  Widget build(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    return Container(
      decoration: BoxDecoration(
        color: CustomColor.blackColor.withOpacity(0.1),
        border: Border.all(
          width: 3.38,
          color: Theme.of(context).primaryColor,
        ),
        shape: BoxShape.circle,
      ),
      child: Container(
        padding: !isPicker
            ? EdgeInsets.only(
                left: 110.w,
                top: 70.h,
                bottom: 10.h,
              )
            : EdgeInsets.zero,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.03),
            border: Border.all(width: 5, color: CustomColor.whiteColor),
            shape: BoxShape.circle,
            image: DecorationImage(
              image: isImagePathSet
                  ? FileImage(File(imagePath!))
                  : NetworkImage(Get.find<UpdateProfileController>()
                      .profileInfoModel
                      .data
                      .userInfo
                      .userImage) as ImageProvider,
              fit: BoxFit.cover,
            )),
        child: Visibility(
          visible: isPicker,
          child: Padding(
            padding: EdgeInsets.only(
              left: isTablet()
                  ? MediaQuery.sizeOf(context).width * .23
                  : MediaQuery.sizeOf(context).width * .33,
              top: 70.h,
              bottom: 10.h,
            ),
            child: InkWell(
              onTap: onImagePick,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.03),
                  border: Border.all(
                    width: 4,
                    color: CustomColor.whiteColor,
                  ),
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  foregroundColor: Colors.transparent,
                  radius: Dimensions.radius * 1.3,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: SvgPicture.asset(
                    Assets.icon.cameraIcon,
                    // ignore: deprecated_member_use
                    color: CustomColor.whiteColor,
                    height: Dimensions.iconSizeDefault,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
