import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';

class CustomTextWithIcon extends StatelessWidget {
  final String text;
  final String? logoAsset;
  final double? imageSize;
  final double? textSize;
  final Color? textColor;
  final FontWeight? fontWeight;

  const CustomTextWithIcon({Key? key, required this.text, this.logoAsset, this.imageSize, this.textSize, this.textColor, this.fontWeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Row(
        children: [
          if (logoAsset != null && logoAsset!.isNotEmpty) ...[
            SvgPicture.asset(
              logoAsset!,
              width: imageSize ?? 20.w,
              height: imageSize ?? 20.h,
              fit: BoxFit.fill,
              placeholderBuilder: (BuildContext context) => Container(
                  padding: const EdgeInsets.all(30.0),
                  child: const CircularProgressIndicator()),
            ),
            SizedBox(
              width: 10.w,
            ),
          ] else
            Container(),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: fontWeight ?? FontWeight.w500, fontSize: textSize ?? 11.sp, fontFamily: 'Poppins', color: textColor ?? AppColor.appLightBlue),
          ),
        ],
      ),
    );
  }
}
