import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/modules/textEditing/controllers/title_editing_controller.dart';

class CurrencyFormatWidget extends GetView<TitleEditingController> {
  const CurrencyFormatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(17.h, 0, 17.h, 10.h),
      child: Wrap(
        alignment: WrapAlignment.start,
        runAlignment: WrapAlignment.center,
        runSpacing: 10,
        spacing: 10,
        children: [
          ...controller.currencyFormatList.asMap().entries.map(
                (e) => GestureDetector(
                    onTap: () {
                      if (e.key == 0) {
                        controller.selectedCurrencyFormat.value = Strings.symbolInStart;
                      } else if (e.key == 1) {
                        controller.selectedCurrencyFormat.value = Strings.symbolInMiddle;
                      } else if (e.key == 2) {
                        controller.selectedCurrencyFormat.value = Strings.symbolInEnd;
                      }
                      controller.selectedCurrencyFormat.value = e.value.entries.first.value;
                      controller.priceElementText();
                    },
                    child: Obx(
                      () => Container(
                        height: 100.h,
                        width: 180.w,
                        decoration: BoxDecoration(
                          color: controller.selectedCurrencyFormat.value == e.value.entries.first.value
                              ? AppColor.appSkyBlue // Active border color
                              : AppColor.appIconBackgound,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Align(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  e.value.entries.first.key.replaceAll('\$', controller.selectedCurrencyChoice!.value.currencySymbol ?? '\$'),
                                  style: controller.selectedCurrencyFormat.value == e.value.entries.first.value
                                      ? CustomTextStyle.font18R.copyWith(color: AppColor.primaryColor) // Active border color
                                      : CustomTextStyle.font18R,
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  e.value.entries.first.value,
                                  style: controller.selectedCurrencyFormat.value == e.value.entries.first.value
                                      ? CustomTextStyle.font12R.copyWith(color: AppColor.primaryColor) // Active border color
                                      : CustomTextStyle.font12R,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            )),
                      ),
                    )),
              )
        ],
      ),
    );
  }
}
