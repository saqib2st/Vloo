import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/widgets/custom_buttons.dart';
import 'package:vloo/app/data/widgets/custom_radio_button.dart';
import 'package:vloo/app/data/widgets/custom_text_feild.dart';
import 'package:vloo/app/data/widgets/primary_appbar.dart';
import 'package:vloo/app/modules/profile/controllers/profile_controller.dart';


class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppbar(
        title: Strings.registration,
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
                      height: 89.h,
                      width: 89.w,
                      child: Image.asset('assets/images/user.png'), //TODO: to be changed later
                    ),
                    Text(
                      Strings.tellUsMoreAboutYou,
                      style: CustomTextStyle.font16R.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColor.appLightBlue),
                    ),
                    SizedBox(
                      height: 70.h,
                    ),
                    CustomTextField(
                      name: 'name',
                      hint: Strings.firstName,
                      textInputType: TextInputType.name,
                      prefixIcon: SvgPicture.asset(
                        StaticAssets.personTfIcon,
                      ),
                      onChangeFtn: (value){
                        controller.firstName = value ?? "";
                      },
                      validatorFtn: (value) {
                        return controller.validateName(value ?? "");
                      },
                      onSubmitFtn: (value){
                        controller.formKey.currentState?.validate();
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          StaticAssets.useIcon,
                          fit: BoxFit.none,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          Strings.use,
                          style: CustomTextStyle.font14R,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      children: [
                        CustomRadioRow(
                          title: Strings.personal,
                          isSelected: controller.selectedOption.value == 'personal',
                          onChanged: () => controller.selectedOption.value = 'personal',
                        ),
                        const Spacer(),
                        CustomRadioRow(
                          title: Strings.professional,
                          isSelected: controller.selectedOption.value == 'professional',
                          onChanged: () => controller.selectedOption.value = 'professional',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    if (controller.selectedOption.value == 'professional')
                      CustomTextField(
                        name: 'company',
                        hint: Strings.company,
                        textInputType: TextInputType.text,
                        prefixIcon: SvgPicture.asset(
                          StaticAssets.buildingIcon,
                        ),
                        onChangeFtn: (value){
                          controller.companyName = value ?? "";
                        },
                        validatorFtn: (value) {
                          return controller.validateCompanyName(value ?? "");
                        },
                        onSubmitFtn: (value){
                          controller.formKey.currentState?.validate();
                        },
                      ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTextField(
                      name: 'city',
                      hint: Strings.city,
                      textInputType: TextInputType.text,
                      prefixIcon: SvgPicture.asset(
                        StaticAssets.buildingIcon,
                      ),
                      onChangeFtn: (value){
                        controller.city = value ?? "";
                      },
                      validatorFtn: (value) {
                        return controller.validateCity(value ?? "");
                      },
                      onSubmitFtn: (value){
                        controller.formKey.currentState?.validate();
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTextField(
                      name: 'postCode',
                      hint: Strings.postCode,
                      textInputType: TextInputType.text,
                      prefixIcon: SvgPicture.asset(
                        StaticAssets.buildingIcon,
                      ),
                      onChangeFtn: (value){
                        controller.postCode = value ?? "";
                      },
                      onSubmitFtn: (value){
                        controller.formKey.currentState?.validate();
                      },
                    ),
                    SizedBox(
                      height: 60.h,
                    ),
                    CustomButton(
                      buttonName: Strings.completeRegistration,
                      height: 58.h,
                      width: 288.w,
                      textColor: AppColor.primaryColor,
                      isbold: true,
                      backgroundColor: AppColor.secondaryColor,
                      onPressed:(){
                        controller.updateProfile(comingFromEdit: false, name: controller.firstName, type: controller.type, city: controller.city, postCode: controller.postCode);
                    }),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
