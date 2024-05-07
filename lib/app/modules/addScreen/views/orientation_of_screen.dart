import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/widgets/custom_buttons.dart';
import 'package:vloo/app/data/widgets/primary_appbar.dart';
import 'package:vloo/app/modules/addScreen/controllers/add_screen_controller.dart';
import 'package:vloo/main.dart';

class OrientationScreen extends GetView<AddScreenController> {
  final String? pairingCode;

  const OrientationScreen({super.key, required this.pairingCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.primaryColor,
        appBar: PrimaryAppbar(
          title: Strings.orientationOfTheScreen,
          text: Strings.confirm,
          onPressed: () {
            Get.back();
          },
          onPressed2: () {},
        ),
        body: Obx(
          () => Container(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              children: [
                Text(
                  Strings.selectScreenOrientation,
                  style: CustomTextStyle.font20R.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20.h,
                ),
                GestureDetector(
                  onTap: () {
                    controller.selectHorizontalOrientation();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 3, color: controller.isCheckedHorizontal.value == true ? AppColor.primaryGreen : AppColor.appLightBlue),
                    ),
                    child: Image.asset(
                      StaticAssets.imgHorizontalOrientation,
                      width: 280.w,
                      height: 150.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.selectHorizontalOrientation();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Theme(
                        data: ThemeData(
                          unselectedWidgetColor: AppColor.appLightBlue,
                        ),
                        child: Checkbox(
                          value: controller.isCheckedHorizontal.value,
                          onChanged: (bool? value) {
                            controller.selectHorizontalOrientation();
                          },
                          activeColor: controller.isCheckedHorizontal.value == true ? AppColor.primaryGreen : AppColor.appLightBlue,
                          checkColor: Colors.black,
                        ),
                      ),
                      Text(
                        Strings.horizontal,
                        style: CustomTextStyle.font16R.copyWith(color: controller.isCheckedHorizontal.value == true ? AppColor.primaryGreen : AppColor.appLightBlue),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.selectVerticalLeftOrientation();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 3, color: controller.isCheckedVerticalLeft.value == true ? AppColor.primaryGreen : AppColor.appLightBlue),
                            ),
                            child: Image.asset(
                              StaticAssets.imgVerticalLeftOrientation,
                              width: 150.w,
                              height: 250.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.selectVerticalLeftOrientation();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx(
                                () => Theme(
                                  data: ThemeData(
                                    unselectedWidgetColor: AppColor.appLightBlue,
                                  ),
                                  child: Checkbox(
                                    value: controller.isCheckedVerticalLeft.value,
                                    onChanged: (bool? value) {
                                      controller.selectVerticalLeftOrientation();
                                    },
                                    activeColor: controller.isCheckedVerticalLeft.value == true ? AppColor.primaryGreen : AppColor.appLightBlue,
                                    checkColor: Colors.black,
                                  ),
                                ),
                              ),
                              Text(
                                Strings.verticalLeft,
                                style: CustomTextStyle.font16R.copyWith(
                                  color: controller.isCheckedVerticalLeft.value == true ? AppColor.primaryGreen : AppColor.appLightBlue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.selectVerticalRightOrientation();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 3, color: controller.isCheckedVerticalRight.value == true ? AppColor.primaryGreen : AppColor.appLightBlue),
                            ),
                            child: Image.asset(
                              StaticAssets.imgVerticalRightOrientation,
                              width: 150.w,
                              height: 250.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.selectVerticalRightOrientation();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx(
                                () => Theme(
                                  data: ThemeData(
                                    unselectedWidgetColor: AppColor.appLightBlue,
                                  ),
                                  child: Checkbox(
                                    value: controller.isCheckedVerticalRight.value,
                                    onChanged: (bool? value) {
                                      controller.selectVerticalRightOrientation();
                                    },
                                    activeColor: controller.isCheckedVerticalRight.value == true ? AppColor.primaryGreen : AppColor.appLightBlue,
                                    checkColor: Colors.black,
                                  ),
                                ),
                              ),
                              Text(
                                Strings.verticalRight,
                                style: CustomTextStyle.font16R.copyWith(
                                  color: controller.isCheckedVerticalRight.value == true ? AppColor.primaryGreen : AppColor.appLightBlue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                Obx(
                  () => CustomButton(
                    buttonName: Strings.orientationConfirmation,
                    borderColor: Colors.transparent,
                    backgroundColor: controller.isCheckedHorizontal.value == true || controller.isCheckedVerticalRight.value == true || controller.isCheckedVerticalLeft.value == true ? AppColor.appSkyBlue : AppColor.disableColor,
                    width: 300.w,
                    height: 60.h,
                    isbold: true,
                    onPressed: () {
                      controller.isCheckedHorizontal.value == true || controller.isCheckedVerticalRight.value == true || controller.isCheckedVerticalLeft.value == true
                          ? controller.updateMyScreenOrientation(controller.pairingCodeValue.value, controller.fetchOrientation(), "", 2)
                          : scaffoldKey.currentState?.showSnackBar(const SnackBar(content: Text(Strings.selectOrientationFirst)));
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
