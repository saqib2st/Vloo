import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/Responsive.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/widgets/custom_buttons.dart';
import 'package:vloo/app/data/widgets/custom_text_feild.dart';
import 'package:vloo/app/data/widgets/primary_appbar.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppbar(
        title: Strings.signIn,
        onPressed: controller.toIntroduction,
      ),
      backgroundColor: AppColor.primaryColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.w),
          child: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  Responsive(
                    mobile: SvgPicture.asset(
                      StaticAssets.vlooLogo,
                    ),
                    tablet: SvgPicture.asset(
                      StaticAssets.vlooLogo,
                      width: 250.h,
                      fit: BoxFit.fitWidth,
                    ).paddingOnly(bottom: 40.h, top: 30.h),
                  ),
                  SizedBox(
                    height: 70.h,
                  ),
                  CustomTextField(
                    name: 'email',
                    hint: Strings.enterYourEmail,
                    textInputType: TextInputType.emailAddress,
                    prefixIcon: SvgPicture.asset(
                      StaticAssets.emailIcon,
                      // fit: BoxFit.none,
                    ),
                    onChangeFtn: (value) {
                      controller.userNameValue = value ?? "";
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
                  SizedBox(
                    height: 20.h,
                  ),
                  Obx(
                    () => CustomTextField(
                      name: 'password',
                      hint: Strings.enterYourPassword,
                      onTapEye: () {
                        controller.showPassToggle();
                      },
                      isPass: true,
                      show: controller.showPass.value,
                      textInputType: TextInputType.visiblePassword,
                      prefixIcon: SvgPicture.asset(
                        StaticAssets.passwordIcon,
                      ),
                      onChangeFtn: (value) {
                        controller.passwordValue = value ?? "";
                        return null;
                      },
                      validatorFtn: FormBuilderValidators.minLength(8,
                          errorText: Strings.atLeast8Char),
                      onSubmitFtn: (value) {
                        controller.formKey.currentState?.validate();
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: controller.toForgotPassword,
                      child: Text(Strings.forgetYourPassword,
                          style: CustomTextStyle.font14R.copyWith(
                            color: AppColor.appLightBlue,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 39.h,
                  ),
                  CustomButton(
                    buttonName: Strings.signIn,
                    height: 58.h,
                    width: 288.w,
                    textColor: AppColor.primaryColor,
                    isbold: true,
                    backgroundColor: AppColor.secondaryColor,
                    onPressed: () {
                      controller.doLogin(
                          controller.userNameValue, controller.passwordValue);
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    Strings.youDoNotHaveAnAccount,
                    style: CustomTextStyle.font16R
                        .copyWith(color: AppColor.appLightBlue),
                  ),
                  GestureDetector(
                    onTap: controller.toSignup,
                    child: Text(
                      Strings.register,
                      style: CustomTextStyle.font16R.copyWith(
                          color: AppColor.appLightBlue,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
