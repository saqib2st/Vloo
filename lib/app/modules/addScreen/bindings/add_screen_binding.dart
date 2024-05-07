import 'package:get/get.dart';

import '../controllers/add_screen_controller.dart';

class AddScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddScreenController>(
      () => AddScreenController(),
    );
  }
}
