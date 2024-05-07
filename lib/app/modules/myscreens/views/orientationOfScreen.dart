import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/models/screens/ScreenModel.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/utils/utils.dart';
import 'package:vloo/app/data/widgets/primary_appbar.dart';
import 'package:vloo/app/modules/myscreens/controllers/myscreens_controller.dart';

class OrientationScreenView extends GetView<MyscreensController> {
  final ScreenModel? selectedScreenModel;

  const OrientationScreenView({super.key, required this.selectedScreenModel});

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
        onPressed2: () async {
          await controller.updateMyScreenOrientation(selectedScreenModel?.id ?? 0);
          await controller.getMyScreenDetails();
        },
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Obx(
          () => Column(
            children: [
              Text(
                Strings.orientationOfTheScreenHeadingMessage,
                style: CustomTextStyle.font14R,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 25.h,
              ),
              GestureDetector(
                onTap: () {
                  // Utils.showOrientationAlert(context);
                },
                child: Text(
                  Strings.changeScreenOrientation,
                  style: CustomTextStyle.font20R.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () {
                  controller.setScreenOrientationValue(Strings.horizontal);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 3, color: controller.isCheckedHorizontal.value ? AppColor.primaryGreen : AppColor.appLightBlue),
                  ),
                  child: Image.asset(
                    'assets/images/image_horizontal.png',
                    width: 280.w,
                    height: 150.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => Theme(
                      data: ThemeData(
                        unselectedWidgetColor: AppColor.appLightBlue,
                      ),
                      child: Checkbox(
                        value: controller.isCheckedHorizontal.value,
                        onChanged: (bool? value) {
                          //controller.isCheckedHorizontal.value = value ?? false;
                          controller.setScreenOrientationValue(Strings.horizontal);
                        },
                        activeColor: controller.isCheckedHorizontal.value ? AppColor.primaryGreen : AppColor.appLightBlue,
                        checkColor: Colors.black,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      controller.setScreenOrientationValue(Strings.horizontal);
                    },
                    child: Text(
                      Strings.horizontal,
                      style: CustomTextStyle.font16R.copyWith(
                        color: controller.isCheckedHorizontal.value ? AppColor.primaryGreen : AppColor.appLightBlue,
                      ),
                    ),
                  ),
                ],
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
                        onTap: (){
                          controller.setScreenOrientationValue(Strings.verticalLeft);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 3, color: controller.isCheckedVerticalLeft.value ? AppColor.primaryGreen : AppColor.appLightBlue),
                          ),
                          child: Image.asset(
                            'assets/images/image_vertical_left.png',
                            width: 150.w,
                            height: 250.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Row(
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
                                 // controller.isCheckedVerticalLeft.value = value ?? false;
                                  controller.setScreenOrientationValue(Strings.verticalLeft);

                                },
                                activeColor: controller.isCheckedVerticalLeft.value ? AppColor.primaryGreen : AppColor.appLightBlue,
                                checkColor: Colors.black,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              controller.setScreenOrientationValue(Strings.verticalLeft);
                            },
                            child: Text(
                              Strings.verticalLeft,
                              style: CustomTextStyle.font16R.copyWith(
                                color: controller.isCheckedVerticalLeft.value ? AppColor.primaryGreen : AppColor.appLightBlue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: (){
                          controller.setScreenOrientationValue(Strings.verticalRight);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 3, color: controller.isCheckedVerticalRight.value ? AppColor.primaryGreen : AppColor.appLightBlue),
                          ),
                          child: Image.asset(
                            'assets/images/image_vertical_right.png',
                            width: 150.w,
                            height: 250.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Row(
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
                                  //controller.isCheckedVerticalRight.value = value ?? false;
                                  controller.setScreenOrientationValue(Strings.verticalRight);
                                },
                                activeColor: controller.isCheckedVerticalRight.value ? AppColor.primaryGreen : AppColor.appLightBlue,
                                checkColor: Colors.black,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              controller.setScreenOrientationValue(Strings.verticalRight);
                            },
                            child: Text(
                              Strings.verticalRight,
                              style: CustomTextStyle.font16R.copyWith(
                                color: controller.isCheckedVerticalRight.value ? AppColor.primaryGreen : AppColor.appLightBlue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
