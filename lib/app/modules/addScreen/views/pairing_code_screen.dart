
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/qr_view_camera.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/widgets/custom_buttons.dart';
import 'package:vloo/app/data/widgets/custom_text_feild.dart';
import 'package:vloo/app/data/widgets/primary_appbar.dart';
import 'package:vloo/app/modules/addScreen/controllers/add_screen_controller.dart';


class PairingCodeScreenView extends GetView<AddScreenController> {
  const PairingCodeScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (canPop){
        controller.textController.clear();

      },
      child: Scaffold(
        backgroundColor: AppColor.primaryColor,
        appBar: PrimaryAppbar(
            title: Strings.synchronizationWithVlooDongleTV,
            onPressed: () {
              Get.back();
              controller.textController.clear();
            }),
        body: SingleChildScrollView(
          child:  Container(
              margin: const EdgeInsets.only(top: 30),
              padding: EdgeInsets.symmetric(horizontal: 50.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 40.h),
                  Text(Strings.syncScreenHeading, textAlign: TextAlign.center, style: CustomTextStyle.font20R.copyWith(fontWeight: FontWeight.bold)),
                  SizedBox(height: 20.h),
                  Text(Strings.enterScreenCodeMessage, textAlign: TextAlign.center, style: CustomTextStyle.font18R),
                  SizedBox(height: 50.h),
                  Text(Strings.pairingCode, textAlign: TextAlign.center, style: CustomTextStyle.font16R),
                  SizedBox(height: 10.h),
                  TextFormField(
                    textAlign: TextAlign.center,
                    controller: controller.textController,
                    style: CustomTextStyle.font16R,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        hintText: "Ex: 210988",
                        hintStyle: CustomTextStyle.font12R.copyWith(color: AppColor.appLightBlue.withOpacity(0.5)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.sp),
                          borderSide: const BorderSide(
                            color: AppColor.appLightBlue,
                          ),
                        ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40.sp),
                        borderSide: const BorderSide(
                          color: AppColor.appLightBlue,
                        ),
                      ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.sp),
                          borderSide: const BorderSide(
                            color: AppColor.secondaryColor,
                            width: 2,
                          ),
                        )
                    ),
                    onChanged: (value) {
                      controller.pairingCodeValue.value = value ?? "";
                    },
                    validator: (value) {
                      // return controller.validateName(value ?? "");
                    },
                    onFieldSubmitted: (value) {
                      // controller.formKey.currentState?.validate();
                    },
                  ),
                  SizedBox(height: 50.h),
                  Text(Strings.or, textAlign: TextAlign.center, style: CustomTextStyle.font16R),
                  SizedBox(height: 20.h),
                  GestureDetector(
                    onTap: () async {

                      controller.pairingCodeValue.value = await Get.to(const QRViewCamera()) ?? '';
                      controller.textController.text = controller.pairingCodeValue.value;
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          StaticAssets.icQRCode,
                          width: 30.w,
                          height: 30.h,
                          fit: BoxFit.fill,
                          color: AppColor.appLightBlue,
                          placeholderBuilder: (BuildContext context) => Container(
                              padding: const EdgeInsets.all(30.0),
                              child: const CircularProgressIndicator()),
                        ),
                        SizedBox(width: 10.w),
                        Text(Strings.scanQRCodeAppearsOnYourTVScreen, textAlign: TextAlign.center, style: CustomTextStyle.font14R),
                      ],
                    ),
                  ),
                  SizedBox(height: 40.h),
                  CustomButton(
                    buttonName: Strings.confirm,
                    backgroundColor: AppColor.appSkyBlue,
                    borderColor: Colors.transparent,
                    width: 300.w,
                    height: 60.h,
                    isbold: true,
                    onPressed: () {
                      controller.updateMyScreenOrientation(controller.pairingCodeValue.value, "", "", 1);
                    },
                  ),
                ],
              )),


        ),
      ),
    );
  }
}
