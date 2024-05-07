import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/utils/utils.dart';
import 'package:vloo/app/modules/bottomNav/controllers/bottom_nav_controller.dart';
import '../../../data/models/template/Template.dart';
import '../controllers/templates_controller.dart';

class TemplatesView extends GetView<TemplatesController> {
  const TemplatesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Padding(
          padding: EdgeInsets.only(top: 50.h),
          child: SvgPicture.asset(
            StaticAssets.vlooLogo,
            height: 39.h,
            width: 130.w,
          ),
        ),
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 100.h,
      ),
      backgroundColor: AppColor.primaryColor,
      body: Padding(
        padding: EdgeInsets.only(left: 20.w),
        child: SmartRefresher(
          reverse: false,
          enablePullDown: true,
          controller: controller.refreshController,
          onRefresh: controller.onRefresh,
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Obx(
              () => Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (controller.templateList.value.isNotEmpty) ...[
                    // Handling of if condition with multiple widgets
                    SizedBox(height: 30.h),
                    Text(
                      'portraitModelVertical'.tr,
                      textAlign: TextAlign.start,
                      style: CustomTextStyle.font16L.copyWith(
                        color: AppColor.appLightBlue,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    if (controller.fetchFilteredList("Portrait") != null && controller.fetchFilteredList("Portrait")!.isNotEmpty) ...[
                      SizedBox(
                        height: 280.h,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.fetchFilteredList("Portrait")?.length,
                          itemBuilder: (BuildContext context, int index) => GestureDetector(
                            onTap: ()  async {
                              if (await controller.storage.read(Strings.userEmail) != 'templateadmin@vloo.com') {
                                controller.openDuplicateProject(index);
                              }else{
                                controller.toCreateTemplateView(OrientationType.Portrait.name, Strings.editTemplate, controller.fetchFilteredList("Portrait")?[index]);
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 15.w),
                              decoration: BoxDecoration(border: Border.all(color: AppColor.appLightBlue)),
                              child: Utils.getNetworkImage(controller.fetchFilteredList("Portrait")?[index].featureImg as String, BoxFit.cover, 160.w, 280.h),
                            ),
                          ),
                        ),
                      ),
                    ] else ...[
                      SizedBox(
                        height: 280.h,
                        child: Center(
                          child: Text(
                            Strings.noPortraitTemplateYet,
                            style: CustomTextStyle.font20R.copyWith(
                              color: AppColor.red,
                            ),
                          ),
                        ),
                      ),
                    ],
                    SizedBox(height: 20.h),
                    Text(
                      'portraitModelHorizontal'.tr,
                      textAlign: TextAlign.start,
                      style: CustomTextStyle.font16L.copyWith(
                        color: AppColor.appLightBlue,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    if (controller.fetchFilteredList("Landscape") != null && controller.fetchFilteredList("Landscape")!.isNotEmpty) ...[
                      SizedBox(
                        height: 170.h,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.fetchFilteredList("Landscape")?.length,
                          itemBuilder: (BuildContext context, int index) => GestureDetector(
                            onTap: () async {
                              if(await controller.storage.read(Strings.userEmail) != 'templateadmin@vloo.com') {
                                controller.openDuplicateProjectLandscape(index);
                              }
                              else {
                                controller.toCreateTemplateViewLandScape(OrientationType.Landscape.name, Strings.editTemplate, controller.fetchFilteredList("Landscape")?[index]);
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 15.w),
                              decoration: BoxDecoration(border: Border.all(color: AppColor.appLightBlue)),
                              child: Utils.getNetworkImage(controller.fetchFilteredList("Landscape")?[index].featureImg.toString() ?? "", BoxFit.fitHeight, 250.w, 100.h),
                            ),
                          ),
                        ),
                      ),
                    ] else ...[
                      SizedBox(
                        height: 170.h,
                        child: Center(
                          child: Text(
                            Strings.noLandscapeTemplateYet,
                            style: CustomTextStyle.font20R.copyWith(
                              color: AppColor.red,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ] else ...[
                    SizedBox(height: 30.h),
                    Text(
                      'portraitModelVertical'.tr,
                      textAlign: TextAlign.start,
                      style: CustomTextStyle.font16L.copyWith(
                        color: AppColor.appLightBlue,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    SizedBox(
                      height: 280.h,
                      child: Center(
                        child: Text(
                          Strings.noPortraitTemplateYet,
                          style: CustomTextStyle.font20R.copyWith(
                            color: AppColor.red,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'portraitModelHorizontal'.tr,
                      textAlign: TextAlign.start,
                      style: CustomTextStyle.font16L.copyWith(
                        color: AppColor.appLightBlue,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    SizedBox(
                      height: 170.h,
                      child: Center(
                        child: Text(
                          Strings.noLandscapeTemplateYet,
                          style: CustomTextStyle.font20R.copyWith(
                            color: AppColor.red,
                          ),
                        ),
                      ),
                    ),
                    /* Text(
                    Strings.notTemplateYet,
                    style: CustomTextStyle.font20R.copyWith(
                      color: AppColor.appLightBlue,
                    ),
                  ),*/
                  ],
                  SizedBox(height: 30.h),
                  GestureDetector(
                    onTap: controller.toBlankTemplate,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          StaticAssets.plusIcon,
                          width: 40.w,
                          height: 40.h,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'blankTemplate'.tr,
                          style: CustomTextStyle.font16L.copyWith(
                            color: AppColor.secondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
