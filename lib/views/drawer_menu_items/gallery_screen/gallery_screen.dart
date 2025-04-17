import 'package:adradio/views/drawer_menu_items/gallery_screen/gallery_screen_mobile.dart';

import '../../../controller/drawer/gallery_controller/gallery_controller.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../utils/responsive_layout.dart';


class GalleryScreen extends StatelessWidget {
  GalleryScreen({super.key});

  final controller = Get.put(GalleryController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: GalleryScreenMobile(controller: controller),
    );
  }
}