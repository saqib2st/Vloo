// ignore_for_file: must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:animated_flutter_widgets/animations/ease_in_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/models/options/currency_model.dart';
import 'package:vloo/app/data/models/template/template_single_item_model.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/widgets/primary_appbar.dart';
import 'package:vloo/app/data/widgets/sub_tabs_animations_box.dart';
import 'package:vloo/app/modules/textEditing/controllers/title_editing_controller.dart';
import 'package:vloo/app/modules/textEditing/views/editing/color_edit.dart';
import 'package:vloo/app/modules/textEditing/views/editing/options_edit.dart';
import 'package:vloo/app/modules/textEditing/views/editing/themes_edit.dart';
import 'package:vloo/custom_icons.dart';

class TemplatePriceEditingView extends GetView<TitleEditingController> {
  final String? comingFrom;
  final String? orientation;
  final int? index;
  final Function(String) text;
  final Function(String) selectedPriceTheme;
  final Function(int) selectedAlignment;
  final Function(TextStyle) textStyle;
  final Function(AnimatedTextWidgetModel) animatedModel;
  final Function(CurrencyModel) selectedCurrency;
  final Function(double) fontOpacity;
  final Function(double) backgroundOpacity;
  final Function(String) selectedCurrencyFormat;

  const TemplatePriceEditingView(
      {super.key,
      required this.text,
      required this.textStyle,
      this.comingFrom,
      this.orientation,
      this.index,
      required this.fontOpacity,
      required this.backgroundOpacity,
      required this.selectedAlignment,
      required this.animatedModel,
      required this.selectedPriceTheme,
      required this.selectedCurrency,
      required this.selectedCurrencyFormat});

  Widget appliedPriceThemeAnimation(TemplateSingleItemModel templateSingleItemModel, Widget child) {
    FocusManager.instance.primaryFocus?.unfocus();

    switch (templateSingleItemModel.animation) {
      case 'AnimationDirection.none':
        return child;
      case 'AnimationDirection.appear':
        return EaseInAnimation(child: child);
      case 'AnimationDirection.left':
        return SlideInLeft(animate: true, duration: const Duration(seconds: 3), child: child);
      case 'AnimationDirection.right':
        return SlideInRight(animate: true, duration: const Duration(seconds: 3), child: child);
      case 'AnimationDirection.top':
        return SlideInUp(animate: true, duration: const Duration(seconds: 3), child: child);
      case 'AnimationDirection.down':
        return SlideInDown(animate: true, duration: const Duration(seconds: 3), child: child);
    }
    return child;
  }

  @override
  Widget build(BuildContext context) {
    bool responsiveCheck = MediaQuery.of(context).size.width >= 600 && Get.mediaQuery.orientation == Orientation.landscape;

    return WillPopScope(
      onWillPop: () async {
        Get.back();
        controller.priceEditingTabController.index = 0;
        controller.textController.clear();
        controller.resetAllView();
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PrimaryAppbar(
          title: Strings.price,
          text: Strings.confirm,
          onPressed: () {
            Get.back();
            controller.templateEditingTabController.index = 0;
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
              selectedCurrency(controller.selectedCurrencyChoice?.value ?? CurrencyModel());
              selectedCurrencyFormat(controller.selectedCurrencyFormat.value);
              selectedAlignment(controller.animatedTextWidgetModel.value.selectedTextAlignment ?? 0);
              text(controller.textController.value.text);
              selectedPriceTheme(controller.selectedPriceTheme.value);
              textStyle(CustomTextStyle.font22R.copyWith(
                  shadows: [Shadow(color: controller.animatedTextWidgetModel.value.currentBackgroundColor!.value, blurRadius: 30, offset: Offset.zero)],
                  fontSize: 32,
                  color: controller.animatedTextWidgetModel.value.currentTextColor?.value,
                  fontFamily: controller.animatedTextWidgetModel.value.fontStyle));

              if (comingFrom == Strings.editElementPrice) {
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
                  if (controller.selectedPriceTheme.value == StaticAssets.none || controller.priceEditingTabController.index == 0) {
                    return TextFormField(
                      key: controller.containerKey,
                      autofocus: true,
                      controller: controller.textController,
                      readOnly: controller.isReadOnly.value,
                      textAlign: controller.animatedTextWidgetModel.value.selectedTextAlignment == 0
                          ? TextAlign.start
                          : controller.animatedTextWidgetModel.value.selectedTextAlignment == 1
                              ? TextAlign.center
                              : TextAlign.end,
                      maxLines: 2,
                      enableSuggestions: true,
                      maxLength: 7,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                      onChanged: (value) {
                        if (!value.contains(controller.selectedCurrencyChoice?.value.currencySymbol ?? '')) {
                          controller.selectedCurrencyChoice?.value = CurrencyModel(countryCode: '', countryName: '', currencySymbol: '', isSelectedCurrency: false.obs);
                          controller.tempSymbol = '';
                        }
                        controller.comingFromMiddleFormat = false;
                      },
                      style: CustomTextStyle.font22R.copyWith(
                          backgroundColor: controller.animatedTextWidgetModel.value.currentBackgroundColor?.value,
                          wordSpacing: 20,
                          fontSize: 32,
                          color: controller.animatedTextWidgetModel.value.currentTextColor?.value,
                          fontFamily: controller.animatedTextWidgetModel.value.fontStyle),
                      decoration: InputDecoration(
                        counterStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                        border: InputBorder.none,
                        hintText: "0.00",
                        hintStyle: CustomTextStyle.font12R.copyWith(
                            shadows: [const Shadow(color: Colors.transparent, blurRadius: 30, offset: Offset.zero)],
                            fontSize: 22,
                            color: Colors.white.withOpacity(0.2),
                            fontFamily: controller.animatedTextWidgetModel.value.fontStyle),
                      ),
                    );
                  } else {
                    controller.updateTitleThemeModelState();
                    return appliedPriceThemeAnimation(controller.templateSingleItemModelForTheme.value, controller.setPriceTheme());
                  }
                }),
              ),
              Positioned(
                  top: 220.h,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 110.w),
                    child: Text(
                      'Write numbers only (no currency sign)',
                      style: CustomTextStyle.font11R,
                    ),
                  )),

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
                                  if (controller.priceEditingTabController.index == 0) {
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
                                controller: controller.priceEditingTabController,
                                tabs: [
                                  Tab(
                                      icon: SvgPicture.asset(controller.tabInnerIndex.value == 0 ? StaticAssets.icEditSelected : StaticAssets.icEdit, height: 25.h),
                                      text: Strings.edit,
                                      height: responsiveCheck ? 125.h : 72.h),
                                  const Tab(icon: Icon(FlutterCustomIcons.transitions_icon), text: Strings.transitions),
                                  const Tab(icon: Icon(Icons.local_offer_outlined), text: Strings.themes),
                                  const Tab(icon: Icon(Icons.water_drop_outlined), text: Strings.color),
                                  const Tab(icon: Icon(Icons.tune_sharp), text: Strings.options)
                                ])),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                          child: const Divider(color: AppColor.appIconBackgound, thickness: 0.8),
                        ),
                        Expanded(
                            child: TabBarView(
                                controller: controller.priceEditingTabController,
                                children: [const Text(""), SubTabsAnimationBoxWidget(comingFrom: 'price'), const ThemesEdit(), const ColorEdit(), const OptionsEdit()]))
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
