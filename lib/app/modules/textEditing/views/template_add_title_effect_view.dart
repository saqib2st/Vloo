// ignore_for_file: must_be_immutable

// import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/utils/utils.dart';
import 'package:vloo/app/data/widgets/primary_appbar.dart';
import 'package:vloo/app/modules/templates/controllers/templates_controller.dart';
import 'package:vloo/app/modules/templates/views/drag_and_resize.dart';
import 'package:vloo/app/modules/textEditing/controllers/title_editing_controller.dart';

class TemplateAddTitleEffectView extends GetView<TitleEditingController> {
  final String? comingFrom;
  final String? orientation;
  final int? index;
  final Function(AnimatedTextWidgetModel) animatedModel;

  const TemplateAddTitleEffectView({super.key,  this.comingFrom, this.orientation, this.index, required this.animatedModel});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.off(()=> const DragAndResizeView());
        controller.templateEditingTabController.index = 0;
        controller.textController.clear();
        controller.resetAllView();
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PrimaryAppbar(
          title: Utils.appBarTitle(
                comingFrom ?? "",
              ) ??
              "",
          onPressed: () {
            Get.back();
            controller.templateEditingTabController.index = 0;
            controller.textController.clear();
            controller.resetAllView();
          },
        ),
        body: Container(
          color: AppColor.primaryDarkColor,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                    padding: const EdgeInsets.all(5.0).copyWith(top: 8),
                    height: 700.h,
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
                            SvgPicture.asset(StaticAssets.iconEffects, colorFilter: const ColorFilter.mode(AppColor.appLightBlue, BlendMode.srcIn), width: 25.w, height: 25.h),
                            SizedBox(width: 5.w),
                            Text(
                              Strings.effects,
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
                                                  animatedModel(controller.animatedTextWidgetModel.value);
                                                  // Get.back();
                                                  Get.find<TemplatesController>().toTitleElementView(orientation??'', comingFrom??'', index);
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
                                                animatedModel(controller.animatedTextWidgetModel.value);
                                                Get.find<TemplatesController>().toTitleElementView(orientation??'', comingFrom??'', index);
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
                                  //),
                                ],
                              );
                            }),
                          ),
                        ),
                      ],
                    )),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: SizedBox(
                  height: 117.h,
                  child: Container(
                    height: 117,
                    decoration: const ShapeDecoration(
                      color: AppColor.primaryDarkColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        side: BorderSide(
                          color: AppColor.transparent,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                          controller.templateEditingTabController.index = 0;
                          controller.textController.clear();
                          controller.resetAllView();
                        },
                        child: const Text(
                          Strings.cancel,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
