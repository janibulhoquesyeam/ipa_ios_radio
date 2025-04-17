import 'package:adradio/backend/utils/custom_loading_api.dart';

import '../../backend/utils/no_data_widget.dart';
import '../../controller/navigation_controller/notification_controller.dart';
import '../../utils/basic_screen_imports.dart';
import '../../widgets/others/notifications_widget.dart';

class NotificationScreenMobile extends StatelessWidget {
  const NotificationScreenMobile({super.key, required this.controller});

  final NotificationController controller;

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
          appBar: PrimaryAppBar(
            Strings.notifications,
            centerTitle: false,
            appbarSize: Dimensions.heightSize * 4,
          ),
          body: Obx(() => controller.isLoading
              ? const CustomLoadingAPI()
              : _bodyWidget(context))),
    );
  }

  _bodyWidget(BuildContext context) {
    return controller.notificationModel.data.notifications.isEmpty
        ? const Center(child: NoDataWidget())
        : ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            itemCount: controller.notificationModel.data.notifications.length,
            itemBuilder: (context, index) {
              return NotificationsWidget(
                      data: controller
                          .notificationModel.data.notifications[index])
                  .paddingOnly(
                right: Dimensions.paddingHorizontalSize * .6,
                left: Dimensions.paddingHorizontalSize * .6,
                bottom: Dimensions.paddingVerticalSize * .08,
              );
            },
          );
  }
}
