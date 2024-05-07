import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/widgets/custom_buttons.dart';
import 'package:vloo/app/data/widgets/custom_rich_text.dart';
import 'package:vloo/app/modules/addScreen/controllers/add_screen_controller.dart';
import 'package:vloo/app/modules/bottomNav/controllers/bottom_nav_controller.dart';
import 'package:vloo/app/routes/app_pages.dart';

class TransferCompleteView extends GetView<AddScreenController> {
  const TransferCompleteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        margin: EdgeInsets.only(top: 180.w),
        child: Column(
          children: [
            SizedBox(
              height: 150.h,
              width: 150.w,
              child: Image.asset(
                StaticAssets.star,
              ),
            ),
            SizedBox(height: 15.h),
            Text(
              Strings.transferComplete,
              textAlign: TextAlign.center,
              style: CustomTextStyle.font20R.copyWith(fontWeight: FontWeight.bold , color: AppColor.appSkyBlue),
            ),
            SizedBox(height: 20.h),
            CustomRichText(
              title: Strings.projectCurrentlyStreamingOnColon,
              discription: '\nEcran 1',
              textAlign: TextAlign.center,
              textStyle2: CustomTextStyle.font16R.copyWith(color: AppColor.appSkyBlue, fontWeight: FontWeight.bold) ,
              textStyle: CustomTextStyle.font16R,
            ),
            SizedBox(height: 60.h),

            CustomButton(
              buttonName: Strings.backToMyScreens,
              backgroundColor: AppColor.appSkyBlue,
              width: 320.w,
              height: 60.h,
              isbold: true,
              textSize: 12.sp,
              onPressed: () {
                Get.close(3);
                Get.find<BottomNavController>().currentIndex.value= 2;
              },
            ),
          ],
        ),
      ),
    );
  }
}
