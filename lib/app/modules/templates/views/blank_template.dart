import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/widgets/primary_appbar.dart';
import 'package:vloo/app/modules/templates/controllers/templates_controller.dart';

class BlankTemplate extends GetView<TemplatesController> {
  const BlankTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppbar(
          title: 'blankTemplate'.tr,
          onPressed: () {
            Get.back();
          }),
      backgroundColor: AppColor.primaryColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 60.h,
              ),
              Text(
                'chooseOrientation'.tr,
                style: CustomTextStyle.font20R.copyWith(
                    color: AppColor.appLightBlue, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 50.h,
              ),
              GestureDetector(
                onTap: () {
                  controller.toCreateTemplateViewLandScape(
                      OrientationType.Landscape.name,
                      Strings.addTemplate,
                      null);
                },
                child: Container(
                  width: 238.w,
                  height: 134.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColor.appLightBlue,
                      width: 2.0,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        StaticAssets.vlooLogo,
                        height: 20.h,
                        width: 90.w,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Image.asset(
                        'assets/images/landscape_menu_board.png',
                        fit: BoxFit.fitWidth,
                      ) //TODO: will be changed later
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'landscapeMode'.tr,
                style: CustomTextStyle.font16L
                    .copyWith(color: AppColor.appLightBlue),
              ),
              SizedBox(
                height: 35.h,
              ),
              GestureDetector(
                onTap: () {
                  controller.toCreateTemplateView(
                      OrientationType.Portrait.name, Strings.addTemplate, null);
                },
                child: Container(
                  height: 238.h,
                  width: 134.w,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColor.appLightBlue,
                      width: 2.0,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        StaticAssets.vlooLogo,
                        height: 20.h,
                        width: 68.w,
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Image.asset(
                          'assets/images/portrait_menu_board.png') //TODO: will be changed later
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                'portraitMode'.tr,
                style: CustomTextStyle.font16R
                    .copyWith(color: AppColor.appLightBlue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
