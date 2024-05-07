import 'package:fl_country_code_picker/fl_country_code_picker.dart';
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

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppbar(
        title: Strings.registration,
        onPressed: controller.toIntroduction,
      ),
      backgroundColor: AppColor.primaryColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          children: [
            Responsive(
              mobile: SvgPicture.asset(
                StaticAssets.vlooLogo,
              ).paddingOnly(bottom: 70.h, top: 10.h),
              tablet: SvgPicture.asset(
                StaticAssets.vlooLogo,
                width: 250.h,
                fit: BoxFit.fitWidth,
              ).paddingOnly(bottom: 40.h, top: 30.h),
            ),
            CustomTextField(
              name: 'email',
              hint: Strings.enterYourEmail,
              textInputType: TextInputType.emailAddress,
              prefixIcon: SvgPicture.asset(StaticAssets.emailIcon),
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
            SizedBox(
              height: 20.h,
            ),
            CustomTextField(
              hint: Strings.enterYourPhone,
              prefixIcon: GestureDetector(
                onTap: () async {
                  controller.onPressedCountryCodeField(context);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 12.w,
                    ),
                    SvgPicture.asset(
                      StaticAssets.phoneIcon,
                      fit: BoxFit.scaleDown,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    SvgPicture.asset(
                      StaticAssets.dropDownIcon,
                      fit: BoxFit.scaleDown,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Obx(() => Row(
                      children: [
                        Image.asset(
                            width: 30.w,
                            controller.countryCode.value.flagUri,
                            package:
                            controller.countryCode.value.flagImagePackage ),
                        SizedBox(width: 5.w),
                        Text(
                          controller.countryCode.value.dialCode,
                          style: CustomTextStyle.font16R,
                        ),
                      ],
                    )),
                    SizedBox(
                      width: 6.w,
                    ),
                    Container(
                      height: 20,
                      width: 2,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 6.w,
                    ),
                  ],
                ),
              ),
              textcontoller: controller.countryCodeController,
              name: "countryCode",
              onChangeFtn: (value) {
                controller.phone = value ?? "";
                return null;
              },
              validatorFtn: (value) {
                return controller.validateMobile(value ?? "");
              },
              onSubmitFtn: (value) {
                controller.formKey.currentState?.validate();
                return null;
              },
              textInputType: TextInputType.number,
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
                    errorText: 'At-least 8 characters needed'),
                onSubmitFtn: (value) {
                  controller.formKey.currentState?.validate();
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Obx(
              () => CustomTextField(
                name: 'confirmpassword',
                hint: Strings.reEnterYourPassword,
                onTapEye: () {
                  controller.showConfirmPassToggle();
                },
                isPass: true,
                show: controller.showConfirmPass.value,
                textInputType: TextInputType.visiblePassword,
                prefixIcon: SvgPicture.asset(
                  StaticAssets.passwordIcon,
                ),
                onChangeFtn: (value) {
                  controller.confirmPasswordValue = value ?? "";
                  return null;
                },
                validatorFtn: (value) {
                  return controller.validatePassword(value ?? "");
                },
                onSubmitFtn: (value) {
                  controller.formKey.currentState?.validate();
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 60.h,
            ),
            CustomButton(
              buttonName: Strings.register,
              height: 58.h,
              width: 288.w,
              textColor: AppColor.primaryColor,
              isbold: true,
              backgroundColor: AppColor.secondaryColor,
              onPressed: () {
                controller.registerAccount(controller.email, controller.phone,
                    controller.passwordValue);
              },
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              '${Strings.alreadyHaveAccount}?',
              style: CustomTextStyle.font16R
                  .copyWith(color: AppColor.appLightBlue),
            ),
            GestureDetector(
              onTap: controller.toLogin,
              child: Text(
                Strings.signIn,
                style: CustomTextStyle.font16R.copyWith(
                    fontWeight: FontWeight.bold, color: AppColor.appLightBlue),
              ),
            ),
            Responsive(
              mobile: SizedBox(
                height: 30.h,
              ),
              tablet: SizedBox(
                height: 10.h,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(
                  () => Theme(
                    data: ThemeData(
                      unselectedWidgetColor: AppColor.appLightBlue,
                    ),
                    child: Transform.scale(
                      scale: 1.1.sp,
                      child: Checkbox(
                        value: controller.isChecked.value,
                        onChanged: (bool? value) {
                          controller.isChecked.value = value ?? false;
                        },
                        activeColor: AppColor.appLightBlue,
                        checkColor: Colors.black,
                      ).marginOnly(bottom: 10.h, right: 5.w),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.byCreatingAnAccount,
                      style: CustomTextStyle.font14R.copyWith(
                        color: AppColor.appLightBlue,
                      ),
                    ),
                    Text(
                      Strings.termsService,
                      style: CustomTextStyle.font14R.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColor.appLightBlue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
