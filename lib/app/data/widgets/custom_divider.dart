import 'package:flutter/material.dart';

import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';

class CustomDivider extends StatelessWidget {
  final double? thickness, padding;
  const CustomDivider({super.key, this.thickness, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: padding ?? 8),
      height: thickness ?? 5.w,
      decoration: BoxDecoration(
          color: AppColor.appLightBlue,
          borderRadius: BorderRadius.circular(25)),
    );
  }
}
