import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/widgets/custom_text_with_icon.dart';
import 'package:vloo/app/data/widgets/primary_appbar.dart';
import 'package:vloo/app/modules/MyMedia/controllers/my_media_controller.dart';
import 'package:vloo/app/modules/MyMedia/views/upgrade_storage.dart';
import 'package:vloo/app/modules/subscriptions/views/add_subscription_screen.dart';

import '../controllers/subscriptions_controller.dart';

class SubscriptionsView extends GetView<SubscriptionsController> {
  const SubscriptionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppbar(
          title: Strings.subscriptions,
          text: Strings.confirm,
          onPressed2: () {
            //TODO: API Integration
          },
          onPressed: () {
            Get.back();
          }),
      backgroundColor: AppColor.primaryColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60.h,
              ),
              Center(
                child: SvgPicture.asset(
                  height: 60.h,
                  width: 200.w,
                  StaticAssets.vlooLogo,
                ),
              ),
              SizedBox(
                height: 100.h,
              ),
              CustomTextWithIcon(
                text: Strings.myScreens,
                logoAsset: StaticAssets.tvSimple,
                textColor: AppColor.secondaryColor,
                textSize: 20.sp,
                imageSize: 20.w,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(
                height: 15.h,
              ),
              GestureDetector(
                onTap: () {
                  Get.put<SubscriptionsController>(SubscriptionsController());
                  Get.to(const AddSubscriptionScreenView());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CustomTextWithIcon(
                        text: '3-screen plan',
                        logoAsset: '',
                        textColor: AppColor.appLightBlue,
                        textSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    CustomTextWithIcon(
                      text: Strings.edit,
                      logoAsset: '',
                      textColor: AppColor.appLightBlue,
                      textSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        size: 15,
                        Icons.arrow_forward_ios_outlined,
                        color: AppColor.appLightBlue,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              const Divider(
                color: AppColor.appIconBackgound,
                thickness: 1,
              ),
              SizedBox(
                height: 25.h,
              ),
              CustomTextWithIcon(
                text: Strings.myStockPlans,
                logoAsset: StaticAssets.cloud,
                textColor: AppColor.secondaryColor,
                textSize: 20.sp,
                imageSize: 28.w,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(
                height: 15.h,
              ),
              GestureDetector(
                onTap: () {
                  Get.put<MyMediaController>(MyMediaController());
                  Get.to(const UpgradeStorageView());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CustomTextWithIcon(
                        text: 'Vloo 5GBs',
                        logoAsset: '',
                        textColor: AppColor.appLightBlue,
                        textSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    CustomTextWithIcon(
                      text: Strings.edit,
                      logoAsset: '',
                      textColor: AppColor.appLightBlue,
                      textSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        size: 15,
                        Icons.arrow_forward_ios_outlined,
                        color: AppColor.appLightBlue,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              const Divider(
                color: AppColor.appIconBackgound,
                thickness: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
