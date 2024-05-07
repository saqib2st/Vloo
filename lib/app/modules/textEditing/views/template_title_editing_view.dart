// ignore_for_file: must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:animated_flutter_widgets/animations/ease_in_animation.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:cutout_text_effect/cutout_text_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glitcheffect/glitcheffect.dart';
import 'package:neon_widgets/neon_widgets.dart';
import 'package:text_neon_widget/text_neon_widget.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/models/template/template_single_item_model.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/utils/utils.dart';
import 'package:vloo/app/data/widgets/primary_appbar.dart';
import 'package:vloo/app/modules/textEditing/controllers/title_editing_controller.dart';
import 'package:vloo/app/modules/textEditing/views/editing/animation_edit.dart';
import 'package:vloo/app/modules/textEditing/views/editing/color_edit.dart';
import 'package:vloo/app/modules/textEditing/views/editing/fonts_edit.dart';

class TemplateTitleEditingView extends GetView<TitleEditingController> {
  final String? comingFrom;
  final String? orientation;
  final int? index;
  final bool isAnimEnabled;
  final Function(String) text;
  final Function(int) selectedAlignment;
  final Function(TextStyle) textStyle;
  final Function(double) fontOpacity;
  final Function(double) backgroundOpacity;
  final Function(AnimatedTextWidgetModel) animatedModel;

  const TemplateTitleEditingView(
      {super.key,
      required this.isAnimEnabled,
      required this.fontOpacity,
      required this.backgroundOpacity,
      required this.text,
      required this.textStyle,
      this.comingFrom,
      this.orientation,
      this.index,
      required this.selectedAlignment,
      required this.animatedModel});

  Widget textWidget(TemplateSingleItemModel templateSingleItemModel) {
    return AutoSizeTextField(
      autofocus: true,
      controller: controller.textController,
      readOnly: controller.isReadOnly.value,
      textAlign: controller.animatedTextWidgetModel.value.selectedTextAlignment == 0
          ? TextAlign.start
          : controller.animatedTextWidgetModel.value.selectedTextAlignment == 1
              ? TextAlign.center
              : TextAlign.end,
      maxLines: 1,
      enableSuggestions: true,
      maxLength: 50,
      keyboardType: TextInputType.text,
      style: CustomTextStyle.font22R.copyWith(
          height: 1.0,
          fontWeight: FontWeight.w600,
          background: Paint()
            ..strokeWidth = 30.0
            ..color = controller.animatedTextWidgetModel.value.currentBackgroundColor!.value
            ..style = PaintingStyle.stroke
            ..strokeJoin = StrokeJoin.miter,
          fontSize: 20,
          color: controller.animatedTextWidgetModel.value.currentTextColor?.value,
          fontFamily: controller.animatedTextWidgetModel.value.fontStyle),
      decoration: InputDecoration(
          counterStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
          border: InputBorder.none,
          hintText: "Add Text Here",
          hintStyle: CustomTextStyle.font12R.copyWith(
              shadows: [const Shadow(color: Colors.transparent, blurRadius: 30, offset: Offset.zero)],
              fontSize: 20,
              color: Colors.white.withOpacity(0.2),
              fontFamily: controller.animatedTextWidgetModel.value.fontStyle)),
    );
  }

  Widget appliedEffectWidget(TemplateSingleItemModel templateSingleItemModel) {
    if (isAnimEnabled) {
      switch (templateSingleItemModel.effect) {
        case StaticAssets.noneIcon:
          return textWidget(templateSingleItemModel);
        case StaticAssets.effectNeon:
          return PTTextNeon(
            levelNeon: NeonLevel.highLevelNeon,
            text: templateSingleItemModel.valueLocal ?? "",
            color: Utils.fetchMaterialColorFromStringColor(templateSingleItemModel.textColor),
            font: templateSingleItemModel.fontFamily,
            shine: true,
            fontSize: templateSingleItemModel.fontSize,
            strokeWidthTextHigh: 3,
            blurRadius: 1,
            strokeWidthTextLow: 1,
            backgroundColor: Utils.fetchMaterialColorFromStringColor(templateSingleItemModel.backgroundColor),
          );
        case StaticAssets.effectGlitch:
          return GlitchEffect(
            child: textWidget(templateSingleItemModel),
          );
        case StaticAssets.effectFade:
          return DefaultTextStyle(
            style: TextStyle(
              fontFamily: templateSingleItemModel.fontFamily,
              fontSize: templateSingleItemModel.fontSize,
              color: Utils.fetchColorFromStringColor(templateSingleItemModel.textColor),
              shadows: [Shadow(color: Utils.fetchColorFromStringColor(templateSingleItemModel.backgroundColor), blurRadius: 30, offset: Offset.zero)],
            ),
            child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [
                FadeAnimatedText(duration: const Duration(milliseconds: 1500), templateSingleItemModel.valueLocal ?? ""),
              ],
              onTap: () {
                print("Tap Event");
              },
            ),
          );
        case StaticAssets.effectCut:
          return CustomPaint(
            painter: CutOutText(
              text: templateSingleItemModel.valueLocal ?? "",
              boxRadius: 10,
              boxBackgroundColor: Utils.fetchColorFromStringColor(templateSingleItemModel.backgroundColor),
              textStyle: TextStyle(
                fontFamily: templateSingleItemModel.fontFamily,
                fontSize: templateSingleItemModel.fontSize,
                color: Utils.fetchColorFromStringColor(templateSingleItemModel.textColor),
                shadows: [Shadow(color: Utils.fetchColorFromStringColor(templateSingleItemModel.backgroundColor), blurRadius: 30, offset: Offset.zero)],
                backgroundColor: AppColor.transparent,
              ),
            ),
          );
        case StaticAssets.effectBlink:
          return FlickerNeonText(
            fontFamily: templateSingleItemModel.fontFamily,
            textColor: Utils.fetchColorFromStringColor(templateSingleItemModel.textColor),
            textAlign: templateSingleItemModel.selectedAlignment == 0
                ? TextAlign.start
                : templateSingleItemModel.selectedAlignment == 1
                    ? TextAlign.center
                    : TextAlign.end,
            text: templateSingleItemModel.valueLocal ?? "",
            flickerTimeInMilliSeconds: 1200,
            spreadColor: Utils.fetchColorFromStringColor(templateSingleItemModel.backgroundColor),
            blurRadius: 20,
            textSize: templateSingleItemModel.fontSize ?? 0,
          );
      }
    }
    return textWidget(templateSingleItemModel);
  }

  Widget appliedAnimationWidget(TemplateSingleItemModel templateSingleItemModel) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (isAnimEnabled) {
      switch (templateSingleItemModel.animation) {
        case 'AnimationDirection.none':
          return appliedEffectWidget(templateSingleItemModel);
        case 'AnimationDirection.appear':
          return EaseInAnimation(child: appliedEffectWidget(templateSingleItemModel));
        case 'AnimationDirection.left':
          return SlideInLeft(animate: true, duration: const Duration(seconds: 1), child: appliedEffectWidget(templateSingleItemModel));
        case 'AnimationDirection.right':
          return SlideInRight(animate: true, duration: const Duration(seconds: 1), child: appliedEffectWidget(templateSingleItemModel));
        case 'AnimationDirection.top':
          return SlideInUp(animate: true, duration: const Duration(seconds: 1), child: appliedEffectWidget(templateSingleItemModel));
        case 'AnimationDirection.down':
          return SlideInDown(animate: true, duration: const Duration(seconds: 1), child: appliedEffectWidget(templateSingleItemModel));
      }
    }
    return appliedEffectWidget(templateSingleItemModel);
  }

  @override
  Widget build(BuildContext context) {
    bool responsiveCheck = MediaQuery.of(context).size.width >= 600 && Get.mediaQuery.orientation == Orientation.landscape;

    return WillPopScope(
      onWillPop: () async {
        Get.back();
        controller.templateEditingTabController?.index = 0;
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
          text: Strings.confirm,
          onPressed: () {
            Get.back();
            controller.templateEditingTabController?.index = 0;
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

              if (comingFrom == Strings.editElementTitle || comingFrom == Strings.editElementDescription || comingFrom == Strings.editElementPrice) {
                await controller.templatesController.onPressEditItem(comingFrom ?? '', orientation ?? '', index ?? 0);
              } else {
                await controller.templatesController.onPressAddItem(comingFrom ?? '', orientation ?? '');
                Get.back();
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
                  return !controller.isReadOnly.value
                      ? AutoSizeTextField(
                          key: controller.containerKey,
                          autofocus: true,
                          controller: controller.textController,
                          readOnly: controller.isReadOnly.value,
                          textAlign: controller.animatedTextWidgetModel.value.selectedTextAlignment == 0
                              ? TextAlign.start
                              : controller.animatedTextWidgetModel.value.selectedTextAlignment == 1
                                  ? TextAlign.center
                                  : TextAlign.end,
                          maxLines: 1,
                          enableSuggestions: true,
                          maxLength: 50,
                          keyboardType: TextInputType.text,
                          style: CustomTextStyle.font22R.copyWith(
                              height: 1.0,
                              background: Paint()
                                ..strokeWidth = 30.0
                                ..color = controller.animatedTextWidgetModel.value.currentBackgroundColor!.value
                                ..style = PaintingStyle.stroke
                                ..strokeJoin = StrokeJoin.miter,
                              fontSize: 20,
                              color: controller.animatedTextWidgetModel.value.currentTextColor?.value,
                              fontFamily: controller.animatedTextWidgetModel.value.fontStyle),
                          decoration: InputDecoration(
                            counterStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                            border: InputBorder.none,
                            hintText: "Add Text Here",
                            hintStyle: CustomTextStyle.font12R.copyWith(
                                shadows: [const Shadow(color: Colors.transparent, blurRadius: 30, offset: Offset.zero)],
                                fontSize: 22,
                                color: Colors.white.withOpacity(0.2),
                                fontFamily: controller.animatedTextWidgetModel.value.fontStyle),
                          ),
                        )
                      : appliedAnimationWidget(
                          TemplateSingleItemModel(
                            selectedAlignment: controller.animatedTextWidgetModel.value.selectedTextAlignment,
                            valueLocal: controller.textController.value.text,
                            fontSize: 40,
                            fontFamily: controller.animatedTextWidgetModel.value.fontStyle,
                            textColor: controller.animatedTextWidgetModel.value.currentTextColor!.value.value.toRadixString(16),
                            backgroundColor: controller.animatedTextWidgetModel.value.currentBackgroundColor!.value.value.toRadixString(16),
                            animation: controller.animatedTextWidgetModel.value.textTransitionModel?.animationDirection.toString() ?? TransitionType.none.toString(),
                            effect: controller.animatedTextWidgetModel.value.selectedEffect,
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
                                  if (controller.templateEditingTabController?.index == 0) {
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
                                controller: controller.templateEditingTabController,
                                tabs: [
                                  Tab(
                                      icon: SvgPicture.asset(controller.tabInnerIndex.value == 0 ? StaticAssets.icEditSelected : StaticAssets.icEdit, height: 25.h),
                                      text: Strings.edit,
                                      height: responsiveCheck ? 125.h : 72.h),
                                  Tab(
                                      icon: SvgPicture.asset(controller.tabInnerIndex.value == 1 ? StaticAssets.icAnimationSelected : StaticAssets.icAnimation, height: 25.h),
                                      text: Strings.animations,
                                      height: responsiveCheck ? 125.h : 72.h),
                                  Tab(
                                      icon: SvgPicture.asset(controller.tabInnerIndex.value == 2 ? StaticAssets.icFontSelected : StaticAssets.icFont, height: 25.h),
                                      text: Strings.font,
                                      height: responsiveCheck ? 125.h : 70.h),
                                  Tab(icon: const Icon(Icons.water_drop_outlined), text: Strings.color, height: responsiveCheck ? 125.h : 72.h)
                                ])),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                          child: const Divider(color: AppColor.appIconBackgound, thickness: 0.8),
                        ),
                        Expanded(child: TabBarView(controller: controller.templateEditingTabController, children: [const Text(""), const AnimationEdit(), FontsEdit(), const ColorEdit()]))
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
