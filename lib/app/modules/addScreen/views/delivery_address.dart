import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/widgets/custom_buttons.dart';
import 'package:vloo/app/data/widgets/custom_text_feild.dart';
import 'package:vloo/app/data/widgets/primary_appbar.dart';
import 'package:vloo/app/modules/addScreen/controllers/add_screen_controller.dart';
import 'package:vloo/app/modules/addScreen/views/detail_of_order.dart';

class DeliveryAddress extends GetView<AddScreenController> {
  const DeliveryAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: PrimaryAppbar(
          title: Strings.deliveryAddressVlooDongleTV,
          onPressed: () {
            Get.back();
          }),
      body: SingleChildScrollView(
        child: Container(
          height: Get.height*0.78,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 45.h),
              CustomTextField(
                name: 'name',
                hint: Strings.firstName,
                textInputType: TextInputType.name,
                prefixIcon: SvgPicture.asset(
                  StaticAssets.personTfIcon,
                  placeholderBuilder: (BuildContext context) => Container(
                      padding: const EdgeInsets.all(30.0),
                      child: const CircularProgressIndicator()),
                ),
                onChangeFtn: (value) {
                  controller.firstName = value ?? "";
                },
                validatorFtn: (value) {
                  return controller.validateName(value ?? "");
                },
                onSubmitFtn: (value) {
                  // controller.formKey.currentState?.validate();
                },
              ),
              CustomTextField(
                name: 'name',
                hint: Strings.lastName,
                textInputType: TextInputType.name,
                prefixIcon: SvgPicture.asset(
                  StaticAssets.personTfIcon,
                  placeholderBuilder: (BuildContext context) => Container(
                      padding: const EdgeInsets.all(30.0),
                      child: const CircularProgressIndicator()),
                ),
                onChangeFtn: (value) {
                  controller.lastName = value ?? "";
                },
                validatorFtn: (value) {
                  return controller.validateLastName(value ?? "");
                },
                onSubmitFtn: (value) {
                  controller.formKey.currentState?.validate();
                },
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
                      SvgPicture.asset(
                        StaticAssets.phoneIcon,
                        fit: BoxFit.scaleDown,
                        placeholderBuilder: (BuildContext context) => Container(
                            padding: const EdgeInsets.all(30.0),
                            child: const CircularProgressIndicator()),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      SvgPicture.asset(
                        StaticAssets.dropDownIcon,
                        fit: BoxFit.scaleDown,
                        placeholderBuilder: (BuildContext context) => Container(
                            padding: const EdgeInsets.all(30.0),
                            child: const CircularProgressIndicator()),
                      ),
                      SizedBox(width: 5.w),
                      Obx(() => Row(
                        children: [
                          Image.asset(
                              width : 30.w,
                              controller.countryCode.value.flagUri,
                              package: controller.countryCode.value.flagImagePackage
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            controller.countryCode.value.dialCode,
                            style: CustomTextStyle.font14R,
                          ),
                        ],
                      )),
                      SizedBox(width: 6.w),
                      Container(
                        height: 20,
                        width: 2,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 6.w),
                    ],
                  ),
                ),
                textcontoller: controller.countryCodeController,
                name: "countryCode",
                hint: Strings.phoneNumber,
                onChangeFtn: (value) {
                  controller.phone = value ?? "";
                },
                validatorFtn: (value) {
                  return controller.validatePhone(value ?? "");
                },
                onSubmitFtn: (value) {
                  controller.formKey.currentState?.validate();
                },
                textInputType: TextInputType.number,
              ),
              CustomTextField(
                name: 'name',
                hint: Strings.deliveryAddress,
                textInputType: TextInputType.name,
                prefixIcon: SvgPicture.asset(
                  StaticAssets.locationIcon,
                  placeholderBuilder: (BuildContext context) => Container(
                      padding: const EdgeInsets.all(30.0),
                      child: const CircularProgressIndicator()),
                ),
                onChangeFtn: (value) {
                  controller.deliveryAddress = value ?? "";
                },
                validatorFtn: (value) {
                  return controller.validateDeliveryAddress(value ?? "");
                },
                onSubmitFtn: (value) {
                  controller.formKey.currentState?.validate();
                },
              ),
              CustomTextField(
                name: 'name',
                hint: Strings.aptUnitCompanyName,
                textInputType: TextInputType.name,
                prefixIcon: SvgPicture.asset(
                  StaticAssets.locationIcon,
                  placeholderBuilder: (BuildContext context) => Container(
                      padding: const EdgeInsets.all(30.0),
                      child: const CircularProgressIndicator()),
                ),
                onChangeFtn: (value) {
                  controller.companyName = value ?? "";
                },
                validatorFtn: (value) {
                  return controller.validateCompanyName(value ?? "");
                },
                onSubmitFtn: (value) {
                  controller.formKey.currentState?.validate();
                },
              ),
              CustomTextField(
                name: 'name',
                hint: Strings.postalCode,
                textInputType: TextInputType.text,
                prefixIcon: SvgPicture.asset(
                  StaticAssets.locationIcon,
                  placeholderBuilder: (BuildContext context) => Container(
                      padding: const EdgeInsets.all(30.0),
                      child: const CircularProgressIndicator()),
                ),
                onChangeFtn: (value) {
                  controller.postelCode = value ?? "";
                },
                validatorFtn: (value) {
                  return controller.validatePostelCode(value ?? "");
                },
                onSubmitFtn: (value) {
                  controller.formKey.currentState?.validate();
                },
              ),
              CustomTextField(
                name: 'name',
                hint: Strings.city,
                textInputType: TextInputType.name,
                prefixIcon: SvgPicture.asset(
                  StaticAssets.buildingIcon,
                  placeholderBuilder: (BuildContext context) => Container(
                      padding: const EdgeInsets.all(30.0),
                      child: const CircularProgressIndicator()),
                ),
                onChangeFtn: (value) {
                  controller.city = value ?? "";
                },
                validatorFtn: (value) {
                  return controller.validateCity(value ?? "");
                },
                onSubmitFtn: (value) {
                  controller.formKey.currentState?.validate();
                },
              ),
              CustomButton(
                buttonName: Strings.confirm,
                backgroundColor: AppColor.appSkyBlue,
                width: 260.w,
                height: 60.h,
                isbold: true,
                textSize: 16.sp,
                onPressed: () {
                  controller.navigateNextToOrderDetails();
                },
              ).marginOnly(top: 20.h),
            ],
          ),
        ).paddingOnly(bottom: 15.h),
      ),
    );
  }
}
