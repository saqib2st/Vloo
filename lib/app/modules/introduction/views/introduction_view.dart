import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/Responsive.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/widgets/custom_buttons.dart';
import '../controllers/introduction_controller.dart';

class IntroductionView extends GetView<IntroductionController> {
  const IntroductionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Responsive(
                  mobile: SvgPicture.asset(
                    StaticAssets.splashLogo,
                    height: 88.h,
                    width: 185.w,
                  ),
                  tablet: SvgPicture.asset(
                    StaticAssets.splashLogo,
                    height: 120.h,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),

                Responsive(
                  mobile: SizedBox(
                    height: 184.h,
                    width: 249.w,
                    child: Image.asset('assets/images/splash_image.png'),
                  ),
                  tablet: SizedBox(
                    height: 220.h,
                    width: 400.w,
                    child: Image.asset('assets/images/splash_image.png',
                      height: 200.h,
                      width: 350.w,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  Strings.welcomeToVloo,
                  style: CustomTextStyle.font22R.copyWith(
                      color: AppColor.appLightBlue,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  Strings.createDisplayMenuBoards,
                  style: CustomTextStyle.font20R
                      .copyWith(color: AppColor.appLightBlue),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 35.h,
                ),
                CustomButton(
                  buttonName: Strings.start,
                  height: 58.h,
                  width: 288.w,
                  textColor: AppColor.primaryColor,
                  isbold: true,
                  backgroundColor: AppColor.secondaryColor,
                  onPressed: controller.toSignup,
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomButton(
                  buttonName: Strings.alreadyHaveAccount,
                  height: 58.h,
                  width: 288.w,
                  color: AppColor.appLightBlue,
                   onPressed: controller.toLogin,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  
  }
}
