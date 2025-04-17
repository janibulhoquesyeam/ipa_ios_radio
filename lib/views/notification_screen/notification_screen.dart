import '../../../../views/notification_screen/notification_screen_mobile.dart';

import '../../controller/navigation_controller/notification_controller.dart';
import '../../utils/basic_screen_imports.dart';
import '../../utils/responsive_layout.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});


final controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return    ResponsiveLayout(
      mobileScaffold: NotificationScreenMobile(controller: controller),
    );
  }
}