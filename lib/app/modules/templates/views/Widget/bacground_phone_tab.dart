import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/widgets/icon_text.dart';
import 'package:vloo/app/modules/imageElement/controllers/image_element_controller.dart';
import 'package:vloo/app/modules/imageElement/views/image_screen.dart';
import 'package:vloo/app/modules/templates/controllers/templates_controller.dart';
import 'package:vloo/app/modules/templates/views/drag_and_resize.dart';
import 'package:vloo/app/routes/app_pages.dart';

class BackgroundPhoneTab extends GetView<TemplatesController> {
  const BackgroundPhoneTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 45, 30, 0),
        child: Row(
          children: [
            GestureDetector(
              onTap: () async {
                String? selectedImagePath =
                    await controller.selectImageFromGallery();
                if (selectedImagePath != null) {
                  controller.backgroundImage.value = selectedImagePath;
                  Get.back();

                }
              },
              child: const IconText(
                iconPath: StaticAssets.dropDownIcon,
                text: Strings.recents,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () async {
                String? selectedImagePath =
                    await controller.selectImageFromCamera();
                if (selectedImagePath != null) {
                  controller.backgroundImage.value = selectedImagePath;
                  Get.back();
                }
              },
              child: const IconText(
                iconPath: StaticAssets.cameraIcon,
                text: Strings.takePicture,
                height: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
