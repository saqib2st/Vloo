import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/widgets/cutom_tabs.dart';
import 'package:vloo/app/data/widgets/sub_tabs_animations_box.dart';
import 'package:vloo/app/data/widgets/sub_tabs_effect_box.dart';
import 'package:vloo/app/modules/textEditing/controllers/title_editing_controller.dart';

class AnimationEdit extends GetView<TitleEditingController> {
  const AnimationEdit({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: AppColor.primaryDarkColor,
          child: Column(
            children: [
              Obx(
                () => TabBar(
                  controller: controller.animationTabController,
                  onTap: ((value) {
                    controller.animationTabInnerIndex.value = value;

                  }),
                  dividerColor: AppColor.primaryColor,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorPadding:  EdgeInsets.fromLTRB(8.w, 0, 8.w, 8.h),
                  labelPadding: EdgeInsets.only(bottom: 5.h),
                  indicatorColor: AppColor.appSkyBlue,
                  indicatorWeight: 4,
                  labelColor: AppColor.appSkyBlue,
                  unselectedLabelColor: AppColor.hintTextColor,
                  labelStyle: CustomTextStyle.font11R,
                  tabs: [
                    CustomTab(
                      icon: SvgPicture.asset(
                        controller.animationTabInnerIndex.value == 0
                            ? StaticAssets.effectSelected
                            : StaticAssets.effects,
                        height: 25.h,
                      ),
                      text: 'Effects',
                    ),
                    CustomTab(
                      icon: SvgPicture.asset(
                        controller.animationTabInnerIndex.value == 1
                            ? StaticAssets.transitionsSelected
                            : StaticAssets.transitions,
                      ),
                      text: Strings.transitions,
                    ),
                  ],
                ),
              ),
               Expanded(
                  child: TabBarView(
                      controller: controller.animationTabController,
                      children: [
                const SingleChildScrollView(child: SubTabsEffectBoxWidget()),
                SingleChildScrollView(child: SubTabsAnimationBoxWidget(comingFrom: 'title'))
              ]))
            ],
          ),
        ));
  }
}
