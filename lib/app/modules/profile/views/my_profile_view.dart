import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:vloo/app/data/configs/api_config.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/singleton.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/utils/utils.dart';
import 'package:vloo/app/data/widgets/custom_text_with_icon.dart';
import 'package:vloo/app/modules/profile/controllers/profile_controller.dart';
import 'package:vloo/app/modules/profile/views/edit_my_profile.dart';
import 'package:vloo/app/modules/subscriptions/views/subscriptions_view.dart';

class MyProfileView extends GetView<ProfileController> {
  Size get preferredSize => const Size.fromHeight(80);

  const MyProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        toolbarHeight: preferredSize.height,
        title: Text(
          Strings.myProfile,
          style: TextStyle(
            color: AppColor.appLightBlue,
            fontWeight: FontWeight.w400,
            fontSize: 20.sp,
          ),
        ),
        backgroundColor: AppColor.primaryColor,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: AppColor.primaryColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 50.h),
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 60.h,
                    width: 60.w,
                    child: Image.asset(StaticAssets.userImageProfile), //TODO: to be changed later
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.isProfileUpdated.value ? Singleton.userObject?.firstName ?? "" : '',
                        style: CustomTextStyle.font20R.copyWith(fontWeight: FontWeight.w700, color: AppColor.appLightBlue),
                      ),
                      Text(
                        controller.isProfileUpdated.value ? Singleton.userObject?.email  ?? "" : '',
                        style: CustomTextStyle.font14R.copyWith(fontWeight: FontWeight.w400, color: AppColor.appLightBlue),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(const EditMyProfileView());
                },
                child: CustomTextWithIcon(
                  text: Strings.editMyProfile,
                  logoAsset: StaticAssets.profileIcon,
                  textColor: AppColor.appLightBlue,
                  textSize: 18.sp,
                  imageSize: 20.w,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(const SubscriptionsView());
                },
                child: CustomTextWithIcon(
                  text: Strings.subscriptions,
                  logoAsset: StaticAssets.subscriptionsIcon,
                  textColor: AppColor.appLightBlue,
                  textSize: 18.sp,
                  imageSize: 20.w,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomTextWithIcon(
                    text: Strings.language,
                    logoAsset: StaticAssets.languageIcon,
                    textColor: AppColor.appLightBlue,
                    textSize: 18.sp,
                    imageSize: 20.w,
                    fontWeight: FontWeight.w700,
                  ),
                  const Expanded(child: Text("")),
                  ToggleSwitch(
                    minWidth: 50.0,
                    initialLabelIndex: controller.isFrenchSelected.value ? 1 : 0,
                    cornerRadius: 20.0,
                    activeFgColor: AppColor.white,
                    inactiveBgColor: AppColor.unselectedTab,
                    inactiveFgColor: Colors.white,
                    totalSwitches: 2,
                    labels: const ['Eng', 'Fra'],
                    activeBgColors: const [
                      [AppColor.appSkyBlue],
                      [AppColor.appSkyBlue]
                    ],
                    onToggle: (index) {
                      print('switched to: $index');
                      controller.isFrenchSelected.value = index == 1;
                      controller.updateLanguage();
                    },
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              GestureDetector(
                onTap: () {
                  controller.launchUrlInBrowser(ApiConfig.contactUsURL);
                },
                child: CustomTextWithIcon(
                  text: Strings.contact,
                  logoAsset: StaticAssets.conversationIcon,
                  textColor: AppColor.appLightBlue,
                  textSize: 18.sp,
                  imageSize: 20.w,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 30.h),
              GestureDetector(
                onTap: () {
                  controller.launchUrlInBrowser(ApiConfig.aboutUsURL);
                },
                child: CustomTextWithIcon(
                  text: Strings.aboutUs,
                  logoAsset: StaticAssets.infocircleIcon,
                  textColor: AppColor.appLightBlue,
                  textSize: 18.sp,
                  imageSize: 20.w,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              const Divider(
                color: AppColor.appIconBackgound,
                thickness: 1,
              ),
              SizedBox(height: 30.h),
              GestureDetector(
                onTap: () {
                  controller.launchUrlInBrowser(ApiConfig.helpURL);
                },
                child: CustomTextWithIcon(
                  text: Strings.needHelp,
                  textColor: AppColor.appLightBlue,
                  textSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () {
                  Utils.confirmationAlert(
                      context: context,
                      description: Strings.areYouSureYouWantLogout,
                      positiveText: Strings.signOut,
                      negativeText: Strings.cancel,
                      onPressedPositive: () {
                        //TODO: API integration
                        controller.logoutAccount(ApiConfig.logoutURL, "");
                      },
                      onPressedNegative: () {
                        Get.back();
                      });
                },
                child: CustomTextWithIcon(
                  text: Strings.signOut,
                  textColor: AppColor.appLightBlue,
                  textSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () {
                  controller.launchUrlInBrowser(ApiConfig.shareAnalysisURL);
                },
                child: CustomTextWithIcon(
                  text: Strings.shareAnalysis,
                  logoAsset: StaticAssets.checkboxIcon,
                  textColor: AppColor.appLightBlue,
                  textSize: 14.sp,
                  imageSize: 14.w,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () {},
                child: CustomTextWithIcon(
                  text: Strings.appVersion,
                  textColor: AppColor.unselectedTab,
                  textSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
