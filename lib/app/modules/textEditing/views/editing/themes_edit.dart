import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/widgets/custom_current_currency.dart';
import 'package:vloo/app/modules/textEditing/controllers/title_editing_controller.dart';

class ThemesEdit extends GetView<TitleEditingController> {
  const ThemesEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Builder(builder: (context) {
        return Obx(() => Padding(
              padding: EdgeInsets.fromLTRB(17.h, 0, 17.h, 10.h),
              child: Wrap(
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.center,
                runSpacing: 10,
                spacing: 10,
                children: [
                  ...controller.stickerList.asMap().entries.map((e) =>
                      GestureDetector(
                        onTap: () {
                          controller.selectedPriceTheme.value = e.value;
                          print(controller.selectedPriceTheme.value);
                        },
                        child: e.key == 0
                            ? Container(
                                height: 100.h,
                                width: 180.w,
                                padding: const EdgeInsets.all(20.0),
                                decoration: BoxDecoration(
                                  color: controller.selectedPriceTheme.value ==
                                          e.value
                                      ? AppColor.appSkyBlue
                                      : AppColor.appIconBackgound,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      controller.stickerList[e.key],
                                      width: 33,
                                      height: 33,
                                      color:
                                          controller.selectedPriceTheme.value ==
                                                  e.value
                                              ? AppColor.appIconBackgound
                                              : AppColor.appLightBlue,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Text(
                                        Strings.priceWithLabel,
                                        maxLines: 2,
                                        softWrap: true,
                                        style: CustomTextStyle.font14R.copyWith(
                                            color: controller.selectedPriceTheme
                                                        .value ==
                                                    e.value
                                                ? AppColor.appIconBackgound
                                                : AppColor.appLightBlue),
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                height: 100.h,
                                width: 180.w,
                                padding: const EdgeInsets.all(20.0),
                                decoration: BoxDecoration(
                                  color: controller.selectedPriceTheme.value ==
                                          e.value
                                      ? AppColor.appSkyBlue
                                      : AppColor.appIconBackgound,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Image.asset(
                                  controller.stickerList[e.key],
                                  fit: BoxFit.contain,
                                ),
                              ),
                      )),
                ],
              ),
            ));
      }),
    );
  }
}
