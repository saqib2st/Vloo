import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/widgets/custom_buttons.dart';
import 'package:vloo/app/modules/signup/controllers/signup_controller.dart';

class SuccessRegistration extends GetView<SignupController> {
  const SuccessRegistration({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 191.h,
                  width: 191.w,
                  child: Image.asset(
                    'assets/images/star.gif',
                  ), //TODO: will be changed later
                ),
                Text(
                  Strings.successful,
                  style: CustomTextStyle.font20R.copyWith(
                      color: AppColor.appLightBlue,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 135.h,
                ),
                Text(
                  Strings.createDisplayWithoutLimits,
                  style: CustomTextStyle.font20R.copyWith(
                    color: AppColor.appLightBlue,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 49.h,
                ),
                CustomButton(
                  buttonName: Strings.letsGo,
                  height: 58.h,
                  width: 288.w,
                  textColor: AppColor.primaryColor,
                  isbold: true,
                  backgroundColor: AppColor.secondaryColor,
                  onPressed: controller.toHome,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
