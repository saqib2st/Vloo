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
import 'package:vloo/app/modules/myscreens/views/myscreens_view.dart';
import 'package:vloo/app/routes/app_pages.dart';

class PaymentSuccessSubscriptionScreen extends GetView<AddScreenController> {
  const PaymentSuccessSubscriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        margin: EdgeInsets.only(top: 120.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200.h,
              width: 200.w,
              child: Image.asset(
                StaticAssets.star,
              ),
            ),
            Text(
              Strings.paymentSuccessful,
              textAlign: TextAlign.center,
              style: CustomTextStyle.font20R.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 50.h),
            Text(
              Strings.planChangeValidationMessage,
              textAlign: TextAlign.center,
              style: CustomTextStyle.font16R.copyWith(color: AppColor.white),
            ),
            SizedBox(height: 100.h),
            CustomButton(
              buttonName: Strings.myScreens,
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
