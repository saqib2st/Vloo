import 'package:flutter/material.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';

enum ButtonVariant {
  filled,
  bordered,
}

class CustomButton extends StatelessWidget {

  const CustomButton({
    Key? key,
    required this.buttonName,
    this.height,
    this.width,
    this.type,
    this.onPressed,
    this.color,
    this.borderRadius,
    this.textColor,
    this.isbold = false,
    this.elevation = 0,
    this.textSize,
    this.backgroundColor,
    this.borderColor,
  })  : isFilled = type == ButtonVariant.filled,
        super(key: key);

  final ButtonVariant? type;
  // final double? textSize;
  final VoidCallback? onPressed;
  final Color? color, textColor, backgroundColor, borderColor;
  final String buttonName;
  final double elevation;
  final double? height, width, borderRadius;
  final bool isFilled, isbold;
  final double? textSize;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height ?? 40.w,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
            color: isFilled
                ? color ?? AppColor.secondaryColor
                : backgroundColor ?? AppColor.primaryColor,
            borderRadius: BorderRadius.circular(borderRadius ?? 25.sp),
            border: Border.all(
              width: isFilled ? 0 : 1,
              color: borderColor ?? AppColor.secondaryColor,
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  spreadRadius: (1 * elevation),
                  blurRadius: (3 * elevation))
            ]),
        child: Center(
          child: Text(
            buttonName,
            textAlign: TextAlign.center,
            style: CustomTextStyle.font16R.copyWith(
              fontWeight: isbold ? FontWeight.bold : FontWeight.w500, fontSize: textSize,
              color: isFilled
                  ? textColor ?? AppColor.secondaryColor
                  : color ?? AppColor.primaryColor,
              // fontSize: isFilled ? textSize : 16
            ),
          ),
        ),
      ),
    );
  }
}
