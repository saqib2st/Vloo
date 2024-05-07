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
import 'package:vloo/app/modules/addScreen/views/choose_dongle_or_smart_tv.dart';

import 'pairing_code_screen.dart';

class SynchronizationWithVlooDongleTV extends GetView<AddScreenController> {
  const SynchronizationWithVlooDongleTV({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: PrimaryAppbar(
          title: Strings.synchronizationWithVlooDongleTV,
          onPressed: () {
            Get.back();
          }),
      body: Container(
        margin: const EdgeInsets.only(top: 30),
        padding: EdgeInsets.symmetric(horizontal: 50.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(Strings.pictureAppearOnYourTVScreen, textAlign: TextAlign.center, style: CustomTextStyle.font20R.copyWith(fontWeight: FontWeight.bold)),
            SizedBox(height: 40.h),
            Image.asset(StaticAssets.imageDummyQr),
            SizedBox(height: 80.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  buttonName: Strings.no,
                  borderColor: AppColor.appLightBlue,
                  color: AppColor.appLightBlue,
                  width: 140.w,
                  height: 70.h,
                  isbold: true,
                  onPressed: () {
                    Get.back();
                    Get.back();

                  },
                ),
                SizedBox(width: 20.w),
                CustomButton(
                  buttonName: Strings.yes,
                  borderColor: AppColor.appLightBlue,
                  color: AppColor.appLightBlue,
                  width: 140.w,
                  height: 70.h,
                  isbold: true,
                  textSize: 12.sp,
                  onPressed: () {
                    Get.to(const PairingCodeScreenView());
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
