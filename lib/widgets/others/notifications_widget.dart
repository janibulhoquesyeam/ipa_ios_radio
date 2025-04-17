import 'package:adradio/backend/model/dashboard/notification_model.dart' as model;
import 'package:adradio/extensions/custom_extensions.dart';

import '../../utils/basic_screen_imports.dart';

class NotificationsWidget extends StatelessWidget {
  const NotificationsWidget({
    super.key, required this.data,
  });

  final model.Notification data;


  @override
  Widget build(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }
    return Padding(
      padding: EdgeInsets.only(bottom: Dimensions.paddingVerticalSize * 0.08),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius * 0.75),
          color: CustomColor.secondaryLightTextColor,
        ),
        padding: EdgeInsets.only(right: Dimensions.paddingHorizontalSize * 0.2),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                margin: EdgeInsets.only(
                  left: Dimensions.marginSizeHorizontal * 0.4,
                  top: Dimensions.marginSizeVertical * 0.4,
                  bottom: Dimensions.marginSizeVertical * 0.4,
                  right: Dimensions.marginSizeHorizontal * 0.2,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: isTablet()
                      ? Dimensions.paddingVerticalSize * 0.5
                      : Dimensions.paddingVerticalSize * 0.2,
                  horizontal: Dimensions.paddingHorizontalSize * 0.2,
                ),
                decoration: BoxDecoration(
                    color: CustomColor.primaryLightScaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(Dimensions.radius)),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: mainCenter,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: crossCenter,
                  children: [
                    TitleHeading1Widget(
                      text: data.createdAt.showDate,
                      fontSize: isTablet()
                          ? Dimensions.headingTextSize1 * 1.7
                          : Dimensions.headingTextSize1 * 1.5,
                      fontWeight: FontWeight.w600,
                      color: CustomColor.primaryLightColor,
                    ),
                    TitleHeading5Widget(
                      text: data.createdAt.showMonthFull,
                      fontWeight: FontWeight.w600,
                      fontSize: isTablet()
                          ? Dimensions.headingTextSize5
                          : Dimensions.headingTextSize6,
                      color: CustomColor.primaryLightColor,
                    ),
                  ],
                ),
              ),
            ),
            horizontalSpace(Dimensions.widthSize),
            Expanded(
              flex: 13,
              child: Column(
                crossAxisAlignment: crossStart,
                mainAxisAlignment: mainCenter,
                children: [
                  TitleHeading5Widget(
                    text: data.message.title,
                    fontWeight: FontWeight.w700,
                    fontSize: Dimensions.headingTextSize4,
                    color: CustomColor.blackColor,
                  ),
                  verticalSpace(Dimensions.widthSize * 0.4),
                  TitleHeading5Widget(
                    padding: EdgeInsets.only(
                      right: Dimensions.paddingHorizontalSize * .05,
                    ),
                    maxLines: 3,
                    text: data.message.message,
                    fontSize: Dimensions.headingTextSize6,
                    fontWeight: FontWeight.w400,
                    color: CustomColor.primaryLightTextColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}