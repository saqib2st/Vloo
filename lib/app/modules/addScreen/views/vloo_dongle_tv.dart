import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/widgets/custom_buttons.dart';
import 'package:vloo/app/data/widgets/primary_appbar.dart';
import 'package:vloo/app/modules/addScreen/controllers/add_screen_controller.dart';
import 'package:vloo/app/modules/addScreen/views/buy_vloo_dongle_tv.dart';
import 'package:vloo/app/modules/addScreen/views/choose_dongle_or_smart_tv.dart';
import 'package:vloo/app/modules/addScreen/views/detail_of_order.dart';

import 'package_adding_screen.dart';
import 'payment_success_screen.dart';

class VlooDongleTv extends GetView<AddScreenController> {
  const VlooDongleTv({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: PrimaryAppbar(
          title: Strings.vlooDongleTV,
          onPressed: () {
            Get.back();
          }),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 30),
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(Strings.dongleTvDescription, textAlign: TextAlign.center, style: CustomTextStyle.font16R),
              SizedBox(height: 10.h),
              Image.asset(StaticAssets.imgVlooDongle),
              SizedBox(height: 30.h),
              Text(Strings.wouldYouLikeVlooDongleTV, textAlign: TextAlign.center, style: CustomTextStyle.font20R.copyWith(fontWeight: FontWeight.bold)),
              SizedBox(height: 40.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    buttonName: Strings.noIHaveAlreadyVlooDongleTV,
                    borderColor: AppColor.appLightBlue,
                    color: AppColor.appLightBlue,
                    width: 160.w,
                    height: 130.h,
                    textSize: 12.sp,
                    isbold: true,
                    onPressed: () {

                      //TODO: Cases for navigation -> if payment for dongle and plan added then move to add a screen flow
                      Get.to(const ChooseDongleOrSmartTv());


                      //TODO: Cases for navigation -> if payment for dongle added only then move to pay for plan flow but only for plan payment
                      // Get.to(const DetailOfOrder());

                      //TODO: Cases for navigation -> if payment is not added at all then move to detail of order flow
                     // Get.to(const DetailOfOrder());
                    },
                  ),
                  SizedBox(width: 20.w),
                  CustomButton(
                    buttonName: Strings.yesIWantVlooDongleTV,
                    borderColor: AppColor.appLightBlue,
                    color: AppColor.appLightBlue,
                    width: 160.w,
                    height: 130.h,
                    textSize: 12.sp,
                    isbold: true,
                    onPressed: () {
                      Get.to(const BuyVlooDongleTv());
                    },
                  ),
                ],
              ),
              SizedBox(height: 70.h),
              Text(Strings.vlooDongleTVYourPossessionAssociatedWithAnyScreen, textAlign: TextAlign.center, style: CustomTextStyle.font16R.copyWith(color: AppColor.grey)),
              SizedBox(height: 55.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(StaticAssets.icHelpCenterIcon),
                  SizedBox(width: 5.w),
                  Text(Strings.whatIsASmartTV, textAlign: TextAlign.center, style: CustomTextStyle.font16R.copyWith(decoration: TextDecoration.underline)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
