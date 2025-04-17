
import '../../../../views/show_schedule_screen/show_schedule_screen_mobile.dart';

import '../../controller/show_schedule_controller/show_schedule_controller.dart';
import '../../utils/basic_screen_imports.dart';
import '../../utils/responsive_layout.dart';

class ShowScheduleScreen extends StatelessWidget {
  ShowScheduleScreen({super.key});

  final controller = Get.put(ShowScheduleController());

  @override
  Widget build(BuildContext context) {
    return   ResponsiveLayout(
      mobileScaffold: ShowScheduleScreenMobile(controller: controller),
    );
  }
}