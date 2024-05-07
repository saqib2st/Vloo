import 'package:get/get.dart';

import '../controllers/title_editing_controller.dart';

class TextEditingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TitleEditingController>(
      () => TitleEditingController(),
    );
  }
}
