import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/widgets/custom_buttons.dart';
import 'package:vloo/app/data/widgets/custom_text_feild.dart';
import 'package:vloo/app/data/widgets/primary_appbar.dart';
import '../controllers/forgot_password_controller.dart';

class NewPassword extends GetView<ForgotPasswordController> {
  const NewPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppbar(
          title: Strings.forgetYourPassword,
          onPressed: () {
            Get.back();
          }),
      backgroundColor: AppColor.primaryColor,
      body: Padding(
        padding: EdgeInsets.only(left: 40.w, right: 40.w, top: 100.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 109.w,
                width: 186.w,
                child: Image.asset('assets/images/forgot_password.png'), // TODO: will change later
              ),
              SizedBox(
                height: 9.w,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    StaticAssets.passwordIcon,
                    fit: BoxFit.none,
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Text(
                    Strings.newPassword,
                    style: CustomTextStyle.font16R,
                  ),
                ],
              ),
              SizedBox(
                height: 9.w,
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
                  onChangeFtn: (value) {
                    controller.passwordValue = value ?? "";
                  },
                  validatorFtn: FormBuilderValidators.minLength(8, errorText: 'At-least 8 characters needed'),
                  onSubmitFtn: (value) {
                    controller.formKey.currentState?.validate();
                  },
                ),
              ),
              SizedBox(
                height: 9.w,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    StaticAssets.passwordIcon,
                    fit: BoxFit.none,
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Text(
                    Strings.confirmNewPassword,
                    style: CustomTextStyle.font16R,
                  ),
                ],
              ),
              SizedBox(
                height: 9.w,
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
                  onChangeFtn: (value) {
                    controller.confirmPasswordValue = value ?? "";
                  },
                  validatorFtn: (value) {
                    return controller.validatePassword(value ?? "");
                  },
                  onSubmitFtn: (value) {
                    controller.formKey.currentState?.validate();
                  },
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
                  controller.resetPasswordAPI(controller.token, controller.email, controller.passwordValue, controller.confirmPasswordValue);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
