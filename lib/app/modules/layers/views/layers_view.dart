import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/widgets/custom_row_template.dart';
import 'package:vloo/app/data/widgets/primary_appbar.dart';
import 'package:vloo/app/modules/layers/views/widgets/layer_list_item_view.dart';

import '../controllers/layers_controller.dart';

class ElementLayersView extends GetView<LayersController> {
  const ElementLayersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 120.0),
        child: Stack(
          children: [
            Obx(
              () => Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                margin: const EdgeInsets.only(top: 20),
                decoration: const ShapeDecoration(
                  color: AppColor.primaryDarkColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    side: BorderSide(
                      color: AppColor.appSkyBlue,
                      width: 1,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.selectLayerToEdit,
                      style: CustomTextStyle.font16R.copyWith(color: AppColor.appLightBlue, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       /* SizedBox(
                          width: 100.w,
                          child: TextButton(
                            onPressed: () {
                              //controller.buttonIndex?.value = 1;
                            },
                            *//*style: TextButton.styleFrom(
                              backgroundColor: controller.buttonIndex?.value == 1 ? AppColor.secondaryColor : AppColor.appIconBackgound, // Background color
                              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10), // Button border radius
                              ),
                            ),*//*
                            child: Text(
                              textAlign: TextAlign.center,
                              Strings.allTheElements,
                              style: CustomTextStyle.font12R.copyWith(color: controller.buttonIndex?.value == 1 ? AppColor.primaryDarkColor : AppColor.appLightBlue, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),*/
                        SizedBox(width: 10.w),
                        /*GestureDetector(
                          onTap: () {
                           // controller.buttonIndex?.value = 2;
                          },
                          child: CustomRowTemplate(
                            text: "",
                            logoAsset: controller.buttonIndex?.value == 2 ? StaticAssets.selectedImageIcon : StaticAssets.imageIcon,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.buttonIndex?.value = 3;
                          },
                          child: CustomRowTemplate(
                            text: "",
                            logoAsset: controller.buttonIndex?.value == 3 ? StaticAssets.selectedTitleIcon : StaticAssets.titleIcon,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.buttonIndex?.value = 4;
                          },
                          child: CustomRowTemplate(
                            text: "",
                            logoAsset: controller.buttonIndex?.value == 4 ? StaticAssets.selectedDescriptionIcon : StaticAssets.descriptionIcon,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.buttonIndex?.value = 5;
                          },
                          child: CustomRowTemplate(
                            text: "",
                            logoAsset: controller.buttonIndex?.value == 5 ? StaticAssets.selectedPriceIcon : StaticAssets.priceIcon,
                          ),
                        ),*/
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                   /* (controller.itemsListData != null && controller.getListCount() > 0)
                        ? Expanded(
                            child: ListView.builder(
                              itemCount: controller.itemsListData!.length,
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    if (controller.buttonIndex?.value == 1 || controller.buttonIndex?.value == 3) ...[
                                      GestureDetector(
                                        onTap: () {
                                          controller.goToTitleEditingScreen(controller.itemsListData![index].title ?? "");
                                        },
                                        child: LayerListItemView(
                                          heading: Strings.title,
                                          value: controller.itemsListData![index].title ?? "",
                                          iconPath: StaticAssets.titleIcon,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                    ],
                                    if (controller.buttonIndex?.value == 1 || controller.buttonIndex?.value == 2) ...[
                                      GestureDetector(
                                        onTap: () {
                                         // controller.goToTitleEditingScreen(controller.itemData![index].title ?? "");
                                        },
                                        child: LayerListItemView(
                                          heading: Strings.element,
                                          value: controller.itemsListData![index].title ?? "",
                                          iconPath: StaticAssets.noImageIcon,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                    ],
                                    if (controller.buttonIndex?.value == 1 || controller.buttonIndex?.value == 4) ...[
                                      GestureDetector(
                                        onTap: () {
                                          controller.goToTitleEditingScreen(controller.itemsListData![index].description ?? "");
                                        },
                                        child: LayerListItemView(
                                          heading: Strings.description,
                                          value: controller.itemsListData![index].description ?? "",
                                          iconPath: StaticAssets.descriptionIcon,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                    ],
                                    if (controller.buttonIndex?.value == 1 || controller.buttonIndex?.value == 5) ...[
                                      GestureDetector(
                                        onTap: () {
                                          controller.toPriceElementView(controller.itemsListData![index].prize ?? "");
                                        },
                                        child: LayerListItemView(
                                          heading: Strings.price,
                                          value: controller.itemsListData![index].prize ?? "",
                                          iconPath: StaticAssets.priceIcon,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                    ],
                                  ],
                                );
                              },
                            ),
                          )
                        : const Expanded(
                            child: Text(Strings.notTemplateYet),
                          ),*/
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: SvgPicture.asset(
                StaticAssets.downButton,
                height: 40.w,
                width: 40.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
