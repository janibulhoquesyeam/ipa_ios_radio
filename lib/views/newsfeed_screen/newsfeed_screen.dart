import '../../../../views/newsfeed_screen/newsfeed_screen_mobile.dart';

import '../../controller/newsfeed_controller/newsfeed_controller.dart';
import '../../utils/basic_screen_imports.dart';
import '../../utils/responsive_layout.dart';

class NewsfeedScreen extends StatelessWidget {
   NewsfeedScreen({super.key});

  final controller = Get.put(NewsfeedController());
  @override
  Widget build(BuildContext context) {
    return   ResponsiveLayout(
      mobileScaffold: NewsfeedScreenMobile(controller: controller),
    );
  }
}