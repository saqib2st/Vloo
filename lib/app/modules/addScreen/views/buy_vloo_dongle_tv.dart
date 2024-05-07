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
import 'package:vloo/app/modules/addScreen/views/delivery_address.dart';

class BuyVlooDongleTv extends GetView<AddScreenController> {
  const BuyVlooDongleTv({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: PrimaryAppbar(
          title: Strings.vlooDongleTV,
          onPressed: () {
            Get.back();
          }),
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 30),
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          children: [
            CustomRichText(
              textAlign: TextAlign.center,
              title: Strings.productSelectedColon,
              discription: Strings.vlooDongleTV,
              textStyle: CustomTextStyle.font18R.copyWith(fontWeight: FontWeight.bold),
              textStyle2: CustomTextStyle.font18R.copyWith(color: AppColor.appSkyBlue, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.h),
            Image.asset(StaticAssets.imgVlooDongle),
            SizedBox(height: 40.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
              width: 320.w,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColor.appLightBlue)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(Strings.vlooDongleTV, style: CustomTextStyle.font16R.copyWith(fontWeight: FontWeight.bold)),
                          Text(Strings.singlePayment, textAlign: TextAlign.center, style: CustomTextStyle.font16R.copyWith(color: AppColor.grey)),
                        ],
                      ),
                      Text(
                        '${controller.donglePlanResult?.donglePrice}${controller.donglePlanResult?.plan?.currency}' ?? Strings.amount,
                        style: CustomTextStyle.font16R.copyWith(fontWeight: FontWeight.bold, color: AppColor.appSkyBlue),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 50.h),
            CustomButton(
              buttonName: Strings.buyVlooDongleTV,
              backgroundColor: AppColor.appSkyBlue,
              width: 250.w,
              height: 60.h,
              isbold: true,
              textSize: 14.sp,
              onPressed: () {
                Get.to(const DeliveryAddress());
              },
            ),
          ],
        ),
      ),
    );
  }
}
