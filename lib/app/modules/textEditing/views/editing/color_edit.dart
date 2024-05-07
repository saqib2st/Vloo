import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/modules/textEditing/controllers/title_editing_controller.dart';

class ColorEdit extends GetView<TitleEditingController> {
  const ColorEdit({super.key});

  bool compare(Color color1, Color color2) {
    return color1.red == color2.red && color1.green == color2.green && color1.blue == color2.blue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: controller.tabsList
                .asMap()
                .entries
                .map(
                  (e) => IconButton(
                    constraints: const BoxConstraints(minHeight: 60, minWidth: 90),
                    onPressed: () {
                      controller.selectedColorTab.value = e.key;
                      if (controller.selectedColorTab.value == 0) {
                      } else if (controller.selectedColorTab.value == 1) {}
                    },
                    icon: Column(
                      children: [
                        Text(
                          e.value['text'],
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: controller.selectedColorTab.value == e.key ? AppColor.appSkyBlue : AppColor.hintTextColor,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          color: controller.selectedColorTab.value == e.key ? AppColor.appSkyBlue : AppColor.transparent,
                          height: 2,
                          width: 13,
                        )
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        Obx(
          () => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.isPickerColor.value = false;
                    Get.dialog(
                      AlertDialog(
                        title: const Text(Strings.pickAColor),
                        content: SingleChildScrollView(
                          child: ColorPicker(
                            pickerColor: controller.selectedColorTab.value == 0
                                ? (controller.animatedTextWidgetModel.value.currentTextColor?.value ?? const Color(0xffFFFFFF))
                                : (controller.animatedTextWidgetModel.value.currentBackgroundColor?.value ?? Colors.transparent),
                            onColorChanged: controller.changeColor,
                            hexInputBar: true,
                          ),
                        ),
                        actions: <Widget>[
                          ElevatedButton(
                            child: const Text(Strings.gotIt),
                            onPressed: () {
                              if (controller.selectedColorTab.value == 0) {
                                controller.addColor(controller.animatedTextWidgetModel.value.currentTextColor.toString());
                                controller.animatedTextWidgetModel.value.currentTextColor = controller.animatedTextWidgetModel.value.currentTextColor;
                              } else {
                                controller.animatedTextWidgetModel.value.currentBackgroundColor = controller.animatedTextWidgetModel.value.currentBackgroundColor;
                                controller.addColor(controller.animatedTextWidgetModel.value.currentBackgroundColor.toString());
                              }

                              Get.back();
                              controller.setColorList();
                              Get.forceAppUpdate();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  child: SvgPicture.asset(
                    StaticAssets.colorPick,
                    width: 45,
                    height: 45,
                  ),
                ),
                ...controller.colorsList.asMap().entries.map((e) {
                  if (e.key == 0) {
                    if (controller.selectedColorTab.value == 1) {
                      return GestureDetector(
                        onTap: () {
                          controller.animatedTextWidgetModel.value.currentBackgroundColor?.value = controller.colorsList[e.key];
                          controller.isPickerColor.value = true;
                          Get.forceAppUpdate();
                        },
                        child: SvgPicture.asset(
                          StaticAssets.none,
                          width: 33,
                          height: 33,
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  } else {
                    if (controller.selectedColorTab.value == 0) {
                      return GestureDetector(
                        onTap: () {
                          controller.animatedTextWidgetModel.value.currentTextColor?.value = controller.colorsList[e.key];
                          controller.isPickerColor.value = true;
                          Get.forceAppUpdate();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: e.value, width: 2)),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: compare(controller.animatedTextWidgetModel.value.currentTextColor!.value, e.value) && controller.isPickerColor.value ? e.value : Colors.transparent)),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return GestureDetector(
                        onTap: () {
                          controller.animatedTextWidgetModel.value.currentBackgroundColor?.value = controller.colorsList[e.key];
                          controller.isPickerColor.value = true;
                          Get.forceAppUpdate();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: e.value, width: 2)),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: compare(e.value, controller.animatedTextWidgetModel.value.currentBackgroundColor?.value ?? Colors.transparent) && controller.isPickerColor.value
                                          ? controller.animatedTextWidgetModel.value.currentBackgroundColor?.value
                                          : Colors.transparent)),
                            ),
                          ),
                        ),
                      );
                    }
                  }
                })
              ],
            ),
          ),
        ),
        Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        Strings.opacity,
                        style: CustomTextStyle.font16R.copyWith(color: AppColor.white, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Text(
                      '${((controller.selectedColorTab.value == 1) ? controller.opacityBGValue.value * 100 : controller.opacityFontValue.value * 100).toInt()}%',
                      style: CustomTextStyle.font16R.copyWith(color: AppColor.white, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                SliderTheme(
                  data: SliderThemeData(
                      trackHeight: 2,
                      trackShape: const RoundedRectSliderTrackShape(),
                      overlayShape: SliderComponentShape.noOverlay,
                      activeTrackColor: Color.fromRGBO(255, 255, 255, (controller.selectedColorTab.value == 1) ? controller.opacityBGValue.value : controller.opacityFontValue.value),
                      inactiveTrackColor: AppColor.white,
                      thumbColor: AppColor.trackWhite,
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12)),
                  child: Slider(
                    value: (controller.selectedColorTab.value == 1) ? controller.opacityBGValue.value : controller.opacityFontValue.value,
                    onChanged: (val) {
                      if (controller.selectedColorTab.value == 1) {
                        controller.elementModel?.backgroundOpacity = val;
                        controller.opacityBGValue.value = val;
                        Color myColor = controller.animatedTextWidgetModel.value.currentBackgroundColor?.value ?? AppColor.white;
                        controller.animatedTextWidgetModel.value.currentBackgroundColor?.value = Color.fromRGBO(myColor.red, myColor.green, myColor.blue, controller.opacityBGValue.value);
                      } else {
                        controller.elementModel?.fontOpacity = val;
                        controller.opacityFontValue.value = val;
                        Color myColor = controller.animatedTextWidgetModel.value.currentTextColor?.value ?? AppColor.white;
                        controller.animatedTextWidgetModel.value.currentTextColor?.value = Color.fromRGBO(myColor.red, myColor.green, myColor.blue, controller.opacityFontValue.value);
                      }
                    },
                  ),
                ),
               if (controller.colorList.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    Strings.recentColor,
                    style: CustomTextStyle.font16R.copyWith(color: AppColor.white, fontWeight: FontWeight.w400),
                  ),
                ),
                SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: [
                    ...controller.colorList.asMap().entries.map((e) => InkWell(
                      onTap: () {
                        if (controller.selectedColorTab.value == 0) {
                          controller.animatedTextWidgetModel.value.currentTextColor?.value = Color(int.parse(e.value.split('(').last.split(')').first.replaceAll('0x', ''), radix: 16));
                          controller.isPickerColor.value = true;
                          Get.forceAppUpdate();
                        } else {
                          controller.animatedTextWidgetModel.value.currentBackgroundColor?.value = Color(int.parse(e.value.split('(').last.split(')').first.replaceAll('0x', ''), radix: 16));
                          controller.isPickerColor.value = true;
                          Get.forceAppUpdate();
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 15.w),
                        padding:  EdgeInsets.all(5.0.w),
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, border: Border.all(color: Color(int.parse(e.value.split('(').last.split(')').first.replaceAll('0x', ''), radix: 16)), width: 2),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                          controller.selectedColorTab.value == 0?
                          (compare(Color(int.parse(e.value.split('(').last.split(')').first.replaceAll('0x', ''), radix: 16)), controller.animatedTextWidgetModel.value.currentTextColor?.value ?? Colors.transparent) && controller.isPickerColor.value
                              ? controller.animatedTextWidgetModel.value.currentTextColor?.value
                              : Colors.transparent)
                          :
                          (compare(Color(int.parse(e.value.split('(').last.split(')').first.replaceAll('0x', ''), radix: 16)), controller.animatedTextWidgetModel.value.currentBackgroundColor?.value ?? Colors.transparent) && controller.isPickerColor.value
                              ? controller.animatedTextWidgetModel.value.currentBackgroundColor?.value
                              : Colors.transparent) ,
                            shape: BoxShape.circle
                          ),
                        ),
                        ),
                    )),
                  ]),
                )
              ],
            ),
          ),/*Color(0xff43f11c)*/
        ),
      ],
    );
  }
}
