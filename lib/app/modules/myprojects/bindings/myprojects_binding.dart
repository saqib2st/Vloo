import 'package:get/get.dart';

import '../controllers/myprojects_controller.dart';

class MyprojectsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyprojectsController>(
      () => MyprojectsController(),
    );
  }
}
