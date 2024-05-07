import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/modules/textEditing/controllers/title_editing_controller.dart';

class SubTabsAnimationBoxWidget extends GetView<TitleEditingController> {
  String comingFrom = '';

  SubTabsAnimationBoxWidget({super.key, required this.comingFrom});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Obx(
        () => comingFrom == 'price'
            ? Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                runSpacing: 10,
                spacing: 10,
                children: [
                  ...controller.transitionItemList.asMap().entries.map(
                    (e) {
                      return GestureDetector(
                        onTap: () {
                          controller.animatedTextWidgetModel.value.textTransitionModel?.transitionType = e.value.transitionType ?? TransitionType.none;
                          controller.animatedTextWidgetModel.value.textTransitionModel?.animationDirection = e.value.animationDirection ?? AnimationDirection.none;
                          controller.animatedTextWidgetModel.value.textTransitionModel?.text = e.value.text ?? 'None';
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
                                color: controller.animatedTextWidgetModel.value.textTransitionModel?.text == e.value.text ? AppColor.appSkyBlue : AppColor.appIconBackgound,
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(e.value.imagePath ?? ''),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                e.value.text ?? '---',
                                style: CustomTextStyle.font14R,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              )
            : Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                runSpacing: 10,
                spacing: 10,
                children: [
                  ...controller.transitionItemListTitle.asMap().entries.map(
                    (e) {
                      return GestureDetector(
                        onTap: () {
                          controller.animatedTextWidgetModel.value.textTransitionModel?.transitionType = e.value.transitionType ?? TransitionType.none;
                          controller.animatedTextWidgetModel.value.textTransitionModel?.animationDirection = e.value.animationDirection ?? AnimationDirection.none;
                          controller.animatedTextWidgetModel.value.textTransitionModel?.text = e.value.text ?? 'None';
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
                                color: controller.animatedTextWidgetModel.value.textTransitionModel?.text == e.value.text ? AppColor.appSkyBlue : AppColor.appIconBackgound,
                              )),
                          child: e.key == 0
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(e.value.imagePath ?? ''),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                      e.value.text ?? '---',
                                      style: CustomTextStyle.font14R,
                                    ),
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      e.value.imagePath ?? '',
                                      height: 40,
                                      width: 60,
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                      e.value.text ?? '---',
                                      style: CustomTextStyle.font14R,
                                    ),
                                  ],
                                ),
                        ),
                      );
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
