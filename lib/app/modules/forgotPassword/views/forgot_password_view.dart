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
import 'package:vloo/app/data/widgets/custom_text_feild.dart';
import 'package:vloo/app/data/widgets/loading_widget.dart';
import 'package:vloo/app/data/widgets/primary_appbar.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppbar(
          title: Strings.forgetYourPasswordSimple,
          onPressed: () {
            Get.back();
          }),
      backgroundColor: AppColor.primaryColor,
      body: LoadingWidget(
        widget: Padding(
          padding: EdgeInsets.only(left: 40.w, right: 40.w, top: 100.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Responsive(
                    mobile: SizedBox(
                      height: 109.h,
                      width: 186.w,
                      child: Image.asset(
                          'assets/images/forgot_password.png'), // TODO: will change later
                    ),
                    tablet: SizedBox(
                      child: Image.asset(
                        'assets/images/forgot_password.png',
                        height: 130.h,
                        width: 200.w,
                        fit: BoxFit.fitHeight,
                      ), // TODO: will change later
                    )),
                SizedBox(height: 77.h),
                CustomTextField(
                  name: 'email',
                  hint: Strings.enterYourEmail,
                  textInputType: TextInputType.emailAddress,
                  prefixIcon: SvgPicture.asset(
                    StaticAssets.emailIcon,
                  ),
                  onChangeFtn: (value) {
                    controller.email = value ?? "";
                    return null;
                  },
                  validatorFtn: (value) {
                    return controller.validateEmail(value ?? "");
                  },
                  onSubmitFtn: (value) {
                    controller.formKey.currentState?.validate();
                    return null;
                  },
                ),
                SizedBox(height: 23.h),
                Text(
                  Strings.sendEmail,
                  style: CustomTextStyle.font16R
                      .copyWith(color: AppColor.appLightBlue),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 36.h),
                CustomButton(
                    buttonName: Strings.send,
                    height: 58.h,
                    width: 288.w,
                    textColor: AppColor.primaryColor,
                    isbold: true,
                    backgroundColor: AppColor.secondaryColor,
                    onPressed: () {
                      Get.put(ForgotPasswordController());
                      controller.sendEmail(controller.email);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
