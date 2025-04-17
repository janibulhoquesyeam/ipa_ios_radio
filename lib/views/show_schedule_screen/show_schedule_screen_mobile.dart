import 'package:adradio/backend/utils/custom_loading_api.dart';
import 'package:adradio/extensions/custom_extensions.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controller/show_schedule_controller/show_schedule_controller.dart';
import '../../utils/basic_screen_imports.dart';
import '../../widgets/appbar/basic_icon_widget.dart';

class ShowScheduleScreenMobile extends StatelessWidget {
  const ShowScheduleScreenMobile({super.key, required this.controller});

  final ShowScheduleController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.isLoading
          ? const CustomLoadingAPI()
          : _bodyWidget(context)),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(bottom: Dimensions.heightSize * .5),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _dateSelectorWidget(context),
        _selectedDateScheduleTitleWidget(context),
        _scheduleStepperWidget(context),
      ],
    );
  }

  _dateSelectorWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingHorizontalSize,
          vertical: Dimensions.paddingVerticalSize * .5),
      child: Container(
        height: MediaQuery.sizeOf(context).height * .06,
        decoration: BoxDecoration(
          color: CustomColor.primaryLightTextColor.withOpacity(.1),
          borderRadius: BorderRadius.circular(Dimensions.radius * 3),
        ),
        child: Obx(
          () => Row(
            children: List.generate(
              controller.showScheduleModel.data.days.length,
              (index) => Expanded(
                child: InkWell(
                  onTap: () {
                    controller.selectedDay.value =
                        controller.showScheduleModel.data.days[index];
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(Dimensions.radius * 1.8),
                      /*
                      controller.selectedDay.value.name ==
                                              DateTime.now().showWeek
                      controller.selectedDay.value ==
                              controller.showScheduleModel.data.days[index]
                       */
                      color: controller.selectedDay.value ==
                              controller.showScheduleModel.data.days[index]
                          ? CustomColor.primaryLightColor
                          : null,
                    ),
                    child: TitleHeading5Widget(
                      text: controller.showScheduleModel.data.days[index].name
                          .substring(0, 3),
                      fontWeight:
                          controller.showScheduleModel.data.days[index].name ==
                                  DateTime.now().showWeek
                              ? FontWeight.bold
                              : FontWeight.w400,
                      color: controller.selectedDay.value ==
                              controller.showScheduleModel.data.days[index]
                          ? CustomColor.whiteColor
                          : CustomColor.blackColor.withOpacity(controller
                                      .showScheduleModel
                                      .data
                                      .days[index]
                                      .name ==
                                  DateTime.now().showWeek
                              ? .8
                              : .3),
                    ),
                  ).paddingSymmetric(
                    vertical: Dimensions.paddingVerticalSize * .25,
                  ),
                ),
              ),
            ),
          ).paddingSymmetric(
            horizontal: Dimensions.paddingHorizontalSize * .25,
          ),
        ),
      ),
    );
  }

  _selectedDateScheduleTitleWidget(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingHorizontalSize,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleHeading2Widget(
                  text: controller.selectedDay.value.name,
                  fontWeight: FontWeight.w600,
                  color: CustomColor.primaryLightTextColor,
                ),
                TitleHeading5Widget(
                  text: Strings.programSchedule,
                  fontWeight: FontWeight.w600,
                  fontSize: Dimensions.headingTextSize6,
                  color: CustomColor.blackColor.withOpacity(.5),
                ),
              ],
            ),
            const BasicIconWidget(isIcon: true, primary: false)
          ],
        ),
      );
    }).paddingOnly(bottom: Dimensions.paddingVerticalSize * .5);
  }

  _scheduleStepperWidget(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .7,
      child: Obx(() => ListView.builder(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: controller.selectedDay.value.dailySchedule.length,
          itemBuilder: (context, index) {
            return Container(
              height: Dimensions.buttonHeight * 2.2,
              margin: EdgeInsets.symmetric(
                horizontal: Dimensions.paddingHorizontalSize,
              ),
              child: Column(
                crossAxisAlignment: crossStart,
                children: [
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: crossStart,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: Dimensions.radius * .6,
                              backgroundColor:
                                  (index == controller.currentShowIndex.value &&
                                          controller.selectedDay.value.name ==
                                              DateTime.now().showWeek)
                                      ? CustomColor.primaryLightColor
                                      : CustomColor.primaryLightTextColor
                                          .withOpacity(.25),
                              child: CircleAvatar(
                                radius: Dimensions.radius * .3,
                                backgroundColor: CustomColor
                                    .primaryLightScaffoldBackgroundColor,
                              ),
                            ).paddingOnly(
                                right: Dimensions.paddingHorizontalSize * .25),
                            TitleHeading5Widget(
                              text:
                                  '${controller.selectedDay.value.dailySchedule[index].startTime} - ${controller.selectedDay.value.dailySchedule[index].endTime}',
                              fontWeight: FontWeight.w500,
                              color:
                                  (index == controller.currentShowIndex.value &&
                                          controller.selectedDay.value.name ==
                                              DateTime.now().showWeek)
                                      ? CustomColor.primaryLightTextColor
                                          .withOpacity(.6)
                                      : CustomColor.primaryLightTextColor
                                          .withOpacity(.2),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: crossStart,
                          children: [
                            DottedLine(
                              dashColor:
                                  (index == controller.currentShowIndex.value &&
                                          controller.selectedDay.value.name ==
                                              DateTime.now().showWeek)
                                      ? CustomColor.primaryLightColor
                                      : CustomColor.primaryLightTextColor
                                          .withOpacity(.25),
                              dashGapLength: 2,
                              dashLength: 2,
                              lineThickness: 2,
                              direction: Axis.vertical,
                              lineLength:
                                  MediaQuery.of(context).size.height * .145,
                            ).paddingOnly(
                                top: Dimensions.paddingVerticalSize * .1,
                                left: Dimensions.paddingHorizontalSize * .2,
                                right: Dimensions.paddingHorizontalSize * .2),
                            Container(
                              margin: EdgeInsets.only(
                                top: Dimensions.marginSizeVertical * .7,
                                left: Dimensions.marginSizeHorizontal * .25,
                              ),
                              width: MediaQuery.of(context).size.width * .8,
                              decoration: BoxDecoration(
                                color: CustomColor.secondaryLightTextColor,
                                borderRadius: BorderRadius.circular(
                                    Dimensions.radius * .75),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left:
                                              Dimensions.paddingHorizontalSize *
                                                  .25,
                                          right:
                                              Dimensions.paddingHorizontalSize *
                                                  .25,
                                          top: Dimensions.paddingVerticalSize *
                                              .25,
                                          bottom:
                                              Dimensions.paddingVerticalSize *
                                                  .25),
                                      child: CircleAvatar(
                                        radius:
                                            MediaQuery.of(context).size.height *
                                                .04,
                                        backgroundColor:
                                            CustomColor.primaryLightColor,
                                        backgroundImage: NetworkImage(
                                          "${controller.imagePath}/${controller.selectedDay.value.dailySchedule[index].image}",
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 7,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TitleHeading5Widget(
                                          text: controller.selectedDay.value
                                              .dailySchedule[index].name,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              CustomColor.primaryLightTextColor,
                                          fontSize: Dimensions.headingTextSize6,
                                        ),
                                        TitleHeading5Widget(
                                          text: controller.selectedDay.value
                                              .dailySchedule[index].host,
                                          fontWeight: FontWeight.w500,
                                          color: CustomColor.primaryLightColor,
                                          fontSize: Dimensions.headingTextSize8,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: CircleAvatar(
                                      radius:
                                          MediaQuery.of(context).size.height *
                                              .02,
                                      backgroundColor:
                                          CustomColor.primaryLightColor,
                                      child: Center(
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          icon: Icon(
                                            Icons.email_outlined,
                                            size: Dimensions.iconSizeDefault,
                                            color: CustomColor.whiteColor,
                                          ),
                                          onPressed: () async{
                                            debugPrint(controller.selectedDay.value
                                                .dailySchedule[index].chatLink);
                                            if (!await launchUrl(Uri.parse(controller.selectedDay.value
                                                .dailySchedule[index].chatLink))) {
                                            throw Exception('Could not launch ${controller.selectedDay.value
                                                .dailySchedule[index].chatLink}');
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          })).marginOnly(bottom: Dimensions.marginSizeVertical * 2.5),
    );
  }
}
