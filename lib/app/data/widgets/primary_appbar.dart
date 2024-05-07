import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/utils/static_assets.dart';

class PrimaryAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function() onPressed;
  final Function()? onPressed2;
  final String? text;

  const PrimaryAppbar({
    super.key,
    required this.title,
    required this.onPressed,
    this.text,
    this.onPressed2,
  });

  @override
  Size get preferredSize => Size.fromHeight(70.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      surfaceTintColor: Colors.transparent,
      toolbarHeight: preferredSize.height,
      leadingWidth: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            child: GestureDetector(
              onTap: onPressed,
              child: SvgPicture.asset(
                StaticAssets.backButton,
              ),
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: AppColor.appLightBlue,
              fontWeight: FontWeight.w400,
              fontSize: 20.sp,
            ),
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
          GestureDetector(
            onTap: onPressed2,
            child: Center(
                child: Text(
                  text ?? "",
                  style: TextStyle(
                      color: AppColor.appLightBlue,
                      fontWeight: FontWeight.w300,
                      fontSize:20.sp),
                )),
          )
        ],
      ),
      backgroundColor: AppColor.primaryColor,
      elevation: 0,

    );
  }
}
