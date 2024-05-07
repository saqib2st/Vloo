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
import 'package:vloo/app/modules/addScreen/views/add_and_sync_screen.dart';

class PackageAddingScreen extends GetView<AddScreenController> {
  const PackageAddingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: PrimaryAppbar(
          title: Strings.packageForAddingAScreen,
          onPressed: () {
            Get.back();
          }),
      body: SingleChildScrollView(
        child: Container(
          height: Get.height* 0.77,
          padding: EdgeInsets.symmetric(horizontal: 70.w),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 10.h),
              CustomRichText(
                textAlign: TextAlign.center,
                title: Strings.packageSelectedColon,
                discription: Strings.oneScreen,
                textStyle: CustomTextStyle.font18R.copyWith(fontWeight: FontWeight.bold),
                textStyle2: CustomTextStyle.font18R.copyWith(color: AppColor.appSkyBlue, fontWeight: FontWeight.bold),
              ),
              Image.asset(StaticAssets.imgDongle),
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: AppColor.appLightBlue),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(child: Text(Strings.subscription, style: CustomTextStyle.font18R.copyWith(fontWeight: FontWeight.bold))),
                              Text(
                                '20€',
                                style: CustomTextStyle.font14R.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(child: Text(Strings.oneMonth, style: CustomTextStyle.font14R)),
                              Text(
                                '20€',
                                style: CustomTextStyle.font14R,
                              ),
                            ],
                          ),
                          Text(
                            Strings.planWithoutRenewableCommitmentAutomatically,
                            style: CustomTextStyle.font14R,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: CustomButton(
                      buttonName: Strings.threeDayFreeTrial,
                      borderColor: Colors.transparent,
                      backgroundColor: AppColor.darkYellow,
                      width: 150.w,
                      height: 30.h,
                      borderRadius: 5,
                    ),
                  ),
                ],
              ),
              CustomButton(
                buttonName: Strings.validateThisPlan,
                borderColor: Colors.transparent,
                backgroundColor: AppColor.appSkyBlue,
                width: 250.w,
                height: 60.h,
                isbold: true,
                onPressed: () {
                  Get.to(const AddAndSyncScreenView());
                },
              ),
              Text(Strings.recurringPlanMessage,
                  textAlign: TextAlign.start,
                  style: CustomTextStyle.font20R.copyWith(fontSize: 11.sp)),
            ],
          ),
        ),
      ),
    );
  }
}
