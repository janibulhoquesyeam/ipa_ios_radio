import '../../../../views/navigation/navigation_screen_mobile.dart';

import '../../../../utils/basic_screen_imports.dart';
import '../../../../utils/responsive_layout.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: NavigationScreenMobile(),
    );
  }
}