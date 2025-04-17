import '../../../../views/drawer_menu_items/team_screen/team_screen_mobile.dart';
import '../../../controller/drawer/team_controller/team_controller.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../utils/responsive_layout.dart';

class TeamScreen extends StatelessWidget {
  TeamScreen({super.key});

  final controller = Get.put(TeamController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: TeamScreenMobile(controller: controller),
    );
  }
}