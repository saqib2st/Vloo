import 'package:get/get.dart';

import '../controllers/layers_controller.dart';

class LayersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LayersController>(
      () => LayersController(),
    );
  }
}
