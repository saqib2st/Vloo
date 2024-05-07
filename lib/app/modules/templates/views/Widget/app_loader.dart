import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppLoader {
  static void showLoader() {
    Get.generalDialog(pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }

  static void hideLoader() {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }
}
