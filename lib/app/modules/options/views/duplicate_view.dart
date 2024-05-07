import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/widgets/custom_buttons.dart';
import 'package:vloo/app/data/widgets/primary_appbar.dart';
import 'package:vloo/app/modules/templates/controllers/templates_controller.dart';

class DuplicateView extends GetView<TemplatesController> {
  String orientation;
   DuplicateView({super.key, required this.orientation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: PrimaryAppbar(
        title: Strings.duplicate,
        text: Strings.confirm,
        onPressed: () {
          Get.back();
        },
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Strings.duplicationDone,
              style: CustomTextStyle.font16R.copyWith(color: AppColor.appLightBlue, fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () async{
                Get.close(2);

                await controller.templateListUpdate();
                if(orientation == OrientationType.Portrait.name){
                controller.toCreateTemplateView(OrientationType.Portrait.name, Strings.editTemplate, controller.fetchFilteredList("Portrait")?[0]);
                }else{
                controller.toCreateTemplateViewLandScape(OrientationType.Landscape.name, Strings.editTemplate, controller.fetchFilteredList("Landscape")?[0]);
                }
              },
              child: CustomButton(
                buttonName: Strings.openDuplicateProject,
                type: ButtonVariant.bordered,
                width: Get.width * 0.7,
                height: Get.width * 0.12,
                color: AppColor.appLightBlue,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Get.close(2);
              },
              child: CustomButton(
                buttonName: Strings.stayOnCurrentProject,
                type: ButtonVariant.bordered,
                width: Get.width * 0.7,
                height: Get.width * 0.12,
                color: AppColor.appLightBlue,
              ),
            )
          ],
        ),
      ),
    );
  }
}
