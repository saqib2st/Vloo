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
import 'package:vloo/app/modules/addScreen/views/detail_of_order.dart';

import 'vloo_dongle_tv.dart';

class AddAndSyncScreenView extends GetView<AddScreenController> {
  const AddAndSyncScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: PrimaryAppbar(
          title: Strings.addSyncScreen,
          onPressed: () {
            Get.back();
          }),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 30),
          padding: EdgeInsets.symmetric(horizontal: 50.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                StaticAssets.vlooLogo,
                height: 39.h,
                width: 130.w,
                placeholderBuilder: (BuildContext context) => Container(
                    padding: const EdgeInsets.all(30.0),
                    child: const CircularProgressIndicator()),
              ),
              SizedBox(
                height: 10.h,
              ),
              Image.asset(StaticAssets.imgSmartTV),

              SizedBox(
                height: 30.h,
              ),
              Text(
                  Strings.doYouHaveSmartTV,
                  textAlign: TextAlign.center,
                  style: CustomTextStyle.font20R.copyWith(fontWeight: FontWeight.bold)),
              Text(
                  Strings.smartTVConnectedToInternet,
                  textAlign: TextAlign.center,
                  style: CustomTextStyle.font16R),

              SizedBox(
                height: 40.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                      buttonName: Strings.no,
                      borderColor: AppColor.appLightBlue,
                      color: AppColor.appLightBlue,
                      width: 140.w,
                      height: 120.h,
                      isbold: true,
                      textSize: 12.sp,
                      onPressed: (){
                        Get.to(const VlooDongleTv());
                      },),
                  SizedBox(width: 20.w),
                  CustomButton(
                      buttonName: Strings.yesIHaveSmartTV,
                      borderColor: AppColor.appLightBlue,
                      color: AppColor.appLightBlue,
                      width: 140.w,
                      height: 120.h,
                      isbold: true,
                      textSize: 12.sp,
                      onPressed: (){
                        Get.to(const DetailOfOrder());

                      },),
                ],
              ),
              SizedBox(
                height: 100.h,
              ),
            

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(StaticAssets.icHelpCenterIcon),
                  SizedBox(width: 5.w),
                  Text(
                      Strings.whatIsASmartTV,
                      textAlign: TextAlign.center,
                      style: CustomTextStyle.font16R.copyWith(decoration: TextDecoration.underline)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
