import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/modules/imageElement/controllers/image_element_controller.dart';
import 'package:vloo/app/modules/textEditing/controllers/title_editing_controller.dart';

class TransitionAnimation extends GetView<ImageElementController> {
  const TransitionAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Builder(builder: (context) {
        return Column(
          children: [
            Wrap(
              spacing: 9,
              runSpacing: 11,
              children: controller.transitionItemList
                  .asMap()
                  .entries
                  .map(
                    (e) => e.value.text == "None"
                        ? GestureDetector(
                            onTap: () {
                              controller.imageTransition.value = ImageTransitionsAndMoves.none;
                              Get.forceAppUpdate();
                            },
                            child: Container(
                              height: 70,
                              width: 180.w,
                              decoration: BoxDecoration(
                                color: AppColor.appIconBackgound,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  width: 3,
                                  color: controller.imageTransition.value == e.value.imageTransitionsAndMoves ? AppColor.appSkyBlue : AppColor.appIconBackgound,
                                ),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      e.value.imagePath ?? '',
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Text(
                                      e.value.text ?? '---',
                                      style: CustomTextStyle.font14R,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              controller.imageTransition.value = e.value.imageTransitionsAndMoves ?? ImageTransitionsAndMoves.none;
                              Get.forceAppUpdate();
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(35.w,1.h,35.w,6.h),
                              width: 180.w,
                              decoration: BoxDecoration(
                                color: AppColor.appIconBackgound,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  width: 3,
                                  color: controller.imageTransition.value == e.value.imageTransitionsAndMoves ? AppColor.appSkyBlue : AppColor.appIconBackgound,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    e.value.imagePath ?? '',
                                    height: 40,
                                    width: 60,
                                    fit: BoxFit.cover,
                                  ),
                                  Text(
                                    e.value.text ?? '---',
                                    style: CustomTextStyle.font14R,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                  )
                  .toList(),
            ),
            //),
          ],
        );
      }),
    );
  }
}
