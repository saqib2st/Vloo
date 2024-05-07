import 'package:get/get.dart';

import '../controllers/myscreens_controller.dart';

class MyscreensBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyscreensController>(
      () => MyscreensController(),
    );
  }
}
