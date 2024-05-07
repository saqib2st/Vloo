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

class AddScreenNameView extends GetView<AddScreenController> {
  final String? pairingCode;

  const AddScreenNameView({Key? key, required this.pairingCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: PrimaryAppbar(
          title: Strings.nameOfTheScreen,
          onPressed: () {
            Get.back();
          }),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 30),
          padding: EdgeInsets.symmetric(horizontal: 50.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40.h),
              Text(Strings.yourScreenAddedSuccess, textAlign: TextAlign.center, style: CustomTextStyle.font20R.copyWith(fontWeight: FontWeight.bold)),
              SizedBox(height: 80.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    StaticAssets.tvSimple,
                    width: 20.w,
                    height: 20.h,
                    fit: BoxFit.fill,
                    color: AppColor.appLightBlue,
                    placeholderBuilder: (BuildContext context) => Container(
                        padding: const EdgeInsets.all(30.0),
                        child: const CircularProgressIndicator()),
                  ),
                  SizedBox(width: 10.w),
                  Text(Strings.addNameThisScreen, textAlign: TextAlign.center, style: CustomTextStyle.font14R),
                ],
              ),
              SizedBox(height: 20.h),
              CustomTextField(
                textAlignment: TextAlign.center,
                name: Strings.name,
                hint: Strings.exMyScreen1,
                textInputType: TextInputType.name,
                onChangeFtn: (value) {
                  controller.screenName.value = value ?? "";
                },
                validatorFtn: (value) {
                  // return controller.validateName(value ?? "");
                },
                onSubmitFtn: (value) {
                  // controller.formKey.currentState?.validate();
                },
              ),
              SizedBox(height: 40.h),
              Obx(
                () => CustomButton(
                  buttonName: Strings.finish,
                  backgroundColor: controller.screenName.value == "" ? AppColor.disableColor : AppColor.appSkyBlue,
                  borderColor: Colors.transparent,
                  width: 300.w,
                  height: 60.h,
                  isbold: true,
                  onPressed: () {
                    controller.updateMyScreenOrientation(controller.pairingCodeValue.value, "", controller.screenName.value, 3);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
