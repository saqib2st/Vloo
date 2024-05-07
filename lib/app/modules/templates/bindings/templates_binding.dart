import 'package:get/get.dart';
import 'package:vloo/app/modules/imageElement/controllers/image_element_controller.dart';

import '../controllers/templates_controller.dart';

class TemplatesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TemplatesController>(
      () => TemplatesController(),
    );


  }
}
