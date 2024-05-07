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
import 'turn_on_dongle_or_smart_tv.dart';

class ChooseDongleOrSmartTv extends GetView<AddScreenController> {
  const ChooseDongleOrSmartTv({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: PrimaryAppbar(
          title: Strings.addSyncScreen,
          onPressed: () {
            Get.back();
          }),
      body: Container(
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
            Text(Strings.doYouHaveSmartTV, textAlign: TextAlign.center, style: CustomTextStyle.font20R.copyWith(fontWeight: FontWeight.bold)),
            SizedBox(
              height: 40.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  buttonName: Strings.iHaveSmartTV,
                  borderColor: AppColor.appLightBlue,
                  color: AppColor.appLightBlue,
                  width: 140.w,
                  height: 120.h,
                  isbold: true,
                  onPressed: () {
                    Get.to(TurnOnDongleOrSmartTvScreen(
                      buttonText: Strings.mySmartTVConnectedInternetMessage,
                      doneOrSmartTvText: Strings.smartTV,
                      imagePath: StaticAssets.imgSmartTV,
                      buttonHeight: 150.h,
                      descriptionText: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: Strings.makeSureYouHaveYour,
                          style: CustomTextStyle.font16R.copyWith(fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                              text: Strings.smartTVConnected,
                              style: CustomTextStyle.font16R.copyWith(fontWeight: FontWeight.bold, color: AppColor.appSkyBlue),
                            ),
                            TextSpan(text: Strings.andThe, style: CustomTextStyle.font16R.copyWith(fontWeight: FontWeight.bold, color: AppColor.appLightBlue)),
                            TextSpan(text: Strings.vlooTvAppInstalled, style: CustomTextStyle.font16R.copyWith(fontWeight: FontWeight.bold, color: AppColor.appSkyBlue)),
                            TextSpan(text: Strings.onIt, style: CustomTextStyle.font16R.copyWith(fontWeight: FontWeight.bold, color: AppColor.appLightBlue)),
                            TextSpan(text: Strings.openTheVlooTVApp, style: CustomTextStyle.font16R.copyWith(fontWeight: FontWeight.bold, color: AppColor.appSkyBlue)),
                          ],
                        ),
                      ),
                    ));
                  },
                ),
                SizedBox(width: 20.w),
                CustomButton(
                  buttonName: Strings.iHaveVlooDongleTV,
                  borderColor: AppColor.appLightBlue,
                  color: AppColor.appLightBlue,
                  width: 140.w,
                  height: 120.h,
                  isbold: true,
                  textSize: 12.sp,
                  onPressed: () {
                    Get.to(TurnOnDongleOrSmartTvScreen(
                      buttonText: Strings.myVlooDongTVTurnedOn,
                      doneOrSmartTvText: Strings.dongleTV,
                      imagePath: StaticAssets.imgDongleWithTv,
                      buttonHeight: 100.h,
                      descriptionText: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: Strings.makeSureYouHaveYour,
                          style: CustomTextStyle.font16R.copyWith(fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                              text: Strings.vlooDongleTVPluggedAndTurnedOn,
                              style: CustomTextStyle.font16R.copyWith(fontWeight: FontWeight.bold, color: AppColor.appSkyBlue),
                            ),
                            const TextSpan(text: Strings.onTheHDMIOutputYourTVScreen),
                          ],
                        ),
                      ),
                    ));
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
