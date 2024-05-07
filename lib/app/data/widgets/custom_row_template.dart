import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';

class CustomRowTemplate extends StatelessWidget {
  final String text;
  final String logoAsset;

  const CustomRowTemplate(
      {Key? key, required this.text, required this.logoAsset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Row(
        children: [
          SvgPicture.asset(
            logoAsset,
            fit: BoxFit.fitWidth,
            height: 50.h,
            width: 50.h,
            placeholderBuilder: (BuildContext context) => Container(
                padding: const EdgeInsets.all(30.0),
                child: const CircularProgressIndicator()),
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(
            text,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: AppColor.appLightBlue),
          ),
        ],
      ),
    );
  }
}
