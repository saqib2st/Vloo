import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/utils/static_assets.dart';

class SecondaryAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool? isEyeEnabled;
  final bool? isUndoEnabled;
  final bool? isRedoEnabled;
  final bool? isBroadcastEnabled;
  final bool? isVisible;
  final String? broadcastButtonText;
  final Function() onBroadcastPressed;
  final Function() onUndoPressed;
  final Function() onRedoPressed;
  final Function() onEyePressed;
  final Function() onBackPressed;

  @override
  Size get preferredSize => Size.fromHeight(70.h);

  const SecondaryAppbar({
    super.key,
    this.broadcastButtonText,
    this.isEyeEnabled,
    this.isUndoEnabled,
    this.isRedoEnabled,
    this.isVisible,
    this.isBroadcastEnabled,
    required this.onBroadcastPressed,
    required this.onUndoPressed,
    required this.onRedoPressed,
    required this.onEyePressed,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible ?? true,
      child: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColor.primaryColor,
        elevation: 0,
        toolbarHeight: preferredSize.height,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: onBackPressed,
              child: SvgPicture.asset(
                StaticAssets.backButton,
              ),
            ),
            GestureDetector(
              onTap: isUndoEnabled != null && isUndoEnabled!
                  ? onUndoPressed
                  : null,
              child: SvgPicture.asset(
                isUndoEnabled != null && isUndoEnabled!
                    ? StaticAssets.undoIcon
                    : StaticAssets.undoIconDisabled,
              ),
            ),
            GestureDetector(
              onTap: isRedoEnabled != null && isRedoEnabled!
                  ? onRedoPressed
                  : null,
              child: SvgPicture.asset(
                isRedoEnabled != null && isRedoEnabled!
                    ? StaticAssets.redoIcon
                    : StaticAssets.redoIconDisabled,
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            GestureDetector(
              onTap: /*isEyeEnabled != null && isEyeEnabled! ?*/
                  onEyePressed /*: null*/, // Code commented on client demand
              child: GestureDetector(
                onTap: onEyePressed,
                child: SvgPicture.asset(
                  /*isEyeEnabled != null && isEyeEnabled! ?*/ StaticAssets
                      .eyeIcon /*: StaticAssets.eyeIconDisabled*/, // Code commented on client demand
                ),
              ),
            ),
            GestureDetector(
              onTap: onBroadcastPressed,
              child: Container(
                height: MediaQuery.of(context).size.width >= 600 &&
                        MediaQuery.of(context).orientation ==
                            Orientation.landscape
                    ? 50.h
                    : 33.h,
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 0.5.w,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: AppColor.appLightBlue,
                    ),
                    borderRadius: BorderRadius.circular(20.h),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      broadcastButtonText ?? 'Broadcast',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColor.appLightBlue,
                        fontSize: 12.5.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // )
          ],
        ),
      ),
    );
  }
}
