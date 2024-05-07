import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/widgets/custom_buttons.dart';
import 'package:vloo/app/data/widgets/custom_rich_text.dart';
import 'package:vloo/app/modules/addScreen/controllers/add_screen_controller.dart';
import 'package:vloo/app/routes/app_pages.dart';

class TransferView extends GetView<AddScreenController> {
  const TransferView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 60.w),
        margin: EdgeInsets.only(top: 150.w),
        child:Column(
          children: [
            Column(
              children: [
                SvgPicture.asset(
                  StaticAssets.vlooLogo,
                  height: 50.h,
                  width: 150.w,
                  placeholderBuilder: (BuildContext context) => Container(
                      padding: const EdgeInsets.all(30.0),
                      child: const CircularProgressIndicator()),
                ),
                SizedBox(height: 40.h),

                Text(Strings.transferring, textAlign: TextAlign.center, style: CustomTextStyle.font22R.copyWith(color: AppColor.appSkyBlue , fontWeight: FontWeight.bold)),
                SizedBox(height: 20.h),

                Text(Strings.preparingTransferYourProjectToYourNewScreen, textAlign: TextAlign.center, style: CustomTextStyle.font16R),
                SizedBox(height: 90.h),
                SizedBox(
                  height: 150.h,
                  width: 150.w,
                  child: Image.asset(StaticAssets.happyGif),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 60.w),
                  child: Text(Strings.pleaseWaitTransferTVScreenMayTakeMinutes, textAlign: TextAlign.center, style: CustomTextStyle.font16R.copyWith(color: AppColor.disableColor)),
                ),
              ],
            ),


          ],
        )
      ),
    );
  }
}
