import 'package:get/get.dart';
import 'package:vloo/app/routes/app_pages.dart';

class IntroductionController extends GetxController {

  
  // // redirection to Login
  void toLogin() {
    Get.offAllNamed(Routes.login);
  }

    // redirection to signup
  void toSignup() {
    Get.offAllNamed(Routes.signup);
  }

   // redirection to home
  void toHome() {
    Get.offAllNamed(Routes.bottomNav);
  }


}
