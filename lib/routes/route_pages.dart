import 'package:get/get.dart';

import '../../../../routes/routes.dart';
import '../bindings/navigation_screen_binding.dart';
import '../bindings/splash_screen_binding.dart';
import '../views/auth/log_in/forgot_password_otp_screen/forgot_password_otp_screen.dart';
import '../views/auth/log_in/log_in_screen/login_screen.dart';
import '../views/auth/log_in/reset_password_screen/reset_password_screen.dart';
import '../views/auth/register/email_verification_screen/email_verification_screen.dart';
import '../views/auth/register/register_screen/registration_screen.dart';
import '../views/drawer_menu_items/change_password/change_password_screen.dart';
import '../views/drawer_menu_items/gallery_screen/gallery_screen.dart';
import '../views/drawer_menu_items/team_screen/team_screen.dart';
import '../views/drawer_menu_items/update_profile/update_profile_screen.dart';
import '../views/navigation/navigation_screen.dart';
import '../views/notification_screen/notification_screen.dart';
import '../views/onboard_screen/onboard_screen.dart';
import '../views/splash_screen/splash_screen.dart';
import '../views/videos_screen/videos_screen.dart';
import '../widgets/others/flutter_web_screen.dart';

class RoutePageList {
  static var list = [
    GetPage(
      name: Routes.splashScreen,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.onboardScreen,
      page: () => const OnboardScreen(),
    ),
    GetPage(
      name: Routes.loginScreen,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: Routes.forgotPasswordOtpScreen,
      page: () => const ForgotPasswordOtpScreen(),
    ),
    GetPage(
      name: Routes.resetPasswordScreen,
      page: () => const ResetPasswordScreen(),
    ),
    GetPage(
      name: Routes.registrationScreen,
      page: () => const RegistrationScreen(),
    ),
    GetPage(
      name: Routes.emailVerificationScreen,
      page: () => const EmailVerificationScreen(),
    ),
    GetPage(
        name: Routes.navigationScreen,
        page: () => const NavigationScreen(),
        binding: NavigationBinding()),
    GetPage(
      name: Routes.videosScreen,
      page: () => const VideosScreen(),
    ),
    GetPage(
      name: Routes.notificationScreen,
      page: () => NotificationScreen(),
    ),
    GetPage(
      name: Routes.changePasswordScreen,
      page: () => const ChangePasswordScreen(),
    ),
    GetPage(
      name: Routes.flutterWebScreen,
      page: () => FlutterWebScreen(),
    ),
    GetPage(
      name: Routes.updateProfileScreen,
      page: () => const UpdateProfileScreen(),
    ),
    GetPage(
      name: Routes.galleryScreen,
      page: () => GalleryScreen(),
    ),
    GetPage(
      name: Routes.teamScreen,
      page: () => TeamScreen(),
    ),
  ];
}
