import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/widgets/primary_appbar.dart';
import 'package:vloo/app/modules/imageElement/controllers/image_element_controller.dart';
import 'package:vloo/app/modules/imageElement/views/animations/move_animations.dart';
import 'package:vloo/app/modules/imageElement/views/animations/transition_animations.dart';
import 'package:vloo/app/modules/imageElement/views/availability.dart';
import 'package:vloo/app/modules/imageElement/views/image_content.dart';
import 'package:vloo/app/modules/templates/views/Widget/app_loader.dart';
import 'package:vloo/app/modules/templates/views/drag_and_resize.dart';
import 'package:vloo/app/routes/app_pages.dart';

class AddImageMovesScreen extends GetView<ImageElementController> {
  const AddImageMovesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppbar(
        title: Strings.chooseMove,
        onPressed: () {
          Get.back();
        },
      ),
      body: Container(
        color: AppColor.primaryDarkColor,
        child: Stack(
          children: [
            // Main content of the container
            const Positioned.fill(
              child: Center(
                child: ImageContent(isAnimEnabled: false),
              ),
            ),
            // Small window at the bottom

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(5.0).copyWith(top: 8),
                height: 500.h,
                decoration: BoxDecoration(
                    color: AppColor.primaryDarkColor,
                    border: const Border(
                      top: BorderSide(width: 2.0, color: AppColor.appSkyBlue), // Top border
                      right: BorderSide.none, // No border on the right
                      bottom: BorderSide.none, // No border on the bottom
                      left: BorderSide.none, // No border on the left
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.sp),
                      topRight: Radius.circular(20.sp),
                    )),
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(StaticAssets.moveIcon, colorFilter: const ColorFilter.mode(AppColor.appLightBlue, BlendMode.srcIn), width: 25.w, height: 25.h),
                        SizedBox(width: 5.w),
                        Text(
                          Strings.moves,
                          textAlign: TextAlign.center,
                          style: CustomTextStyle.font20R,
                        )
                      ],
                    ),
                    SizedBox(height: 30.h),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Builder(builder: (context) {
                          return Column(
                            children: [
                              Wrap(
                                spacing: 9,
                                runSpacing: 11,
                                children: controller.movesItemList
                                    .asMap()
                                    .entries
                                    .map(
                                      (e) => e.value.text == 'None'
                                          ? GestureDetector(
                                              onTap: () {
                                                controller.imageMove.value = ImageTransitionsAndMoves.none;
                                                Get.back();
                                                controller.onGoingBackFromImage();
                                              },
                                              child: Container(
                                                height: 70,
                                                width: 180.w,
                                                decoration: BoxDecoration(
                                                  color: AppColor.appIconBackgound,
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  border: Border.all(
                                                    width: 3,
                                                    color: controller.imageMove.value == e.value.imageTransitionsAndMoves ? AppColor.appSkyBlue : AppColor.appIconBackgound,
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
                                                controller.imageMove.value = e.value.imageTransitionsAndMoves ?? ImageTransitionsAndMoves.none;
                                                Get.back();
                                                controller.onGoingBackFromImage();
                                              },
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(35.w,1.h,35.w,6.h),
                                                width: 180.w,
                                                decoration: BoxDecoration(
                                                  color: AppColor.appIconBackgound,
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  border: Border.all(
                                                    width: 3,
                                                    color: controller.imageMove.value == e.value.imageTransitionsAndMoves ? AppColor.appSkyBlue : AppColor.appIconBackgound,
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
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
