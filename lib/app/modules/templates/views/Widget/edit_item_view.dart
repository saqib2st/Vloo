import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vloo/app/modules/templates/controllers/templates_controller.dart';

class EditItemView extends GetView<TemplatesController> {
  const EditItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: const Text('Edit Item View'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            TextField(
              controller: controller.titleController,
              decoration: const InputDecoration(hintText: 'Enter Title'),
            ),
            TextField(
              controller: controller.prizeController,
              decoration: const InputDecoration(hintText: 'Enter Prize'),
            ),
            const SizedBox(
              height: 30,
            ),
            // ElevatedButton(
            //     onPressed: () => controller.onPressAddItem(),
            //     child: const Text('Add'))
          ],
        ),
      ),
    );
  }
}
