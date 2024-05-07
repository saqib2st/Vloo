import 'package:flutter/material.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';

class CustomTabColumn extends StatelessWidget {
  final Widget icon;
  final String text;

  const CustomTabColumn({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          SizedBox(width: 5, height: 5.0.h),
          Text(text,
              style: CustomTextStyle.font11R.copyWith(color: AppColor.white)),
        ],
      ),
    );
  }
}
