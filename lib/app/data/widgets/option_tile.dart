import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/text.dart';

class OptionTile extends StatelessWidget {
  final String? titleText;
  final String? title;
  final String? arrowText;
  final String? myIcon;
  final IconData? arrowRight;
  final TextStyle textStyle;
  final VoidCallback? onPressed;

  const OptionTile({super.key, this.titleText, this.title, this.myIcon, this.arrowRight, this.onPressed, required this.textStyle, this.arrowText});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (myIcon != null && myIcon != '') SvgPicture.asset(myIcon ?? ''),
            (myIcon == null || myIcon == '')  ? const SizedBox(width: 0) : SizedBox(width: Get.width * 0.02),
            Text(titleText ?? '', style: CustomTextStyle.font16R.copyWith(fontWeight: FontWeight.bold)),
            Expanded(
                child: Text(
              title!,
              style: textStyle,
            )),
            Row(
              children: [
                Text(arrowText ?? '', style: CustomTextStyle.font12R.copyWith(fontWeight: FontWeight.bold)),
                Icon(
                  arrowRight,
                  color: AppColor.appLightBlue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
