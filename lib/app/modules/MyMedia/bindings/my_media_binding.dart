import 'package:get/get.dart';

import '../controllers/my_media_controller.dart';

class MyMediaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyMediaController>(
      () => MyMediaController(),
    );
  }
}
