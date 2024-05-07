import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';

class CustomIcon extends StatelessWidget {
  final String text;
  final Color? textColor;
  final String logoAsset;

  const CustomIcon({Key? key, required this.text, required this.logoAsset, this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          SvgPicture.asset(
            logoAsset,
            width: 40.w,
            height: 40.h,
            fit: BoxFit.fill,
            placeholderBuilder: (BuildContext context) => Container(
                padding:  EdgeInsets.all(30.0.h),
                child: const CircularProgressIndicator()),
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize:Get.mediaQuery.orientation == Orientation.landscape? 8.sp: 11.sp,
                fontFamily: 'Poppins',
                color: textColor?? AppColor.appLightBlue),
          ),
        ],
      ),
    );
  }
}
