import '../../../../views/live_streaming_screen/live_streaming_screen_mobile.dart';

import '../../controller/live_streaming_controller/live_streaming_controller.dart';
import '../../utils/basic_screen_imports.dart';
import '../../utils/responsive_layout.dart';

class LiveStreamingScreen extends StatelessWidget {
  LiveStreamingScreen({super.key});

  final controller = Get.put(LiveStreamingController());

  @override
  Widget build(BuildContext context) {
    return   ResponsiveLayout(
      mobileScaffold: LiveStreamingScreenMobile(controller: controller),
    );
  }
}