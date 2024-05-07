import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';

class CustomRowIcon extends StatelessWidget {
  final String text;
  final String logoAsset;

  const CustomRowIcon({Key? key, required this.text, required this.logoAsset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          logoAsset,
          width: 20.w,
          height: 20.h,
          placeholderBuilder: (BuildContext context) => Container(
              padding: const EdgeInsets.all(30.0),
              child: const CircularProgressIndicator()),
          fit: BoxFit.fill,
        ),
        SizedBox(
          width: 5.w,
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 11.sp,
              fontFamily: 'Poppins',
              color: AppColor.appLightBlue),
        ),
      ],
    );
  }
}
