import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/singleton.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/widgets/custom_radio_button.dart';
import 'package:vloo/app/data/widgets/custom_text_feild.dart';
import 'package:vloo/app/data/widgets/custom_text_with_icon.dart';
import 'package:vloo/app/data/widgets/primary_appbar.dart';
import 'package:vloo/app/modules/profile/controllers/profile_controller.dart';

class EditMyProfileView extends GetView<ProfileController> {
  const EditMyProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppbar(
        title: Strings.editMyProfile,
        text: Strings.confirm,
        onPressed2: () {
          controller.updateProfile(
              comingFromEdit: true,
              email: controller.email,
              phone: controller.phone,
              companyName: controller.companyName,
              name: controller.firstName,
              type: controller.type,
              city: controller.city,
              postCode: controller.postCode);
        },
        onPressed: () {
          Get.back();
        },
      ),
      backgroundColor: AppColor.primaryColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.w),
          child: SingleChildScrollView(
              child: Obx(
            () => Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                CustomTextWithIcon(
                  text: Strings.firstName,
                  logoAsset: StaticAssets.profileIcon,
                  textColor: AppColor.appLightBlue,
                  textSize: 14.sp,
                  imageSize: 20.w,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(
                  height: 8.h,
                ),
                CustomTextField(
                  name: 'name',
                  initialValue: Singleton.userObject?.firstName ?? "",
                  hint: Strings.firstName,
                  textInputType: TextInputType.name,
                  onChangeFtn: (value) {
                    controller.firstName = value ?? "";
                    return null;
                  },
                  validatorFtn: (value) {
                    return controller.validateName(value ?? "");
                  },
                  onSubmitFtn: (value) {
                    controller.formKey.currentState?.validate();
                    return null;
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextWithIcon(
                  text: Strings.emailAddress,
                  logoAsset: StaticAssets.emailIcon,
                  textColor: AppColor.appLightBlue,
                  textSize: 14.sp,
                  imageSize: 14.w,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(
                  height: 8.h,
                ),
                CustomTextField(
                  name: 'email',
                  hint: Strings.enterYourEmail,
                  initialValue: Singleton.userObject?.email ?? "",
                  textInputType: TextInputType.emailAddress,
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
                CustomTextWithIcon(
                  text: Strings.phoneNumber,
                  logoAsset: StaticAssets.phoneIcon,
                  textColor: AppColor.appLightBlue,
                  textSize: 14.sp,
                  imageSize: 20.w,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(
                  height: 8.h,
                ),
                CustomTextField(
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
                                package: controller
                                    .countryCode.value.flagImagePackage),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              controller.countryCode.value.dialCode,
                              style: CustomTextStyle.font14R,
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
                  /* initialValue: Singleton.userObject?.phoneNumber ?? "",*/
                  hint: Singleton.userObject?.phoneNumber ?? '',
                  onChangeFtn: (value) {
                    controller.phone = value ?? "";
                    return null;
                  },
                  validatorFtn: (value) {
                    return controller.validatePhone(value ?? "");
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
                CustomTextWithIcon(
                  text: Strings.use,
                  logoAsset: StaticAssets.useIcon,
                  textColor: AppColor.appLightBlue,
                  textSize: 14.sp,
                  imageSize: 18.w,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  children: [
                    CustomRadioRow(
                      title: Strings.personal,
                      isSelected: controller.selectedOption.value == 'personal',
                      onChanged: () =>
                          controller.selectedOption.value = 'personal',
                    ).marginOnly(right: 20.w),
                    CustomRadioRow(
                      title: Strings.professional,
                      isSelected:
                          controller.selectedOption.value == 'professional',
                      onChanged: () =>
                          controller.selectedOption.value = 'professional',
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                if (controller.selectedOption.value == 'professional' ||
                    Singleton.userObject?.useType == 'professional') ...[
                  Column(
                    children: [
                      CustomTextWithIcon(
                          text: Strings.company,
                          logoAsset: StaticAssets.buildingIcon,
                          textColor: AppColor.appLightBlue,
                          textSize: 14.sp,
                          imageSize: 18.w,
                          fontWeight: FontWeight.w400),
                      SizedBox(height: 8.h),
                      CustomTextField(
                        name: 'company',
                        hint: Strings.company,
                        initialValue: Singleton.userObject?.companyName ?? "",
                        textInputType: TextInputType.text,
                        onChangeFtn: (value) {
                          controller.companyName = value ?? "";
                          return null;
                        },
                        validatorFtn: (value) {
                          return controller.validateCompanyName(value ?? "");
                        },
                        onSubmitFtn: (value) {
                          controller.formKey.currentState?.validate();
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ],
                CustomTextWithIcon(
                    text: Strings.city,
                    logoAsset: StaticAssets.buildingIcon,
                    textColor: AppColor.appLightBlue,
                    textSize: 14.sp,
                    imageSize: 18.w,
                    fontWeight: FontWeight.w400),
                SizedBox(height: 8.h),
                CustomTextField(
                  name: 'city',
                  hint: Strings.city,
                  initialValue: Singleton.userObject?.companyCity ?? "",
                  textInputType: TextInputType.text,
                  onChangeFtn: (value) {
                    controller.city = value ?? "";
                    return null;
                  },
                  validatorFtn: (value) {
                    return controller.validateCity(value ?? "");
                  },
                  onSubmitFtn: (value) {
                    controller.formKey.currentState?.validate();
                    return null;
                  },
                ),
                SizedBox(height: 50.h),
                GestureDetector(
                  onTap: () {
                    controller.toForgotPassword();
                  },
                  child: CustomTextWithIcon(
                    text: Strings.changeYourPassword,
                    logoAsset: StaticAssets.keyIcon,
                    textColor: AppColor.appLightBlue,
                    textSize: 16.sp,
                    imageSize: 20.w,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 20.h),
                GestureDetector(
                    onTap: () {
                      controller.toDeleteAccount();
                    },
                    child: CustomTextWithIcon(
                        text: Strings.deleteAccount,
                        logoAsset: StaticAssets.basketIcon,
                        textColor: AppColor.red,
                        textSize: 16.sp,
                        imageSize: 20.w,
                        fontWeight: FontWeight.w400)),
                SizedBox(height: 60.h),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
