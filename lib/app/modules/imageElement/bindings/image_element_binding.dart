import 'package:get/get.dart';

import '../controllers/image_element_controller.dart';

class ImageElementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImageElementController>(
      () => ImageElementController(),
    );
  }
}
