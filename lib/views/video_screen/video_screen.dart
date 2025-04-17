import 'package:adradio/views/video_screen/video_screen_mobile.dart';

import '../../backend/model/dashboard/dashboard_model.dart';
import '../../utils/basic_screen_imports.dart';
import '../../utils/responsive_layout.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key, required this.video});

  final Video video;

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: VideoScreenMobile(video: video),
    );
  }
}
