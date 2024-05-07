import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/widgets/custom_buttons.dart';
import 'package:vloo/app/modules/addScreen/controllers/add_screen_controller.dart';
import 'package:vloo/app/routes/app_pages.dart';


class PaymentSuccessfulView extends GetView<AddScreenController> {
  const PaymentSuccessfulView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        margin: EdgeInsets.only(top: 200.w),
        child: Column(
          children: [
            SizedBox(
              height: 150.h,
              width: 150.w,
              child: Image.asset(
                'assets/images/star.gif')),
            SizedBox(height: 30.h),
            Text(
              Strings.paymentSuccessful,
              textAlign: TextAlign.center,
              style: CustomTextStyle.font20R.copyWith(fontWeight: FontWeight.bold)),
            SizedBox(height: 50.h),
            Text(
              Strings.planChangeSuccessfully,
              textAlign: TextAlign.center,
              style: CustomTextStyle.font16R.copyWith()),
            SizedBox(height: 90.h),
            CustomButton(
              buttonName: Strings.backToMedia,
              backgroundColor: AppColor.appSkyBlue,
              width: 320.w,
              height: 60.h,
              isbold: true,
              textSize: 12.sp,
              onPressed: () {
                Get.offAllNamed(Routes.bottomNav);
              },
            ),
          ],
        ),
      ),
    );
  }
}
