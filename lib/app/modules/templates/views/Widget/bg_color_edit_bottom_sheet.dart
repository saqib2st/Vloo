import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/widgets/custom_text_with_icon.dart';
import 'package:vloo/app/modules/imageElement/controllers/image_element_controller.dart';
import 'package:vloo/app/modules/templates/controllers/templates_controller.dart';
import 'package:vloo/app/modules/templates/views/background_image_view.dart';

class BgColorEditView extends GetView<TemplatesController> {
  const BgColorEditView({super.key});

  bool compare(Color color1, Color color2) {
    return color1.red == color2.red && color1.green == color2.green && color1.blue == color2.blue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Get.put(ImageElementController());
                Get.to(const BackgroundImageView());
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColor.white,
                    width: 0.8,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextWithIcon(
                    text: Strings.backgroundImage,
                    logoAsset: StaticAssets.replaceBgIcon,
                    textColor: AppColor.appLightBlue,
                    textSize: 16.sp,
                    imageSize: 25.w,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Divider(
            color: AppColor.appIconBackgound,
            thickness: 0.8,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Text(
            Strings.backgroundColor,
            style: CustomTextStyle.font16R.copyWith(color: AppColor.appLightBlue, fontWeight: FontWeight.w400),
          ),
        ),
        Obx(
          () => SingleChildScrollView(
            // bottom color bar
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.isPickerColor.value = false;
                    Get.dialog(
                      AlertDialog(
                        title: const Text('Pick a color!'),
                        content: SingleChildScrollView(
                          child: ColorPicker(
                            pickerColor: controller.pickerTemplateBackgroundColor.value,
                            onColorChanged: controller.changeTemplateBackgroundColor,
                            hexInputBar: true,
                          ),
                        ),
                        actions: <Widget>[
                          ElevatedButton(
                            child: const Text('Got it'),
                            onPressed: () {
                              // controller.backgroundImage.value = '';
                              Get.forceAppUpdate();
                              controller.saveTemplateBackGroundColor();
                              controller.addColor(controller.currentTemplateBackgroundColor.value.toString());
                              Get.back();
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
                GestureDetector(
                  onTap: () {
                    // controller.backgroundImage.value = '';
                    Get.forceAppUpdate();
                    controller.selectedTemplateBackGroundColor.value = Colors.transparent;
                    controller.pickerTemplateBackgroundColor.value = Colors.transparent;
                    controller.saveTemplateBackGroundColor();
                    controller.isPickerColor.value = true;
                  },
                  child: SvgPicture.asset(
                    StaticAssets.none,
                    width: 33,
                    height: 33,
                  ),
                ),
                ...controller.colorsList.sublist(1).asMap().entries.map((e) {
                  return GestureDetector(
                    onTap: () {
                      // controller.backgroundImage.value = '';
                      Get.forceAppUpdate();
                      controller.selectedTemplateBackGroundColor.value = e.value;
                      controller.pickerTemplateBackgroundColor.value = e.value;
                      controller.saveTemplateBackGroundColor();
                      controller.isPickerColor.value = true;
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: e.value, width: 2)),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(width: 10, height: 10, decoration: BoxDecoration(shape: BoxShape.circle, color: controller.selectedTemplateBackGroundColor.value == e.value && controller.isPickerColor.value ? e.value : Colors.transparent)),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
        Obx(
          () => Padding(
            padding: EdgeInsets.symmetric(vertical: 25.h),
            child: Column(
              children: [
                if(controller.colorList.isNotEmpty)
                Row(
                  children: [
                    Text('Recent :',style: CustomTextStyle.font11R,),
                    Flexible(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: [
                              ...controller.colorList.asMap().entries.map((e) => InkWell(
                                onTap: () {
                                  // controller.backgroundImage.value = '';
                                  Get.forceAppUpdate();
                                  controller.selectedTemplateBackGroundColor.value = Color(int.parse(e.value.split('(').last.split(')').first.replaceAll('0x', ''), radix: 16));
                                  controller.pickerTemplateBackgroundColor.value = Color(int.parse(e.value.split('(').last.split(')').first.replaceAll('0x', ''), radix: 16));
                                  controller.saveTemplateBackGroundColor();
                                  controller.isPickerColor.value = true;
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
                                        color: compare(Color(int.parse(e.value.split('(').last.split(')').first.replaceAll('0x', ''), radix: 16)), controller.selectedTemplateBackGroundColor.value ) && controller.isPickerColor.value
                                            ? controller.selectedTemplateBackGroundColor.value
                                            : Colors.transparent,
                                        shape: BoxShape.circle
                                    ),
                                  ),
                                ),
                              )),
                            ]),
                      ),
                    ),
                  ],
                ),
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
                      '${(controller.rangeValue.value * 100).toInt()}%',
                      style: CustomTextStyle.font16R.copyWith(color: AppColor.white, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                SliderTheme(
                  data: SliderThemeData(
                      trackHeight: 2,
                      trackShape: const RoundedRectSliderTrackShape(),
                      overlayShape: SliderComponentShape.noOverlay,
                      activeTrackColor: Color.fromRGBO(255, 255, 255, controller.rangeValue.value),
                      inactiveTrackColor: AppColor.white,
                      thumbColor: AppColor.trackWhite,
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12)),
                  child: Slider(
                    value: controller.rangeValue.value,
                    onChanged: (val) {
                      controller.rangeValue.value = val;
                      Color myColor = controller.pickerTemplateBackgroundColor.value;

                      controller.currentTemplateBackgroundColor.value = Color.fromRGBO(myColor.red, myColor.green, myColor.blue, controller.rangeValue.value);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
