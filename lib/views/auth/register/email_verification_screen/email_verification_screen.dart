

import '../../../../views/auth/register/email_verification_screen/email_verification_screen_mobile.dart';

import '../../../../utils/basic_screen_imports.dart';
import '../../../../utils/responsive_layout.dart';


class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return    ResponsiveLayout(
      mobileScaffold:
      EmailVerificationScreenMobile(),
    );
  }
}