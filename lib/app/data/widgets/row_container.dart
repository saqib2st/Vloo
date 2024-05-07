import 'package:flutter/material.dart';
import 'package:vloo/app/data/configs/app_theme.dart';

class RowContainer extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? color;
  final double? height, width;
  final List<Widget> widgetList;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  const RowContainer(
      {super.key,
      this.color,
      required this.widgetList,
      this.height,
      this.width,
      this.borderRadius,
      this.onPressed,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        padding:
            padding ?? const EdgeInsets.symmetric(vertical: 6, horizontal: 9),
        decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(7),
            color: color ?? AppColor.hintTextColor),
        child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: widgetList),
      ),
    );
  }
}
