import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/utils/Responsive.dart';
import 'package:vloo/app/modules/myscreens/controllers/myscreens_controller.dart';

class ConfirmationAlertDialog extends GetView<MyscreensController> {
  final String? description;
  final String positiveText;
  final String negativeText;
  final Color? negativeColor;
  final Function() onPressedPositive;
  final Function() onPressedNegative;
  const ConfirmationAlertDialog(
      {super.key,
      this.description,
      required this.positiveText,
      required this.negativeText,
      required this.onPressedPositive,
        this.negativeColor,
      required this.onPressedNegative});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
        margin: const EdgeInsets.only(left: 0.0, right: 0.0),
        child: Stack(
          alignment: Alignment.topRight,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: constraints.maxHeight * 0.4,
              margin: const EdgeInsets.only(top: 12.0, right: 8.0),
              decoration: BoxDecoration(
                color: AppColor.primaryColor.withOpacity(0.5),
                border: Border.all(width: 1, color: AppColor.appLightBlue),
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    description ?? 'Are you sure you want delete this screen?',
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: AppColor.appLightBlue,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: onPressedNegative,
                        child: Text(
                          negativeText,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              color: AppColor.appLightBlue,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Poppins'),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(width: 50.w),
                      GestureDetector(
                        onTap: onPressedPositive,
                        child: Text(
                          positiveText,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              color:negativeColor?? AppColor.red,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Poppins'),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0.sp), //or 15.0
                child: Responsive(
                  tablet: Container(
                    height: 40.0.h,
                    width: 30.0.w,
                    color: AppColor.appIconBackgound,
                    child:
                        const Icon(Icons.close, color: AppColor.appLightBlue),
                  ),
                  mobile: Container(
                    height: 45.0.h,
                    width: 45.0.w,
                    color: AppColor.appIconBackgound,
                    child:
                        const Icon(Icons.close, color: AppColor.appLightBlue,),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
