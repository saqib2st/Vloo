import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/widgets/custom_current_currency.dart';
import 'package:vloo/app/modules/textEditing/controllers/title_editing_controller.dart';

class CurrencyChoiceWidget extends GetView<TitleEditingController> {
  const CurrencyChoiceWidget({super.key});

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
          ...controller.currencyChoiceList.asMap().entries.map(
                (e) => GestureDetector(
                    onTap: () {
                      controller.setCountryCurrency(e.key);
                      controller.priceElementText();
                    },
                    child: Obx(
                      () => Container(
                        height: 100.h,
                        width: 180.w,
                        decoration: BoxDecoration(
                          color: e.value.isSelectedCurrency?.value ?? false
                              ? AppColor.appSkyBlue // Active background color
                              : AppColor.appIconBackgound,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: CustomCurrency(
                            alignment: Alignment.center,
                            flag: controller
                                .getCountryFlag(e.value.countryCode ?? ""),
                            country: e.value.countryName ?? "",
                            currency: e.value.currencySymbol ?? "",
                            isCheckVisible: false,
                            selectedCurrencyChoice: e.value.isSelectedCurrency?.value),
                      ),
                    )),
              ),
        ],
      ),
    );
  }
}
