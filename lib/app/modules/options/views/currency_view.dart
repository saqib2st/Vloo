import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/widgets/primary_appbar.dart';
import 'package:vloo/app/modules/templates/controllers/templates_controller.dart';
import 'package:vloo/app/modules/textEditing/controllers/title_editing_controller.dart';

class CurrencyView extends GetView<TitleEditingController> {
  const CurrencyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: PrimaryAppbar(
        title: Strings.currencyCaps,
        onPressed: () {
          Get.back();
        },
      ),
      body: SingleChildScrollView(
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.only(
                      left: Get.width * 0.04,
                      top: Get.width * 0.1,
                      bottom: Get.width * 0.02,
                    ),
                    child: Text(Strings.currencyFormat,
                        style: CustomTextStyle.font16R
                            .copyWith(fontWeight: FontWeight.bold,
                                      fontSize: 20.sp
                        ))),
                 Divider(color: AppColor.appIconBackgound, thickness: 1,
                  height: 8.h,
                ),
                ...List.generate(controller.currencyFormatList.length, (index) {
                  return InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      if (index == 0) {
                        controller.selectedCurrencyFormat.value =
                            Strings.symbolInStart;
                      } else if (index == 1) {
                        controller.selectedCurrencyFormat.value =
                            Strings.symbolInMiddle;
                      } else if (index == 2) {
                        controller.selectedCurrencyFormat.value =
                            Strings.symbolInEnd;
                      }
                      controller.selectedCurrencyFormat.value =
                          controller.currencyFormatList[index].values.first;
                      for(int templateIndex = 0;templateIndex< (Get.find<TemplatesController>().singleItemList.length);templateIndex++) {
                        var element =Get.find<TemplatesController>().singleItemList[templateIndex];
                        if (element.value != null && element.type == 'Price') {
                          var singleItemList = Get.find<TemplatesController>().singleItemList;
                          String symbol=controller.extractCurrencySymbol(element.value.toString());
                          element.value = controller.setSymbolFormat(element.valueLocal ?? '', controller.selectedCurrencyFormat.value,symbol,element.currencyFormat==Strings.symbolInMiddle);
                          element.valueLocal = element.value;
                          singleItemList[templateIndex] = singleItemList[templateIndex].copyWith(
                            value: element.value,
                            valueLocal: element.value,
                            currencyFormat: controller.selectedCurrencyFormat.value,
                            currencySymbol: symbol
                          );
                        }

                      }
                      Get.forceAppUpdate();
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.04),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.currencyFormatList[index].keys
                                            .first,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.sp,
                                        color: AppColor.appLightBlue),
                                  ),
                                  Text(
                                      controller.currencyFormatList[index]
                                              .values.first,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: AppColor.appLightBlue)),
                                ],
                              ),
                              const Spacer(),
                              Icon(Icons.check,
                                  size: 40.h,
                                  color:
                                      controller.selectedCurrencyFormat.value ==
                                              controller
                                                  .currencyFormatList[index]
                                                  .values
                                                  .first
                                          ? AppColor.appLightBlue
                                          : AppColor.transparent)
                            ],
                          ),
                        ),
                         Divider(
                          color: AppColor.appIconBackgound,
                          thickness: 1,
                          height: 14.h,
                        ),
                      ],
                    ),
                  );
                }),
                Padding(
                    padding: EdgeInsets.only(
                        left: Get.width * 0.04,
                        top: Get.width * 0.08,
                        bottom: Get.width * 0.03),
                    child: Text(Strings.currentCurrency,
                        style: CustomTextStyle.font16R
                            .copyWith(fontWeight: FontWeight.bold,
                          fontSize: 20.sp,))),
                Divider(color: AppColor.appIconBackgound, thickness: 1,
                  height: 8.h,
                ),
                ...List.generate(controller.currencyChoiceList.length, (index) {
                  return InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      controller.setCountryCurrency(index);
                      for(int templateIndex = 0;templateIndex< (Get.find<TemplatesController>().singleItemList.length);templateIndex++) {
                        // Check if the value is not null before replacing
                        var element =Get.find<TemplatesController>().singleItemList[templateIndex];
                        if (element.value != null && element.type == 'Price') {
                            var symbol=controller.extractCurrencySymbol(element.value.toString());
                            String currency = "";

                            var singleItemList = Get.find<TemplatesController>().singleItemList;
                          // Replace '$' with '@' and assign the new value back to element.value
                            element.value = element.value!.replaceAll(symbol, controller.currencyChoiceList[index].currencySymbol.toString());
                            // style = element. ?? TextStyle();
                            currency = element.value?.replaceAll(RegExp(r"[0-9]+"), '') ?? '';
                            currency = currency.contains('.') ? currency.replaceAll('.', '') : currency;

                            singleItemList[templateIndex] = singleItemList[templateIndex].copyWith(value: element.value,
                            currency: currency,
                          valueLocal: element.value,
                            );
                        }

                      }
                      Get.forceAppUpdate();
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.04,
                              vertical: 0),
                          child: Row(
                            children: [
                              Text(controller.getCountryFlag(controller.currencyChoiceList[index].countryCode!),style: TextStyle(
                                fontSize: 30.sp
                              ),),
                              SizedBox(width: 4.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${controller.currencyChoiceList[index].countryName} (${controller.currencyChoiceList[index].currencySymbol})',
                                      style: CustomTextStyle.font16R
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.check,
                                size: 40.h,
                                color: controller.currencyChoiceList[index]
                                            .isSelectedCurrency?.value ??
                                        false
                                    ? AppColor.appLightBlue
                                    : AppColor.transparent,
                              )
                            ],
                          ),
                        ),
                        Divider(
                          color: AppColor.appIconBackgound,
                          thickness: 1,
                          height: 8.h,
                        ),
                      ],
                    ),
                  );
                }),
              ],
            )),
      ),
    );
  }
}
