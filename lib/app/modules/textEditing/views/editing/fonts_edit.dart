import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/widgets/sub_tabs_fonts_box.dart';
import 'package:vloo/app/modules/textEditing/controllers/title_editing_controller.dart';
import 'package:vloo/main.dart';

// ignore: must_be_immutable
class FontsEdit extends GetView<TitleEditingController> {
  bool isActive = false;

  FontsEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: controller.iconsList
                .asMap()
                .entries
                .map(
                  (e) => Opacity(
                    opacity: controller.animatedTextWidgetModel.value.selectedEffect == StaticAssets.noneIcon && controller.animatedTextWidgetModel.value.textTransitionModel?.text == 'None'
                        ? 1: 0.4 ,
                    child: IconButton(
                        constraints: const BoxConstraints(minHeight: 60, minWidth: 50),
                        onPressed: () {
                          if(controller.animatedTextWidgetModel.value.selectedEffect == StaticAssets.noneIcon && controller.animatedTextWidgetModel.value.textTransitionModel?.text == 'None'){
                            controller.animatedTextWidgetModel.value.selectedTextAlignment = e.key;
                            Get.forceAppUpdate();
                          }else{
                            // scaffoldKey.currentState?.showSnackBar(const SnackBar(content: Text(Strings.animationsAreSelected)));
                          }
                        },
                        icon: Column(
                          children: [
                            Icon(
                              e.value['icon'],
                              color: controller.animatedTextWidgetModel.value.selectedTextAlignment == e.key ? AppColor.appSkyBlue : AppColor.hintTextColor,
                            ),
                            Text(
                              e.value['text'],
                              style: TextStyle(
                                fontSize: Get.mediaQuery.orientation == Orientation.landscape? 7.sp:10.sp,
                                color: controller.animatedTextWidgetModel.value.selectedTextAlignment == e.key ? AppColor.appSkyBlue : AppColor.hintTextColor,
                              ),
                            )
                          ],
                        )),
                  ),
                )
                .toList(),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Divider(
            color: AppColor.appIconBackgound,
            thickness: 0.8,
          ),
        ),
        const Expanded(child: SingleChildScrollView(child: SubTabsFontsBoxWidget()))
      ],
    );
  }
}
