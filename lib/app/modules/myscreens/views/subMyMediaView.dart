import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';
import 'package:vloo/app/data/configs/text.dart';
import 'package:vloo/app/data/utils/static_assets.dart';
import 'package:vloo/app/data/utils/strings.dart';
import 'package:vloo/app/data/utils/utils.dart';
import 'package:vloo/app/data/widgets/custom_buttons.dart';
import 'package:vloo/app/modules/myscreens/controllers/myscreens_controller.dart';
import 'package:vloo/app/modules/templates/views/Widget/app_loader.dart';

class SubMyMediaView extends GetView<MyscreensController> {
  const SubMyMediaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Center(
            child: Text(
              Strings.chooseTheMediaToBroadcast,
              style: CustomTextStyle.font20R.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 15.h),
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
                      StaticAssets.icPlus,
                      fit: BoxFit.none,
                    ),
                    Text(
                      Strings.importMedia,
                      style: CustomTextStyle.font16R.copyWith(color: AppColor.appSkyBlue),
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
                  onTap: () {},
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
                              SizedBox(
                                width: 180.w,
                                child: Text(
                                  controller.mediaList[index].name ?? "",
                                  softWrap: true,
                                  style: CustomTextStyle.font14R,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Row(
                              children: [
                                Stack(alignment: Alignment.center, children: [
                                  Utils.getNetworkImage(controller.mediaList[index].thumbnail ?? "", BoxFit.cover, 100, 100),
                                  SvgPicture.asset(
                                    (controller.mediaList[index].type == "Video") ? StaticAssets.icPlay : StaticAssets.icEye,
                                    width: 40.w,
                                    height: 40.h,
                                  ),
                                ]),
                                SizedBox(
                                  width: 20.w,
                                ),
                                CustomButton(
                                  buttonName: Strings.select,
                                  height: 40.h,
                                  width: 140.w,
                                  color: AppColor.appLightBlue,
                                  isbold: false,
                                  borderRadius: 20,
                                  onPressed: () {
                                      controller.addMyScreenContent(mediaID: controller.mediaList[index].id ?? 0);
                                  },
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
    );
  }
}
