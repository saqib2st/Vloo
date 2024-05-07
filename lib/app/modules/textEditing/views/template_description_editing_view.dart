// ignore_for_file: must_be_immutable

import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/models/template/template_single_item_model.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/widgets/primary_appbar.dart';
import 'package:vloo/app/modules/textEditing/controllers/title_editing_controller.dart';
import 'package:vloo/app/modules/textEditing/views/editing/color_edit.dart';
import 'package:vloo/app/modules/textEditing/views/editing/fonts_edit.dart';

class TemplateDescriptionEditingView extends GetView<TitleEditingController> {
  final String? comingFrom;
  final String? orientation;
  final int? index;
  final Function(String) text;
  final Function(int) selectedAlignment;
  final Function(TextStyle) textStyle;
  final Function(double) fontOpacity;
  final Function(double) backgroundOpacity;
  final Function(AnimatedTextWidgetModel) animatedModel;

  const TemplateDescriptionEditingView(
      {super.key,
      required this.text,
      required this.textStyle,
      this.comingFrom,
      this.orientation,
      this.index,
      required this.fontOpacity,
      required this.backgroundOpacity,
      required this.selectedAlignment,
      required this.animatedModel});

  @override
  Widget build(BuildContext context) {
    bool responsiveCheck = MediaQuery.of(context).size.width >= 600 && Get.mediaQuery.orientation == Orientation.landscape;

    return WillPopScope(
      onWillPop: () async {
        Get.back();
        controller.descriptionEditingTabController.index = 0;
        controller.textController.clear();
        controller.resetAllView();
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PrimaryAppbar(
          title: Strings.description,
          text: Strings.confirm,
          onPressed: () {
            Get.back();
            controller.textController.clear();
            controller.resetAllView();
          },
          onPressed2: () async {
            if (controller.textController.value.text.isEmpty) {
              FocusManager.instance.primaryFocus?.unfocus();
            } else {
              fontOpacity(controller.opacityFontValue.value);
              backgroundOpacity(controller.opacityBGValue.value);
              animatedModel(controller.animatedTextWidgetModel.value);
              selectedAlignment(controller.animatedTextWidgetModel.value.selectedTextAlignment ?? 0);
              text(controller.textController.value.text);
              textStyle(CustomTextStyle.font22R.copyWith(
                  shadows: [Shadow(color: controller.animatedTextWidgetModel.value.currentBackgroundColor!.value, blurRadius: 30, offset: Offset.zero)],
                  fontSize: 32,
                  color: controller.animatedTextWidgetModel.value.currentTextColor?.value,
                  fontFamily: controller.animatedTextWidgetModel.value.fontStyle));

              if (comingFrom == Strings.editElementDescription) {
                await controller.templatesController.onPressEditItem(comingFrom ?? '', orientation ?? '', index ?? 0);
              } else {
                await controller.templatesController.onPressAddItem(comingFrom ?? '', orientation ?? '');
              }
            }
            controller.resetAllView();
          },
        ),
        body: Container(
          color: AppColor.primaryDarkColor,
          child: Stack(
            children: [
              Positioned(
                left: 80.w,
                right: 80.w,
                top: 70.h,
                child: Obx(() {
                  return AutoSizeTextField(
                    controller: controller.textController,
                    key: controller.containerKey,
                    autofocus: true,
                    readOnly: controller.isReadOnly.value,
                    textAlign: controller.animatedTextWidgetModel.value.selectedTextAlignment == 0
                        ? TextAlign.start
                        : controller.animatedTextWidgetModel.value.selectedTextAlignment == 1
                            ? TextAlign.center
                            : TextAlign.end,
                    maxLines: 1,
                    enableSuggestions: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                        fontFamily: controller.animatedTextWidgetModel.value.fontStyle,
                        color: controller.animatedTextWidgetModel.value.currentTextColor?.value,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        background: Paint()
                          ..strokeWidth = 30.0
                          ..color = controller.animatedTextWidgetModel.value.currentBackgroundColor!.value
                          ..style = PaintingStyle.stroke
                          ..strokeJoin = StrokeJoin.miter),

                    decoration: InputDecoration(
                      counterStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                      border: InputBorder.none,
                      hintText: Strings.addTextHere,
                      hintStyle: CustomTextStyle.font12R.copyWith(
                          shadows: [const Shadow(color: Colors.transparent, blurRadius: 30, offset: Offset.zero)],
                          fontSize: 22,
                          color: Colors.white.withOpacity(0.2),
                          fontFamily: controller.animatedTextWidgetModel.value.fontStyle),
                    ),
                  );
                }),
              ),

              // Small window at the bottom
              Positioned(
                  left: 0.w,
                  right: 0.w,
                  bottom: 0.h,
                  child: Container(
                    padding: EdgeInsets.only(top: 10.h),
                    height: 550.h,
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
                        Obx(() => TabBar(
                                onTap: (val) {
                                  controller.tabInnerIndex.value = val;
                                  if (controller.descriptionEditingTabController.index == 0) {
                                    controller.isReadOnly.value = false;
                                  } else {
                                    controller.isReadOnly.value = true;
                                  }
                                },
                                dividerColor: AppColor.transparent,
                                indicatorSize: TabBarIndicatorSize.tab,
                                indicatorPadding: EdgeInsets.fromLTRB(8.w, 0, 8.w, 0.h),
                                labelPadding: EdgeInsets.only(bottom: 0.h),
                                indicatorWeight: 4,
                                labelColor: AppColor.appSkyBlue,
                                indicatorColor: AppColor.appSkyBlue,
                                unselectedLabelColor: AppColor.hintTextColor,
                                labelStyle: CustomTextStyle.font11R,
                                controller: controller.descriptionEditingTabController,
                                tabs: [
                                  Tab(
                                      icon: SvgPicture.asset(controller.tabInnerIndex.value == 0 ? StaticAssets.icEditSelected : StaticAssets.icEdit, height: 25.h),
                                      text: Strings.edit,
                                      height: responsiveCheck ? 125.h : 72.h),
                                  Tab(
                                      icon: SvgPicture.asset(controller.tabInnerIndex.value == 1 ? StaticAssets.icFontSelected : StaticAssets.icFont, height: 25.h),
                                      text: Strings.font,
                                      height: responsiveCheck ? 125.h : 70.h),
                                  const Tab(icon: Icon(Icons.water_drop_outlined), text: Strings.color)
                                ])),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                          child: const Divider(color: AppColor.appIconBackgound, thickness: 0.8),
                        ),
                        Expanded(child: TabBarView(controller: controller.descriptionEditingTabController, children: [const Text(""), FontsEdit(), const ColorEdit()]))
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
