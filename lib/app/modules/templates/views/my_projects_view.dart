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
import '../controllers/templates_controller.dart';

class MyProjectView extends GetView<TemplatesController> {
  const MyProjectView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Column(
          children: [
            Text(
              'myProjects'.tr,
              style: CustomTextStyle.font22R.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 100.h,
      ),
      backgroundColor: AppColor.primaryColor,
      body: SmartRefresher(
        reverse: false,
        enablePullDown: true,
        controller: controller.refreshControllerMyProjects,
        onRefresh: controller.onRefresh,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: 20.w),
          physics: const ScrollPhysics(),
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                      () => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: controller.toBlankTemplate,
                          child: SvgPicture.asset(
                            StaticAssets.plusIcon,
                            width: 50.w,
                            height: 50.h,
                            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                          ),
                        ),
                        SizedBox(
                          width: 31.w,
                        ),
                        Column(
                          children: [
                            SvgPicture.asset(
                              StaticAssets.screensIcon,
                              fit: BoxFit.none,
                            ),
                            Text(
                              '${controller.liveTemplateCount} ${Strings.projects}',
                              style: CustomTextStyle.font12R.copyWith(color: AppColor.primaryGreen),
                            ),
                            Text(Strings.inDiffusion, style: CustomTextStyle.font12R),
                          ],
                        ),
                        SizedBox(
                          width: 31.w,
                        ),
                        Column(
                          children: [
                            SvgPicture.asset(
                              StaticAssets.icBrush,
                              fit: BoxFit.none,
                            ),
                            Text(
                              '${controller.savedTemplateCount} ${Strings.projects}',
                              style: CustomTextStyle.font12R.copyWith(color: AppColor.appSkyBlue),
                            ),
                            Text('/ ${controller.totalTemplateCount} ${Strings.available}', style: CustomTextStyle.font12R),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                if (controller.templateList.isNotEmpty) ...[
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
                          onTap: () {
                            /* Get.put(EditTemplateController());
                          Get.to(EditTemplateView(templateModel: controller.fetchFilteredList("Portrait")?[index]));*/

                            controller.toCreateTemplateView(OrientationType.Portrait.name, Strings.editTemplate, controller.fetchFilteredList("Portrait")?[index]);
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
                      height: 160.h,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.fetchFilteredList("Landscape")?.length,
                        itemBuilder: (BuildContext context, int index) => GestureDetector(
                          onTap: () {
                            //Get.put(EditTemplateController());
                            // controller.fetchFilteredList("Landscape")?[index].orientation == 'Landscape'?
                            // Get.to(EditTemplateViewLandScape(templateModel: controller.fetchFilteredList("Landscape")?[index])) : Get.to(EditTemplateView(templateModel: controller.fetchFilteredList("Portrait")?[index]));

                            controller.toCreateTemplateViewLandScape(OrientationType.Landscape.name, Strings.editTemplate, controller.fetchFilteredList("Landscape")?[index]);
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
                ],
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
