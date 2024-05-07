import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/widgets/custom_buttons.dart';
import 'package:vloo/app/data/widgets/custom_text_feild.dart';
import 'package:vloo/app/data/widgets/primary_appbar.dart';
import '../controllers/forgot_password_controller.dart';

class VerifyPin extends GetView<ForgotPasswordController> {
  const VerifyPin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppbar(

          title: Strings.verifyCode,
          onPressed: () {
            Get.back();
          }),
      backgroundColor: AppColor.primaryColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 109.w,
                  width: 186.w,
                  child: Image.asset('assets/images/forgot_password.png'), // TODO: will change later
                ),
                SizedBox(
                  height: 77.w,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        textAlign: TextAlign.center,
                        Strings.verifyCodeDescription,
                        style: CustomTextStyle.font16R,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 9.w,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Pinput(
                    autofocus: true,
                    controller: controller.codeTC,
                    validator: (value) {
                      if (value?.length != 4) {
                        return "not valid";
                      }
                      return null;
                    },
                    length: 4,
                    isCursorAnimationEnabled: true,
                    showCursor: true,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    defaultPinTheme: PinTheme(
                      height: 50.w,
                      width: 300.w,
                      textStyle: TextStyle(fontSize: 24.w, color: AppColor.secondaryColor),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColor.secondaryColor),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.w,
                ),
                CustomButton(
                  buttonName: Strings.send,
                  height: 58.w,
                  width: 288.w,
                  textColor: AppColor.primaryColor,
                  isbold: true,
                  backgroundColor: AppColor.secondaryColor,
                  onPressed: () {
                    controller.validatePinCode(controller.codeTC.text);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
