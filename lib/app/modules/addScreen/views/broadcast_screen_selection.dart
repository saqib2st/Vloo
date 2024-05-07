import 'package:flutter/material.dart';
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
import 'package:vloo/app/modules/addScreen/views/transfer_parent.dart';


class BroadcastScreenSelectionView extends GetView<AddScreenController> {
  const BroadcastScreenSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: PrimaryAppbar(
          title: Strings.broadcastProjectScreen,
          onPressed: () {
            Get.back();
          }),
      body: Container(
        margin: const EdgeInsets.only(top: 30),
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10.h),
            Image.asset(StaticAssets.imgDongle),
            SizedBox(height: 30.h),
            CustomRichText(textAlign: TextAlign.center, title: Strings.doYouHaveSmartTV, discription: Strings.screenName, textStyle2:  CustomTextStyle.font20R.copyWith(fontWeight: FontWeight.bold, color: AppColor.appSkyBlue), textStyle: CustomTextStyle.font20R.copyWith(fontWeight: FontWeight.bold),),
            SizedBox(height: 40.h),

            Text(Strings.replaceAllContentBroadcastScreenDesign, textAlign: TextAlign.center, style: CustomTextStyle.font16R),
            SizedBox(height: 40.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  buttonName: Strings.noAddProjectContinuationContentBeingBroadcast,
                  borderColor: AppColor.appLightBlue,
                  color: AppColor.appLightBlue,
                  width: 160.w,
                  height: 140.h,
                  isbold: false,
                  textSize: 10.sp,
                  onPressed: () {
                    Get.to(const TransferParent());
                    controller.startTimer();
                  },
                ),
                SizedBox(width: 10.w),
                CustomButton(
                  buttonName: Strings.yesOnlyWishBroadcastProjectScreen,
                  borderColor: AppColor.appLightBlue,
                  color: AppColor.appLightBlue,
                  width: 160.w,
                  height: 140.h,
                  isbold: false,
                  textSize: 10.sp,
                  onPressed: () {
                    Get.to(const TransferParent());
                    controller.startTimer();
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
