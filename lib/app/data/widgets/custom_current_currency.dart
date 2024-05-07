import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';

class CustomCurrency extends StatelessWidget {
  final String? currency;
  final String? country;
  final String? flag;
  final Alignment? alignment;
  final bool? isCheckVisible;
  final bool? selectedCurrencyChoice;


  const CustomCurrency({super.key, this.currency, this.isCheckVisible, this.alignment, this.country, this.flag , this.selectedCurrencyChoice});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment ?? Alignment.centerLeft,
      child: (isCheckVisible == true)
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04, vertical: Get.height * 0.01),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currency ?? "",
                              style: const TextStyle(
                                color: AppColor.appLightBlue,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.check,
                        color: AppColor.appLightBlue,
                      )
                    ],
                  ),
                ),
                const Divider(
                  color: AppColor.appIconBackgound,
                  thickness: 1,
                ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  flag ?? "",
                  style: CustomTextStyle.font22R,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  width: 5.h,
                ),
                Text(
                  country ?? "",
                  style:  selectedCurrencyChoice==true
                      ?   CustomTextStyle.font16R.copyWith(color: AppColor.primaryColor)  // Active border color
                      :   CustomTextStyle.font16R,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  width: 2.h,
                ),
                if(currency != null && currency!.isNotEmpty)
                Text(
                  '($currency)',
                  style: selectedCurrencyChoice==true
                      ?   CustomTextStyle.font14R.copyWith(color: AppColor.primaryColor)  // Active border color
                      :   CustomTextStyle.font14R,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
    );
  }
}
