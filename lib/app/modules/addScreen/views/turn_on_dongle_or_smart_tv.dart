import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/widgets/custom_buttons.dart';
import 'package:vloo/app/data/widgets/primary_appbar.dart';
import 'package:vloo/app/modules/addScreen/controllers/add_screen_controller.dart';

import 'synchronization_with _vloo_dongle_tv.dart';

class TurnOnDongleOrSmartTvScreen extends GetView<AddScreenController> {
  final String buttonText;
  final String doneOrSmartTvText;
  final String imagePath;
  final RichText descriptionText;
  final double buttonHeight;

  const TurnOnDongleOrSmartTvScreen({
    super.key,
   required this.buttonText,
    required this.doneOrSmartTvText,
    required this.imagePath,
    required this.descriptionText,
    required this.buttonHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: PrimaryAppbar(
          title: Strings.addSyncScreen,
          onPressed: () {
            Get.back();
          }),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          margin:  EdgeInsets.only(top: 20.h),
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                StaticAssets.vlooLogo,
                height: 39.h,
                width: 130.w,
                placeholderBuilder: (BuildContext context) => Container(
                    padding: const EdgeInsets.all(30.0),
                    child: const CircularProgressIndicator()),
              ),
              SizedBox(height: 20.h),
              Image.asset(imagePath),
              SizedBox(
                height: 30.h,
              ),
              descriptionText,
              SizedBox(
                height: 20.h,
              ),
              Text('I don\'t have a Vloo $doneOrSmartTvText' ,
                  textAlign: TextAlign.center,
                  style: CustomTextStyle.font18R
                      .copyWith(decoration: TextDecoration.underline)),
              SizedBox(
                height: 60.h,
              ),
              CustomButton(
                buttonName: buttonText,
                borderColor: Colors.transparent,
                backgroundColor: AppColor.appSkyBlue,
                width: 320.w,
                height: buttonHeight,
                isbold: true,
                onPressed: () {
                  Get.to(const SynchronizationWithVlooDongleTV());
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        children: <InlineSpan>[
                          WidgetSpan(
                            child: SvgPicture.asset(StaticAssets.icHelpCenterIcon, width: 20, height: 20,),
                          ),
                          TextSpan(text: ' ${Strings.needHelpInstalling} $doneOrSmartTvText',
                              style: CustomTextStyle.font16R.copyWith(decoration: TextDecoration.underline)
                            ),

                        ],
                      )
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
