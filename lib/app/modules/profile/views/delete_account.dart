import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/api_config.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/utils/utils.dart';
import 'package:vloo/app/data/widgets/custom_buttons.dart';
import 'package:vloo/app/data/widgets/custom_text_feild.dart';
import 'package:vloo/app/data/widgets/custom_text_with_icon.dart';
import 'package:vloo/app/data/widgets/primary_appbar.dart';
import 'package:vloo/app/modules/profile/controllers/profile_controller.dart';

class DeleteAccountView extends GetView<ProfileController> {
  const DeleteAccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppbar(
          title: Strings.deleteAccount,
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
                  child: Image.asset('assets/images/sad_face.png'), // TODO: will change later
                ),
                SizedBox(
                  height: 20.w,
                ),
                Center(
                  child: Text(
                    Strings.deleteAccountWarning,
                    style: CustomTextStyle.font20R,
                  ),
                ),
                SizedBox(
                  height: 77.w,
                ),
                CustomTextWithIcon(
                  text: Strings.oldPassword,
                  logoAsset: StaticAssets.passwordIcon,
                  textColor: AppColor.appLightBlue,
                  textSize: 16.sp,
                  imageSize: 16.w,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(
                  height: 9.w,
                ),
                Obx(
                  () => CustomTextField(
                    name: 'oldPassword',
                    hint: Strings.enterYourPassword,
                    onTapEye: () {
                      controller.showPassToggle();
                    },
                    isPass: true,
                    show: controller.showPass.value,
                    textInputType: TextInputType.visiblePassword,
                    onChangeFtn: (value) {
                      controller.passwordValue = value ?? "";
                    },
                    validatorFtn: FormBuilderValidators.minLength(8, errorText: Strings.atLeast8Char),
                    onSubmitFtn: (value) {
                      controller.formKey.currentState?.validate();
                    },
                  ),
                ),
                SizedBox(
                  height: 50.w,
                ),
                CustomButton(
                  buttonName: Strings.deleteAccount,
                  height: 58.w,
                  width: 288.w,
                  textColor: AppColor.primaryColor,
                  isbold: true,
                  type: ButtonVariant.filled,
                  color: AppColor.red,
                  backgroundColor: AppColor.red,
                  onPressed: () {
                    Utils.confirmationAlert(
                        context: context,
                        description: Strings.deleteYourAccount,
                        positiveText: Strings.delete,
                        negativeText: Strings.cancel,
                        onPressedPositive: () {
                          Get.back();

                          Utils.confirmationAlert(
                              context: context,
                              description: Strings.deleteAccountPermanent,
                              positiveText: Strings.soft,
                              negativeText: Strings.permanently,
                              onPressedPositive: () {
                                Get.back();
                                controller.logoutAccount(ApiConfig.softDeleteAccountURL, controller.passwordValue);
                              },
                              onPressedNegative: () {
                                Get.back();
                                controller.logoutAccount(ApiConfig.deleteAccountPermanentlyURL, controller.passwordValue);
                              });
                        },
                        onPressedNegative: () {
                          Get.back();
                        });


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
