import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/modules/textEditing/controllers/title_editing_controller.dart';

class SubTabsFontsBoxWidget extends GetView<TitleEditingController> {
  const SubTabsFontsBoxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Wrap(
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        runSpacing: 10,
        spacing: 10,
        children: [
          ...controller.fontsList.asMap().entries.map(
                (e) => GestureDetector(
                    onTap: () {
                      controller.animatedTextWidgetModel.value.fontStyle = e.value.entries.first.value;
                      Get.forceAppUpdate();
                    },
                    child: Obx(
                      () => Container(
                        height: 100.h,
                        width: 180.w,
                        decoration: BoxDecoration(
                          color: AppColor.appIconBackgound,
                          border: Border.all(
                            color: controller.animatedTextWidgetModel.value.fontStyle == e.value.entries.first.value
                                ? AppColor.appSkyBlue // Active border color
                                : Colors.transparent, // Inactive border color
                            width: 4.w,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              e.value.entries.first.key,
                              style: CustomTextStyle.font16R.copyWith(fontFamily: e.value.entries.first.value),
                              textAlign: TextAlign.center,
                            )),
                      ),
                    )),
              ),
        ],
      ),
    );
  }
}
