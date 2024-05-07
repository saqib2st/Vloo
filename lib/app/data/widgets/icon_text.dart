import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';

class IconText extends StatelessWidget {
  final String iconPath;
  final String text;
  final double? height;

  const IconText(
      {Key? key, required this.iconPath, required this.text, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          iconPath,
          height: height ?? 15.h,
          placeholderBuilder: (BuildContext context) => Container(
              padding: const EdgeInsets.all(30.0),
              child: const CircularProgressIndicator()),
        ),
        SizedBox(width: 8.w),
        Text(
          text,
          style: CustomTextStyle.font16R.copyWith(color: AppColor.appLightBlue),
        ),
      ],
    );
  }
}
