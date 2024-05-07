import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vloo/app/modules/addScreen/controllers/add_screen_controller.dart';

import 'transfer_complete.dart';
import 'transfering.dart';

class TransferParent extends GetView<AddScreenController> {
  const TransferParent({super.key});

  @override
  Widget build(BuildContext context) {
    return   Center(
      child: Obx(() {
        // Use Obx to observe changes in showFirstWidget
        if (controller.showFirstWidget.value) {
          return const TransferView();
        } else {
          return const TransferCompleteView();
        }
      }),
    );
  }
}
