
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vloo/app/data/utils/singleton.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/modules/introduction/controllers/introduction_controller.dart';
import 'package:vloo/app/modules/introduction/views/introduction_view.dart';
import 'package:vloo/app/routes/app_pages.dart';

class SplashController extends GetxController with GetTickerProviderStateMixin {
  final GetStorage storage = Get.find<GetStorage>();
  late AnimationController scaleController;
  late AnimationController scaleControllerPadding;
  late Animation<double> scaleAnimation;
  late Animation<Offset> slideAnimationPositionUpDown;
  late Animation<Offset> slideAnimationPositionUpDownPadding;
  late Animation<Offset> slideAnimationPositionLeftRight;

  RxBool logoVisible = true.obs;
  RxBool isVisible = false.obs;
  RxBool isScaleUp = false.obs;


  // // redirection to Login
  void toLogin() {
    Get.toNamed(Routes.login);
  }

  // redirection to signup
  void toSignup() {
    Get.toNamed(Routes.signup);
  }

  @override
  void onInit() {
    super.onInit();

    scaleController = AnimationController(
      duration: const Duration(milliseconds: 1700),
      vsync: this,
    );
    scaleControllerPadding = AnimationController(
      duration: const Duration(milliseconds:2800),
      vsync: this,
    );
    startAnimations();
    final Animation<double> curvedAnimation = CurvedAnimation(
      parent: scaleController,
      curve: Curves.easeInOut,
    );
    slideAnimationPositionLeftRight = Tween<Offset>(
      begin: const Offset(-0.9, 0.0),
      end: const Offset(-0.1, 0.0),
    ).animate(scaleController);
    slideAnimationPositionUpDown = Tween<Offset>(
      begin: const Offset(0.9, 0.0),
      end: const Offset(0.0, 0.9),
    ).animate(scaleController);
    slideAnimationPositionUpDownPadding = Tween<Offset>(
      begin: const Offset(0.9, 0.0),
      end: const Offset(0.0, 0.9),
    ).animate(scaleControllerPadding);
    scaleAnimation = Tween<double>(begin: 1, end: 20).animate(curvedAnimation);
  }

  @override
  void onClose() {
    scaleController.dispose();
    scaleControllerPadding.dispose();
    super.onClose();
  }

  void startAnimations() {
    scaleController.forward();
    scaleControllerPadding.forward();
    scaleController.addListener(() {

    });
  }


  @override
  void onReady() {
    isVisible.value = true;
  }

  void openBottomSheetAfterDelay(var bottomSheetContent) {
    isScaleUp.value = true;
      Get.bottomSheet(
        enableDrag: false,
        isDismissible: false,
        elevation: 0,
        barrierColor: Colors.transparent,
        enterBottomSheetDuration: const Duration(milliseconds: 1000),
        bottomSheetContent,
        isScrollControlled: true
      );
  }
}
