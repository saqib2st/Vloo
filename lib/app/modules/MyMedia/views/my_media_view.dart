
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/utils/utils.dart';
import 'package:vloo/app/data/widgets/custom_buttons.dart';
import 'package:vloo/app/data/widgets/custom_row_icon.dart';
import 'package:vloo/app/modules/MyMedia/controllers/my_media_controller.dart';
import 'package:vloo/app/modules/MyMedia/views/options_view_media.dart';
import 'package:vloo/app/modules/templates/views/Widget/app_loader.dart';

import 'upgrade_storage.dart';

class MyMediaView extends GetView<MyMediaController> {
  const MyMediaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColor.primaryColor,
        title:   Text(
          'medias'.tr ?? "",
          style: CustomTextStyle.font20R.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        toolbarHeight: 100.h,
      ),

      body: Container(
        padding:  EdgeInsets.only(top: 30.h),
        child: SmartRefresher(
          reverse: false,
          enablePullDown: true,
          controller: controller.refreshController,
          onRefresh: controller.onRefresh,
          child: Obx(
            () => Column(
              children: [
                GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
                      decoration: BoxDecoration(color: AppColor.appSkyBlue, borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            StaticAssets.icMoviePlay,
                            color: AppColor.appIconBackgound,
                            width: 40.w,
                            height: 40.h,
                            placeholderBuilder: (BuildContext context) => Container(
                                padding: const EdgeInsets.all(30.0),
                                child: const CircularProgressIndicator()),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('videosSlashImages'.tr ?? "", style: CustomTextStyle.font16R.copyWith(color: AppColor.primaryColor, fontWeight: FontWeight.w600)),
                                Text("${controller.usedStorageModel.value.files ?? 0} files", style: CustomTextStyle.font12R.copyWith(color: AppColor.appIconBackgound)),
                                SizedBox(
                                  height: 10.h,
                                ),
                                SizedBox(
                                    width: 100.w,
                                    child: ClipRRect(
                                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                                        child: LinearProgressIndicator(
                                          value: double.tryParse(controller.usedStorageModel.value.percentage ?? "0.0"),
                                          backgroundColor: AppColor.appIconBackgound,
                                          color: AppColor.appLightBlue,
                                        ))),
                                Text('${controller.usedStorageModel.value.usedSpace ?? 0} / ${controller.usedStorageModel.value.totalSpace ?? 0}GB', style: CustomTextStyle.font12R.copyWith(color: AppColor.appIconBackgound)),
                              ],
                            ),
                          ),
                          Column(children: [
                            Text("${controller.usedStorageModel.value.percentage ?? "0.0"}%",
                                style: TextStyle(
                                  color: AppColor.primaryColor,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                )),
                            Text('used',
                                style: TextStyle(
                                  color: AppColor.primaryColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                )),
                          ]),
                        ],
                      ),
                    )),
                SizedBox(height: 5.h),
                GestureDetector(
                    onTap: () {
                      Get.to(const UpgradeStorageView());
                    },
                    child: Text(Strings.buyStorageSpace, textAlign: TextAlign.center, style: CustomTextStyle.font14R.copyWith(decoration: TextDecoration.underline))),
                SizedBox(height: 30.h),
                GestureDetector(
                    onTap: () async {
                      var path = await controller.selectImageFromGallery();

                      AppLoader.showLoader();

                      if (await controller.uploadMediaToServer(path) != null) {
                        controller.onRefresh();
                      }

                      AppLoader.hideLoader();
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 80.w),
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColor.appSkyBlue,
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            StaticAssets.icUpload,
                            fit: BoxFit.none,
                            placeholderBuilder: (BuildContext context) => Container(
                                padding: const EdgeInsets.all(30.0),
                                child: const CircularProgressIndicator()),
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            'Add media',
                            style: CustomTextStyle.font16R.copyWith(color: AppColor.appSkyBlue, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )),
                SizedBox(
                  height: 30.h,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: controller.mediaList.length,
                      itemBuilder: (BuildContext context, int index) => GestureDetector(
                        onTap: () async {
                          controller.getMyMediaDetailsList(controller.mediaList[index].id.toString());
                          await Get.to(OptionsViewMedia(
                            mediaModel: controller.mediaList[index],
                          ));
                          controller.onRefresh();
                        },
                        child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 8.h),
                            padding: EdgeInsets.only(left: 22.w, right: 22.w, top: 20.h, bottom: 20.h),
                            decoration: BoxDecoration(border: Border.all(color: AppColor.appLightBlue), borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CustomButton(
                                      buttonName: controller.mediaList[index].type ?? "",
                                      height: 30.h,
                                      width: 80.w,
                                      textColor: AppColor.appLightBlue,
                                      isbold: true,
                                      borderRadius: 8,
                                      backgroundColor: AppColor.appLightBlue,
                                      onPressed: () {},
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        width: 180.w,
                                        child: Text(
                                          controller.mediaList[index].name ?? "",
                                          softWrap: true,
                                          style: CustomTextStyle.font14R,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    SvgPicture.asset(
                                      StaticAssets.tvSimple,
                                      width: 15.w,
                                      height: 15.h,
                                      fit: BoxFit.fill,
                                      color: Colors.green,
                                      placeholderBuilder: (BuildContext context) => Container(
                                          padding: const EdgeInsets.all(30.0),
                                          child: const CircularProgressIndicator()),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Stack(alignment: Alignment.center, children: [
                                        Utils.getNetworkImage(controller.mediaList[index].thumbnail ?? "", BoxFit.cover, 100, 100),

                                        if(controller.mediaList[index].type == "Video")
                                          SvgPicture.asset(
                                            StaticAssets.icPlay,
                                            width: 40.w,
                                            height: 40.h,
                                            placeholderBuilder: (BuildContext context) => Container(
                                                padding: const EdgeInsets.all(30.0),
                                                child: const CircularProgressIndicator()),
                                          ),
                                      ]),
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            if (controller.mediaList[index].duration?.isNotEmpty == true)
                                              CustomRowIcon(
                                                text: controller.mediaList[index].duration ?? "",
                                                logoAsset: StaticAssets.icClock,
                                              ),
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  StaticAssets.icCalendar,
                                                  width: 20.w,
                                                  height: 20.h,
                                                  placeholderBuilder: (BuildContext context) => Container(
                                                      padding: const EdgeInsets.all(30.0),
                                                      child: const CircularProgressIndicator()),
                                                  fit: BoxFit.fill,
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    'created on ${Utils.getDateInFormat(controller.mediaList[index].createdAt ?? "", "yyyy-MM-ddThh:mm:ss.000000Z", "dd/MM/yyyy")}',
                                                    textAlign: TextAlign.center,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 11.sp,
                                                        fontFamily: 'Poppins',
                                                        color: AppColor.appLightBlue),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            CustomRowIcon(
                                              text: controller.mediaList[index].filesize ?? "",
                                              logoAsset: StaticAssets.fileIcon,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
