import '../../utils/basic_screen_imports.dart';
import '../../utils/responsive_layout.dart';
import 'videos_screen_mobile.dart';

class VideosScreen extends StatelessWidget {
  const VideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobileScaffold: VideosScreenMobile(),
    );
  }
}
