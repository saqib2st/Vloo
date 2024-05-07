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
import 'package:vloo/app/modules/addScreen/controllers/add_screen_controller.dart';
import 'package:vloo/app/modules/addScreen/views/choose_screen.dart';
import 'package:vloo/app/modules/myscreens/controllers/myscreens_controller.dart';
import 'package:vloo/app/modules/myscreens/views/configurationScreen.dart';
import 'package:vloo/app/modules/templates/views/Widget/app_loader.dart';

class MyScreensView extends GetView<MyscreensController> {
  const MyScreensView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 3.5;
    final double itemWidth = size.width / 2;

    return Scaffold(
        backgroundColor: AppColor.primaryColor,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: Text(
            'myScreens'.tr,
            style:
                CustomTextStyle.font22R.copyWith(fontWeight: FontWeight.bold),
          ),
          backgroundColor: AppColor.primaryColor,
          centerTitle: true,
          elevation: 0,
          toolbarHeight: 100.h,
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 15.0.w, right: 15.0.w, top: 20.h),
          child: Obx(
            () => Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Get.to(const AddScreenView());

                          AppLoader.hideLoader();
                          Get.put(AddScreenController());
                          Get.to(() => const ChooseScreenView());
                        },
                        child: SvgPicture.asset(
                          StaticAssets.plusIcon,
                          width: 50.w,
                          height: 50.h,
                          colorFilter: const ColorFilter.mode(
                              Colors.white, BlendMode.srcIn),
                        ),
                      ),
                      SizedBox(
                        width: 25.w,
                      ),
                      Column(
                        children: [
                          SvgPicture.asset(
                            StaticAssets.tvCheck,
                            width: 40.w,
                            height: 40.h,
                            fit: BoxFit.fill,
                          ),
                          Text(
                            '${controller.connectedScreens} ${Strings.screens}',
                            style: CustomTextStyle.font12R,
                          ),
                          Text('connected'.tr,
                              style: CustomTextStyle.font12R
                                  .copyWith(color: AppColor.primaryGreen)),
                        ],
                      ),
                      SizedBox(
                        width: 25.w,
                      ),
                      Column(
                        children: [
                          SvgPicture.asset(
                            StaticAssets.tvClose,
                            width: 40.w,
                            height: 40.h,
                            fit: BoxFit.fill,
                          ),
                          Text(
                              '${controller.offlineScreens} ${Strings.screens}',
                              style: CustomTextStyle.font12R),
                          Text('offline'.tr,
                              style: CustomTextStyle.font12R
                                  .copyWith(color: AppColor.red)),
                        ],
                      ),
                      SizedBox(
                        width: 25.w,
                      ),
                      Column(
                        children: [
                          SvgPicture.asset(
                            StaticAssets.tvInfo,
                            width: 40.w,
                            height: 40.h,
                            fit: BoxFit.fill,
                          ),
                          Text(
                              '${controller.withoutContentScreens} ${Strings.screens}',
                              style: CustomTextStyle.font12R),
                          Text(
                            'withoutContent'.tr,
                            style: CustomTextStyle.font12R
                                .copyWith(color: AppColor.appSkyBlue),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text(
                    'myScreensHeading'.tr,
                    style: CustomTextStyle.font18R
                        .copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Expanded(
                  child: SmartRefresher(
                    reverse: false,
                    enablePullDown: true,
                    controller: controller.refreshController,
                    onRefresh: controller.onRefresh,
                    child: GridView(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        // childAspectRatio: (itemWidth / itemHeight)
                      ),
                      children: <Widget>[
                        ...List.generate(controller.screenList.length, (index) {
                          return GestureDetector(
                            onTap: () async {
                              AppLoader.hideLoader();
                              controller.setSelectedScreenModel(
                                  controller.screenList[index]);
                              await Get.to(const ConfigurationScreen());
                              controller.onRefresh();
                            },
                            child: Container(
                              margin: const EdgeInsets.all(5.0),
                              padding: EdgeInsets.only(
                                  left: 10.w, right: 10.w, top: 20.h),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color:
                                          controller.screenList[index].status ==
                                                  Status.Offline.name
                                              ? AppColor.red
                                              : AppColor.primaryGreen),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (controller
                                              .screenList[index].uploadMedias !=
                                          null &&
                                      controller.screenList[index].uploadMedias!
                                          .isNotEmpty) ...[
                                    Utils.getNetworkImage(
                                        controller.screenList[index]
                                                .uploadMedias?[0].thumbnail ??
                                            "",
                                        BoxFit.cover,
                                        Get.width,
                                        itemHeight * 0.45),
                                  ] else ...[
                                    Utils.getNetworkImage(
                                        controller.screenList[index].title ??
                                            "", // TODO: will be changed with original url
                                        BoxFit.cover,
                                        Get.width,
                                        itemHeight * 0.45),
                                  ],
                                  SizedBox(height: 10.h),
                                  Text(
                                    controller.screenList[index].title ?? "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: CustomTextStyle.font14R.copyWith(
                                        color: AppColor.appSkyBlue,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          '${controller.screenList[index].orientation} • ' ??
                                              "",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: CustomTextStyle.font11R
                                              .copyWith(
                                                  color: AppColor.appLightBlue,
                                                  fontWeight: FontWeight.w500)),
                                      Text(
                                          controller.screenList[index].status ??
                                              "",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: CustomTextStyle.font11R
                                              .copyWith(
                                                  color: controller
                                                              .screenList[index]
                                                              .status ==
                                                          Status.Offline.name
                                                      ? AppColor.red
                                                      : AppColor.primaryGreen,
                                                  fontWeight: FontWeight.w500))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

enum Status {
  Offline,
}
