import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/modules/textEditing/controllers/title_editing_controller.dart';

class SubTabsEffectBoxWidget extends GetView<TitleEditingController> {
  const SubTabsEffectBoxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Obx(
        () => Wrap(
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          runSpacing: 10,
          spacing: 10,
          children: [
            ...controller.effectsItemList.asMap().entries.map(
              (e) {
                if (e.key == 0) {
                  return GestureDetector(
                      onTap: () {
                        controller.animatedTextWidgetModel.value.selectedEffect = e.value['image'];
                        Get.forceAppUpdate();
                      },
                      child: Container(
                        height: 100.h,
                        width: 180.w,
                        decoration: BoxDecoration(
                            color: AppColor.appIconBackgound,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              width: 3,
                              color: controller.animatedTextWidgetModel.value.selectedEffect == e.value['image'] ? AppColor.appSkyBlue : AppColor.appIconBackgound,
                            )),
                        child: Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(e.value['image']),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                Strings.none,
                                style: CustomTextStyle.font14R,
                              ),
                            ],
                          ),
                        ),
                      ));
                } else {
                  return GestureDetector(
                    onTap: () {
                      controller.animatedTextWidgetModel.value.selectedEffect = e.value['image'];

                      Get.forceAppUpdate();
                    },
                    child: Container(
                      height: 100.h,
                      width: 180.w,
                      decoration: BoxDecoration(
                          color: AppColor.appIconBackgound,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            width: 3,
                            color: controller.animatedTextWidgetModel.value.selectedEffect == e.value['image'] ? AppColor.appSkyBlue : AppColor.appIconBackgound,
                          )),
                      child: Align(alignment: Alignment.center, child: Image.asset(e.value['image'])),
                    ),
                  );
                } //if
              },
            ),
          ],
        ),
      ),
    );
  }
}
