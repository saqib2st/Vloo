import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/widgets/custom_buttons.dart';
import 'package:vloo/app/data/widgets/custom_rich_text.dart';
import 'package:vloo/app/data/widgets/primary_appbar.dart';
import 'package:vloo/app/modules/addScreen/controllers/add_screen_controller.dart';
import 'package:vloo/app/modules/addScreen/views/add_screen.dart';
import 'package:vloo/app/modules/addScreen/views/broadcast_screen_selection.dart';
import 'package:vloo/main.dart';

class ChooseScreenView extends GetView<AddScreenController> {
  const ChooseScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.primaryColor,
        appBar: PrimaryAppbar(
            title: Strings.broadcastProjectScreen,
            onPressed: () {
              Get.back();
            }),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 17.0.w),
          child: Column(
            children: [
              SizedBox(
                height: 25.h,
              ),
              Text(
                Strings.myScreens,
                style: CustomTextStyle.font20R.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w),
                child: CustomRichText(
                    textAlign: TextAlign.center,
                    title: Strings.yourProjectAddNewScreen,
                    discription: Strings.youCanOnlyBroadcastThisProjectOnYourScreensIn,
                    boldText: Strings.verticalMode,
                    textStyle: CustomTextStyle.font12R,
                    textStyle2: CustomTextStyle.font12R.copyWith(color: AppColor.appSkyBlue),
                    textStyle3: CustomTextStyle.font12R.copyWith(color: AppColor.appSkyBlue, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 15.h,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(const AddScreenView());
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 50),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColor.appSkyBlue,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        StaticAssets.icPlus,
                        fit: BoxFit.none,
                        placeholderBuilder: (BuildContext context) => Container(
                            padding: const EdgeInsets.all(30.0),
                            child: const CircularProgressIndicator()),
                      ),
                      Text(
                        Strings.addAScreen,
                        style: CustomTextStyle.font16R.copyWith(fontWeight: FontWeight.bold, color: AppColor.appSkyBlue),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Expanded(
                child: GridView(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  children: <Widget>[
                    ...List.generate(controller.screenNameList.length, (index) {
                      return Obx(
                        () => GestureDetector(
                            onTap: () {
                              if (controller.selectedScreen.value == controller.screenNameList[index]) {
                                controller.selectedScreen.value = '';
                              } else {
                                controller.selectedScreen.value = controller.screenNameList[index];
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.all(5.0),
                              padding: EdgeInsets.only(left: 22.w, right: 22.w, top: 20.h),
                              decoration: BoxDecoration(border: Border.all(color: AppColor.appSkyBlue, width: controller.selectedScreen.value == controller.screenNameList[index] ? 3 : 1), borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(StaticAssets.imgDummyMenu),
                                  SizedBox(height: 10.h),
                                  Text(
                                    controller.screenNameList[index],
                                    style: CustomTextStyle.font12R.copyWith(color: AppColor.appSkyBlue, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5.h),
                                  Row(
                                    children: [Text(Strings.horizontalDot, style: CustomTextStyle.font12R.copyWith(color: AppColor.appLightBlue, fontWeight: FontWeight.bold)), Text(Strings.offline, style: CustomTextStyle.font12R.copyWith(color: AppColor.red, fontWeight: FontWeight.bold))],
                                  ),
                                  Align(
                                      alignment: Alignment.bottomRight,
                                      child: Icon(
                                        controller.selectedScreen.value == controller.screenNameList[index] ? Icons.circle : Icons.circle_outlined,
                                        color: controller.selectedScreen.value == controller.screenNameList[index] ? AppColor.appSkyBlue : AppColor.appLightBlue,
                                      ))
                                ],
                              ),
                            )),
                      );
                    }).toList()
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.h),
                  child: Obx(
                    () => CustomButton(
                        buttonName: Strings.chooseThisScreen,
                        borderColor: Colors.transparent,
                        onPressed: () {
                          controller.selectedScreen.value != '' ? Get.to(const BroadcastScreenSelectionView()) : scaffoldKey.currentState?.showSnackBar(const SnackBar(content: Text(Strings.firstSelectScreen)));
                        },
                        backgroundColor: controller.selectedScreen.value != '' ? AppColor.appSkyBlue : AppColor.disableColor,
                        width: 250.w,
                        height: 60.h,
                        isbold: true),
                  )),
            ],
          ),
        ));
  }
}
