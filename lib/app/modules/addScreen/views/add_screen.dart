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
import 'package:vloo/app/modules/addScreen/views/buy_vloo_dongle_tv.dart';

import 'package_adding_screen.dart';

class AddScreenView extends GetView<AddScreenController> {
  const AddScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: PrimaryAppbar(
          title: Strings.addAScreen,
          onPressed: () {
            Get.back();
          }),
      body: SingleChildScrollView(
        child: Container(
          margin:  EdgeInsets.only(top: 75.h),
          padding: EdgeInsets.symmetric(horizontal: 70.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(Strings.broadcastYourProjectLiveTVScreen,
                  style: CustomTextStyle.font20R
                      .copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
              SizedBox(
                height: 50.h,
              ),
              Image.asset(StaticAssets.imgDongle),
              SizedBox(
                height: 30.h,
              ),
              Text(
                  Strings.addConfigureScreenBroadcastYourProject,
                  textAlign: TextAlign.center,
                  style: CustomTextStyle.font20R),

              SizedBox(
                height: 80.h,
              ),
              CustomButton(
                  buttonName: Strings.addAScreen,
                  borderColor: Colors.transparent,
                  backgroundColor: AppColor.appSkyBlue,
                  width: 250.w,
                  height: 60.h,
                  isbold: true,
                  onPressed: (){
                    Get.to(()=>const PackageAddingScreen());
                  },),
              SizedBox(
                height: 20.h,
              ),

              GestureDetector(
                onTap: (){
                  Get.to(const BuyVlooDongleTv());
                },
                child: Text(
                    Strings.buyOnlyVlooDongleTV,
                    textAlign: TextAlign.center,
                    style: CustomTextStyle.font20R.copyWith(decoration: TextDecoration.underline,decorationColor: AppColor.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
