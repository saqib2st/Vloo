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

class PaymentSuccessAddScreen extends GetView<AddScreenController> {
  const PaymentSuccessAddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        margin: EdgeInsets.only(top: 120.w),
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
              Strings.paymentSuccessful,
              textAlign: TextAlign.center,
              style: CustomTextStyle.font20R.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.h),
            Text(
              Strings.paymentTakenMessage,
              textAlign: TextAlign.center,
              style: CustomTextStyle.font16R.copyWith(),
            ),
            SizedBox(height: 50.h),
            Container(
              width: 500.w,
              height: 250.h,
              padding:  EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.appLightBlue),
                borderRadius: BorderRadius.circular(35)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Image.asset(StaticAssets.img_mobile),
                      SizedBox(
                        width: 180.w,
                        child: Text(
                          Strings.configureScreenMessage,
                          textAlign: TextAlign.start,
                          style: CustomTextStyle.font16R,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25.h),
                  CustomButton(
                    buttonName: Strings.addScreen,
                    backgroundColor: AppColor.appSkyBlue,
                    width: 320.w,
                    height: 60.h,
                    isbold: true,
                    textSize: 12.sp,
                    onPressed: () {
                      Get.to(const ChooseDongleOrSmartTv());
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
