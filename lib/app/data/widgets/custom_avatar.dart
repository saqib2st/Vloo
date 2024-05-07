import 'package:flutter/material.dart';
import 'package:vloo/app/data/configs/app_theme.dart';

class CustomAvatar extends StatelessWidget {
  final double? radius;
  final Color? borderColor, backgoundColor;
  final bool isborder;
  final Widget? child;
  const CustomAvatar(
      {super.key,
      this.radius,
      this.borderColor,
      this.isborder = true,
      this.child,
      this.backgoundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (radius ?? 23) * 2,
      width: (radius ?? 23) * 2,
      decoration: BoxDecoration(
        color: backgoundColor ?? Colors.white,
        shape: BoxShape.circle,
        border: isborder
            ? Border.all(
                width: 2,
                color: borderColor ?? AppColor.primaryColor,
              )
            : null,
      ),
      child: child,
    );
  }
}
