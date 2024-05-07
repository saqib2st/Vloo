
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/models/template/template_single_item_model.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/modules/layers/views/widgets/layer_list_item_view.dart';

import '../controllers/layers_controller.dart';

class TemplateLayersView extends StatefulWidget {
  const TemplateLayersView({super.key});

  @override
  State<TemplateLayersView> createState() => _TemplateLayersViewState();
}

class _TemplateLayersViewState extends State<TemplateLayersView> {
  late List<TemplateSingleItemModel> itemsListData;
  @override
  void initState() {
    itemsListData = Get.find<LayersController>().itemsListData ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, Get.height*0.1),
        child: GestureDetector(
          onTap: (){
            Get.back();
            Get.forceAppUpdate();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: Stack(
          children: [
            Obx(
              () => Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                margin: const EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: AppColor.primaryDarkColor,
                    border: const Border(
                      top: BorderSide(
                          width: 2.5, color: AppColor.appSkyBlue), // Top border
                      right: BorderSide(
                          width: 0.5, color: AppColor.appSkyBlue), // No border on the right
                      left: BorderSide(
                          width: 0.5, color: AppColor.appSkyBlue), // No border on the left
                      bottom: BorderSide.none, // No border on the bottom
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.sp),
                      topRight: Radius.circular(20.sp),
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.dragDropToSort,
                      style: CustomTextStyle.font16R.copyWith(
                          color: AppColor.appLightBlue,
                          fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    (itemsListData.isNotEmpty)
                        ? Expanded(
                            child: ReorderableListView(
                              onReorder: ((oldIndex, newIndex) {
                                if (oldIndex < newIndex) {
                                  newIndex -= 1;
                                }
                                final TemplateSingleItemModel item =
                                    itemsListData.removeAt(oldIndex);

                                itemsListData.insert(newIndex, item);
                              }),
                              proxyDecorator: (child, index, animation) {
                                return Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  color: Colors.transparent,
                                  child: LayerListItemView(
                                    isSelected: true,
                                    heading: itemsListData[index].type,
                                    value: itemsListData[index].valueLocal,
                                    iconPath: Get.find<LayersController>()
                                        .getIconsPath(
                                            itemsListData[index].type ??
                                                Strings.title),
                                  ),
                                );
                              },
                              children: itemsListData
                                  .asMap()
                                  .entries
                                  .map(
                                    (e) => Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      color: Colors.transparent,
                                      key: ValueKey(e.key),
                                      child: LayerListItemView(
                                        
                                        heading: e.value.type,
                                        value: e.value.valueLocal,
                                        iconPath: Get.find<LayersController>()
                                            .getIconsPath(
                                                e.value.type ?? Strings.title),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          )
                        : Expanded(
                            child: Text(
                              Strings.notTemplateYet,
                              style: CustomTextStyle.font12R,
                            ),
                          ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Get.back();
                Get.forceAppUpdate();
              },
              child: Align(
                alignment: Alignment.topCenter,
                child: SvgPicture.asset(
                  StaticAssets.downButton,
                  height: 40.w,
                  width: 40.w,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
