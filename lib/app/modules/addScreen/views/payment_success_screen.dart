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

class PaymentSuccessfullyScreen extends GetView<AddScreenController> {
  const PaymentSuccessfullyScreen({Key? key}) : super(key: key);

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
              Strings.paymentSuccessfulYourVlooDongleTVIsOnItsWay,
              textAlign: TextAlign.center,
              style: CustomTextStyle.font20R.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.h),
            Text(
              Strings.stepsToFollowMessage,
              textAlign: TextAlign.center,
              style: CustomTextStyle.font16R.copyWith(),
            ),
            SizedBox(height: 50.h),
            Container(
              width: 500.w,
              height: 230.h,
              padding:  EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.appLightBlue),
                borderRadius: BorderRadius.circular(40)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Image.asset(StaticAssets.img_tv),
                      SizedBox(width: 10.w),
                      SizedBox(
                        width: 210.w,
                        child: Text(
                          Strings.createDesignMessage,
                          textAlign: TextAlign.start,
                          maxLines: 3,
                          style: CustomTextStyle.font16R,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25.h),
                  CustomButton(
                    buttonName: Strings.createAProject,
                    backgroundColor: AppColor.appSkyBlue,
                    width: 320.w,
                    height: 60.h,
                    isbold: true,
                    textSize: 12.sp,
                    onPressed: () {},
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
