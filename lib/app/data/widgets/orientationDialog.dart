import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/models/screens/ScreenModel.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/modules/myscreens/controllers/myscreens_controller.dart';
import 'package:vloo/app/modules/myscreens/views/orientationOfScreen.dart';

class OrientationDialog extends GetView<MyscreensController> {
  final ScreenModel? selectedScreenModel;
  const OrientationDialog({super.key, required this.selectedScreenModel,});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 200.h, horizontal: 20.w),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 25.h),
            decoration: BoxDecoration(
              color: AppColor.primaryColor.withOpacity(0.5),
              border: Border.all(width: 1, color: AppColor.appLightBlue),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(children: [
              SvgPicture.asset(StaticAssets.icEmogiLaugh),
              SizedBox(
                height: 15.h,
              ),
              const Text(
                'To change the orientation of your screen, please delete all content to broadcast on the screen.',
                style: TextStyle(
                    decoration: TextDecoration.none,
                    color: AppColor.appLightBlue,
                    fontSize: 16,
                    fontFamily: 'Poppins'),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 15.h,
              ),
              GestureDetector(
                onTap: ()  {
                  Get.back();         // For closing the dialog
                   Get.to( OrientationScreenView(selectedScreenModel: selectedScreenModel,));
                },
                child: const Text(
                  'Got it !',
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      color: AppColor.appSkyBlue,
                      fontSize: 16,
                      fontFamily: 'Poppins'),
                  textAlign: TextAlign.center,
                ),
              )
            ]),
          ),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                height: 40.w,
                width: 40.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColor.appIconBackgound,
                ),
                child: const Icon(
                  Icons.close,
                  color: AppColor.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
